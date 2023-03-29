#!/bin/bash

date="$(date "+%d-%m-%Y_%H:%M:%S")"
pid="$XDG_RUNTIME_DIR/recordingpid"
recordings="$HOME/Documents/Music/recordings"

_updateicon() { echo "$1" >"$XDG_RUNTIME_DIR"/recordingicon; }

# only audio from mic (webcam)
_audio_input() {
    amixer set Capture,0 80%,80% unmute cap >/dev/null 2>&1
    polybar-msg action "#mic-ipc.hook.1" >/dev/null 2>&1
    ffmpeg -f pulse \
        -i 1 \
        -map '0' \
        -c:a mp3 \
        "$recordings"/audio-input_"$date".mp3 &
    echo $! >"$pid"
    _updateicon ""
    polybar-msg action "#recording-ipc-2.hook.0" >/dev/null 2>&1
    record_chrono 2
}

# records what we hear from the speakers.
# prompt to choose between four output formats.
_audio_output() {
    local audioformat
    audioformat=$(printf "flac\\nmp3\\nogg\\nwav\\nQUIT" |
        rofi -normal-window -dmenu -i -width 20 -hide-scrollbar \
            -line-padding 4 -padding 20 -lines 5 -p 'Select an audio format')

    _format_flac() (
        ffmpeg -f pulse \
            -i 2 \
            -map '0' \
            -af aformat=s32:48000 \
            "$recordings"/audio-output_"$date".flac &
        echo $! >"$pid"
        _updateicon ""
        polybar-msg action "#recording-ipc-2.hook.0" >/dev/null 2>&1
        record_chrono 2
    )

    _format_mp3() (
        ffmpeg -f pulse \
            -i 2 \
            -map '0' \
            -acodec libmp3lame \
            -ar 48000 \
            -ab 320k \
            "$recordings"/audio-output_"$date".mp3 &
        echo $! >"$pid"
        _updateicon ""
        polybar-msg action "#recording-ipc-2.hook.0" >/dev/null 2>&1
        record_chrono 2
    )

    _format_ogg() (
        ffmpeg -f pulse \
            -i 2 \
            -map '0' \
            -acodec libvorbis \
            -ar 48000 \
            -ab 320k \
            "$recordings"/audio-output_"$date".ogg &
        echo $! >"$pid"
        _updateicon ""
        polybar-msg action "#recording-ipc-2.hook.0" >/dev/null 2>&1
        record_chrono 2
    )

    _format_wav() (
        ffmpeg -f pulse \
            -i 2 \
            -map '0' \
            -acodec pcm_s32le -ar 48000 \
            "$recordings"/audio-output_"$date".wav &
        echo $! >"$pid"
        _updateicon ""
        polybar-msg action "#recording-ipc-2.hook.0" >/dev/null 2>&1
        record_chrono 2
    )

    case "$audioformat" in
        flac) _format_flac ;;
        mp3) _format_mp3 ;;
        ogg) _format_ogg ;;
        wav) _format_wav ;;
        QUIT) exit ;;
    esac

}

_killrecording() {
    killall -q ffmpeg
    rm -f "$pid"
    _updateicon ""
    kill -KILL "$(pgrep --full "record_chrono")"
    # polybar clears icons (update with "nothing").
    polybar-msg action "#recording-ipc-1.hook.1" >/dev/null 2>&1
    sleep 0.5
    polybar-msg action "#chrono-ipc-1.hook.1" >/dev/null 2>&1
    sleep 0.5
    polybar-msg action "#recording-ipc-2.hook.1" >/dev/null 2>&1
    sleep 0.5
    polybar-msg action "#chrono-ipc-2.hook.1" >/dev/null 2>&1
    sleep 0.5
    polybar-msg action "#recording-ipc-3.hook.1" >/dev/null 2>&1
    sleep 0.5
    polybar-msg action "#chrono-ipc-3.hook.1" >/dev/null 2>&1

    amixer set Capture,0 0%,0% mute nocap >/dev/null 2>&1
    polybar-msg action "#mic-ipc.hook.0" >/dev/null 2>&1
    exit
}

_asktoend() {
    local response
    response=$(printf "No\\nYes" |
        rofi -normal-window -dmenu -i -width 15 -hide-scrollbar \
            -line-padding 4 -padding 20 -lines 2 -p 'End recording?') &&
        [[ $response = "Yes" ]] && _killrecording
}

_askrecording() {
    local type
    type=$(printf "mic\\noutput\\nQUIT" |
        rofi -normal-window -dmenu -i \
            -width 20 -hide-scrollbar -line-padding 4 -padding 20 \
            -lines 3 -p 'Select a recording type')
    case "$type" in
        mic) _audio_input ;;
        output) _audio_output ;;
        QUIT) exit ;;
    esac
}

_if_pid() {
    if [[ -f ${pid} ]]; then
        _asktoend
    else
        _askrecording
    fi
}

[[ -z $(command -v ffmpeg) ]] && {
    notify-send 'ERROR: this program requires "ffmpeg" installed'
    exit 127
}

[[ ! -d "$recordings" ]] && mkdir -p "$recordings"

_if_pid
