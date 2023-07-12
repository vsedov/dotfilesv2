import dbus

session_bus = dbus.SessionBus()

try:
    spotify_bus = session_bus.get_object("org.mpris.MediaPlayer2.youtube-music", "/org/mpris/MediaPlayer2")
    spotify_properties = dbus.Interface(spotify_bus, "org.freedesktop.DBus.Properties")
    metadata = spotify_properties.Get("org.mpris.MediaPlayer2.Player", "Metadata")

    artist = metadata['xesam:artist'][0]
    title = metadata['xesam:title']
    artisttitle = (f" {artist} - {title}")#[:150]
  # if len(artisttitle) == 45:
  #     print(artisttitle+"... ")
  # else:
    print(f"{artisttitle} ")
except:
    print("")
