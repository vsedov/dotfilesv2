import subprocess

import i3ipc
import pulsectl

# Get a list of all running instances of the "waterfox" browser
processes = (
    subprocess.check_output(["pgrep", "-f", "waterfox"])
    .decode("utf-8")
    .strip()
    .split("\n")
)

# Connect to the PulseAudio server
pulse = pulsectl.Pulse("music-player-workspace-switcher")

# Find the current audio source that is playing
sink = pulse.sink_list()[0]
current_source = None
for source in pulse.source_list():
    if source.name == "alsa_output.pci-0000_00_1f.3.iec958-stereo.monitor":
        current_source = source
        break

# Get the workspace where the audio source is being played
i3 = i3ipc.Connection()
target_workspace = None
for si in pulse.sink_input_list():
    if si.name == str(current_source.index):
        print(si.client)

        for node in i3.get_tree():
            if node.window_class == "waterfox" and node.id == str(si.client):
                if str(si.client) in processes:
                    target_workspace = node.workspace()
                    break
        break


# Switch to the workspace where the audio source is being played
if target_workspace is not None:
    i3.command("workspace", target_workspace.name)
