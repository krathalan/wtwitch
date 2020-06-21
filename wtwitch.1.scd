wtwitch(1) ["Version 1.7"]

# NAME

wtwitch - terminal user interface for Twitch

# SYNOPSIS

wtwitch [*(no option)* _streamer_|*-t*|*-g* _game_|*-s* _streamer_|*-u* _streamer_|*-c*|*-p* _player_|*-q* _quality_|*-l*|*-d*|*-v*]

# DESCRIPTION

Wtwitch is a terminal program that uses the Twitch API and the streamlink package to provide Twitch browsing, subscription, and playback functionality without signing up for a Twitch account, and without loading or executing Twitch's proprietary JavaScript.

# OPTIONS

## Viewing and browsing streams

*(no option)* _streamer_++
    Watch the specified _streamer_.++
    e.g. wtwitch _overwatchleague_

*-t*, *--top*++
    View the top games and streams on Twitch.++
    e.g. wtwitch *-t*

*-g* _game_, *--get-streamers=*_game_++
    View the top streamers for a specified _game_. Game names with spaces must be quoted, or the spaces must be escaped with \\.++
    e.g. wtwitch *-g* _"world of warcraft"_++
    e.g. wtwitch *-g* _world\\ of\\ warcraft_

*-b* streamer, *--blacklist=*_streamer_++
    Blacklist a specified _streamer_, preventing them from being listed in any output.++
    If the streamer is already blacklisted, blacklisting them again will remove them from the blacklist.++
    Use *-b* without specifying a streamer to list your blacklist.++
    e.g. wtwitch *-b* _overwatchleague_++
    e.g. wtwitch *-b*

## Subscriptions

*-s* _streamer_, *--subscribe=*_streamer_++
    Subscribe to a specific _streamer_.++
    e.g. wtwitch *-s* _overwatchleague_

*-u* _streamer_, *--unsubscribe=*_streamer_++
    Unsubscribe from a specified _streamer_.++
    e.g. wtwitch *-u* _overwatchleague_

*-c*, *--check*++
    View your settings and the status of the streamers you are subscribed to.++
    e.g. wtwitch *-c*

## Configuration options

*-p* _player_, *--change-player=*_player_++
    Change the default _player_ that gets passed to Streamlink.++
    e.g. wtwitch *-p* _vlc_

*-q* _quality_, *--change-quality=*_quality_++
    Change the default _quality_ that gets passed to Streamlink. 1080p60, 720p60, 720p, 480p, 360p, 160p, best, worst, and audio_only are acceptable qualities. You can specify fallback qualities separated by a comma.++
    e.g. wtwitch *-q* _720p60,720p,best_

*-l*, *--toggle-colors*++
    Toggle the usage of colors in wtwitch output.++
    e.g. wtwitch *-l*

## Miscellaneous

*-d*, *--debug*++
    Run the program in debug mode, avoiding subshells and printing each command processed. The debug flag must come after the command you are trying to take a log of. You should also probably redirect all output to a _log file_:++
    e.g. wtwitch -c *-d* _&> debug.log_

*-v*, *--version*++
    Print the version of wtwitch.++
    e.g. wtwitch *-v*

# DEFAULT BEHAVIOR

## Player

Wtwitch will tell Streamlink to use mpv by default. Wtwitch favors mpv because mpv supports Wayland, and the author of this program has also written an AppArmor profile for mpv (https://git.sr.ht/~krathalan/apparmor-profiles). Mpv also supports custom window titles, like "Watching overwatchleague on Twitch (1080p 60.000fps)". Wtwitch will use VLC automatically if you have VLC installed and don't have mpv installed.

You can set which video player you'd like wtwitch to pass to Streamlink with wtwitch *-p* _player_. You can pass any player you'd pass to Streamlink, and wtwitch will make sure the player you're trying to set as the default player is installed.

## Quality

Wtwitch tells Streamlink to choose the "best" quality by default. You can set which quality you'd like wtwitch to pass to Streamlink with wtwitch *-q* _quality_. You can pass any quality you'd pass to Streamlink, even fallback qualities (like "720p,480p,worst"), and wtwitch will make sure your input is valid.

## Miscellaneous

Wtwitch tells Streamlink to bypass Twitch ads. If you want to support a streamer, consider donating to them directly rather than subscribing to them on Twitch, as Twitch takes 50% of the subscription fee.

## Caching

To reduce strain on the Twitch API, the output of wtwitch *-c* is kept in the cache directory. The cached response stays valid for up to 60 seconds or until you subscribe to, unsubscribe from, or blacklist a streamer. The last cache update time is stored in the configuration file. If you really want to refresh the cache, simply delete the cache directory before invoking wtwitch *-c*.

For the same reason, every game ID/game name pair fetched from the Twitch API is also stored in the cache directory. However, this cache file does not expire.

# FILES

Wtwitch supports the XDG Base Directory specification. If your $XDG_CONFIG_HOME and $XDG_CACHE_HOME are their default values (~/.config and ~/.cache respectively), the configuration file and blacklist file is at ~/.config/wtwitch/config.json and cache files are kept in ~/.cache/wtwitch.

You should never need to edit these files manually; you should use the options listed under *OPTIONS* above.

# SYNCING SUBSCRIPTIONS

Wtwitch does not natively support syncing subscriptions across computers, but syncing subscriptions can be achieved easily using Syncthing and a utility already installed on your GNU/Linux computer. Syncthing is a powerful synchronization program for multiple operating systems licensed under the Mozilla Public License v2, which is FSF approved. You can look at Syncthing's homepage for more information, as well as their user documentation:

https://docs.syncthing.net/intro/getting-started.html

After setting up Syncthing on the computers on which you wish to sync subscriptions, copy your subscriptions file from ~/.config/wtwitch/config.json to a directory that you are syncing with Syncthing. Then link the file to the previous location. For example, if you copied your subscriptions file to ~/Documents/Config, you can link it to the correct location with the command:

ln -sf ~/Documents/Config/config.json ~/.config/wtwitch/config.json

# CHANGELOG

View the wtwitch changelog with the command:

pacman -Qc wtwitch

# LANGUAGES

Wtwitch fully supports English and has nearly-complete support for German/Deutsch and Spanish/Español. User-contributed translations are welcome!

# BUGS

Please file requests and report any bugs at: https://todo.sr.ht/~krathalan/wtwitch

Alternatively, you may send them via email to: ~krathalan/wtwitch@todo.sr.ht

# LICENSES

Wtwitch itself is licensed under the GPLv3.

## Dependencies

jq is licensed under the MIT license.

Streamlink is licensed under the 2-clause BSD license.

Wget is licensed under the GPLv3.

VLC and mpv, should you choose either as your player, are both licensed under both the GPLv2 and LGPLv2.1 licenses.

All licenses, for wtwitch itself and its dependencies, are FSF approved: https://www.gnu.org/licenses/license-list.html
