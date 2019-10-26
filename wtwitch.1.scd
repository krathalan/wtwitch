wtwitch(1) ["Version 1.1.1"]

# NAME

wtwitch - terminal user interface for Twitch

# SYNOPSIS

wtwitch [*(no option)* _streamer_|*-t*|*-g* _game_|*-s* _streamer_|*-u* _streamer_|*-c*|*-p* _player_|*-q* _quality_|*-l*|*-d*|*-v*]

# DESCRIPTION 

Wtwitch is a terminal program that uses the Twitch API and the streamlink package to provide Twitch browsing, subscription, and playback functionality without signing up for a Twitch account, and without loading or executing Twitch's proprietary JavaScript.

# DEFAULT BEHAVIOR

## Player

Wtwitch will tell Streamlink to use mpv by default. Wtwitch favors mpv because mpv supports Wayland, and the author of this program has also written an AppArmor profile for mpv (https://git.sr.ht/~krathalan/apparmor-profiles). Mpv also supports custom window titles, like "Watching overwatchleague on Twitch (1080p 60.000fps)". Wtwitch will use VLC automatically if you have VLC installed and don't have mpv installed.

You can set which video player you'd like wtwitch to pass to Streamlink with wtwitch *-p* _player_. You can pass any player you'd pass to Streamlink, and wtwitch will make sure the player you're trying to set as the default player is installed.

## Quality

Wtwitch tells Streamlink to choose the "best" quality by default. You can set which quality you'd like wtwitch to pass to Streamlink with wtwitch *-q* _quality_. You can pass any quality you'd pass to Streamlink, even fallback qualities (like "720p,480p,worst"), and wtwitch will make sure your input is valid.

## Miscellaneous

Wtwitch tells Streamlink to bypass Twitch ads. If you want to support a streamer, consider donating to them directly rather than subscribing to them on Twitch, as Twitch takes 50% of the subscription fee.

## Caching

To reduce strain on the Twitch API, the output of wtwitch *-c* is kept in the cache directory. The cached response stays valid for up to 60 seconds or until you subscribe to or unsubscribe from a streamer. The last cache update time is stored in the configuration file. If you really want to refresh the cache, simply delete the cache directory before invoking wtwitch *-c*.

See *FILES* below for the path of the cache directory.

# OPTIONS

## Viewing and browsing streams

*(no option)* _streamer_++
    Watch the specified _streamer_, e.g. wtwitch _overwatchleague_

*-t*, *--top-games*++
    View the top games on Twitch, e.g. wtwitch *-t*

*-g* _game_, **--get-streamers**=_game_++
    View the top streamers for a specified _game_, e.g. wtwitch *-g* _"world of warcraft"_. Game names with spaces must be quoted.

## Subscriptions

*-s* _streamer_, **--subscribe=**_streamer_++
    Subscribe to a specific _streamer_, e.g. wtwitch *-s* _overwatchleague_

*-u* _streamer_, **--unsubscribe=**_streamer_++
    Unsubscribe from a specified _streamer_, e.g. wtwitch *-u* _overwatchleague_

*-c*, *--check*++
    View your settings and the status of the streamers you are subscribed to, e.g. wtwitch *-c*

## Configuration options

*-p* _player_, **--change-player=**_player_++
    Change the default _player_ in ~/.config/wtwitch/config.json that gets passed to Streamlink, e.g. wtwitch *-p* _vlc_

*-q* _quality_, **--change-quality=**_quality_++
    Change the default _quality_ that gets passed to Streamlink. 1080p60, 720p60, 720p, 480p, 360p, 160p, best, and worst are acceptable qualities. You can specify fallback qualities separated by a comma, e.g. wtwitch *-q* _"720p,480p"_

*-l*, *--toggle-colors*++
    Toggle the usage of colors in wtwitch output.

## Miscellaneous

*-d*, *--debug*++
    Run the program in debug mode, avoiding subshells and printing each command processed.++
    If you do this you should probably redirect all output to a log file, e.g. wtwitch -c *-d* _&> debug.log_

*-v*, *--version*++
    Print the version of wtwitch.

# FILES

The configuration file is at ~/.config/wtwitch/config.json. Cache files are kept in ~/.cache/wtwitch.

You should never need to edit these files; you should use the options listed above. However you may easily edit them manually.

# SYNCING SUBSCRIPTIONS

Wtwitch does not natively support syncing subscriptions across computers, but syncing subscriptions can be achieved easily using Syncthing and a utility already installed on your GNU/Linux computer. Syncthing is a powerful synchronization program for multiple operating systems licensed under the Mozilla Public License v2, which is FSF approved. You can look at Syncthing's homepage for more information, as well as their user documentation: 

https://docs.syncthing.net/intro/getting-started.html

After setting up Syncthing on the computers on which you wish to sync subscriptions, copy your subscriptions file from ~/.config/wtwitch/config.json to a directory that you are syncing with Syncthing. Then link the file to the previous location. For example, if you copied your subscriptions file to ~/Documents/Config, you can link it to the correct location with the command:

ln -sf ~/Documents/Config/config.json ~/.config/wtwitch/config.json

# CHANGELOG

View the wtwitch changelog with the command:

pacman -Qc wtwitch

# BUGS

Please file requests and report any bugs at: https://todo.sr.ht/~krathalan/wtwitch

Alternatively, you may send them via email to: `~krathalan/wtwitch@todo.sr.ht`

# LICENSES

Wtwitch itself is licensed under the GPLv3.

## Dependencies

jq is licensed under the MIT license.

Streamlink is licensed under the 2-clause BSD license.

Wget is licensed under the GPLv3.

VLC and mpv, should you choose either as your player, are both licensed under both the GPLv2 and LGPLv2.1 licenses.

All licenses, for wtwitch itself and its dependencies, are FSF approved: https://www.gnu.org/licenses/license-list.html
