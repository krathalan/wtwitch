# wtwitch
A terminal-based Twitch app. Watch Twitch without proprietary JavaScript and without being tracked.

Wtwitch will tell Streamlink to use GNOME MPV. If GNOME MPV is not installed, wtwitch will tell Streamlink to use VLC -- the default Streamlink player. Wtwitch favors GNOME MPV because GNOME MPV supports [Wayland](https://wayland.freedesktop.org/), whereas VLC does not (yet).

Usage of a config file ~~should be coming soon~~ IS HERE! And it makes customizing the script much easier. The configuration file is located at `~/.config/wtwitch/config.json`. It should rarely take more than a few kilobytes of space (dependent on how many streamers you're subscribed to), at most.

You can make wtwitch executable with the command `chmod a+x wtwitch`. Additionally, you can [add the script to your $PATH](https://stackoverflow.com/questions/20054538/add-a-bash-script-to-path). Using both, you can use the command `wtwitch` in any directory in your terminal, instead of having to type `bash wtwitch [OPTION] [ARG]` in the directory the script is in every time.

## Dependencies
You must have [Streamlink](https://streamlink.github.io/) and [jq](https://stedolan.github.io/jq/) installed. You can install both on Fedora with the command `sudo dnf install -y python3-streamlink jq`.

[Streamlink is licensed under the 2-clause BSD license](https://github.com/streamlink/streamlink/blob/master/LICENSE), which is [FSF approved](https://www.gnu.org/licenses/license-list.en.html#FreeBSD). [jq is licensed under the MIT license (which is technically the Expat license)](https://en.wikipedia.org/wiki/MIT_License#Variants), which is [FSF approved](https://www.gnu.org/licenses/license-list.en.html#Expat).

## Usage
`bash wtwitch [OPTION] [ARG]`

Option | Description | Example
--- | --- | ---
-h, --help | show brief help | `bash wtwitch -h`
(no option) [STREAMER] | watch the specified streamer | `bash wtwitch overwatchleague`
-c, --check | view which subscribed Twitch streams are online | `bash wtwitch -c`
-g [GAME], --get-streamers=[GAME] | view the top streamers for a specified game | `bash wtwitch -g "world of warcraft"`
-p [PLAYER], --player=[PLAYER] | changes the default player in `~/.config/wtwitch/config.json` that gets passed to Streamlink | `bash wtwitch -p gnome-mpv`
-s [STREAMER], --subscribe=[STREAMER] | subscribes to a specific streamer | `bash wtwitch -s overwatchleague`
-t, --top-games | lists the top games on twitch | `bash wtwitch -t`
-u [STREAMER], --unsubscribe=[STREAMER] | unsubscribes from a specified streamer | `bash wtwitch -u overwatchleague`

### Additional information with screenshots
#### wtwtich -h, --help

![Screenshot](Images/Screenshot0.png)

#### wtwitch [STREAMER]
Watch the specified streamer. Do not inclue `https://www.twitch.tv/`, wtwitch adds this automatically. Wtwitch creates the streamlink process as a background process, so you don't have to open a new terminal tab to keep using Bash.

![Screenshot](Images/Screenshot1.jpg)

#### wtwitch -c, --check
View the status the streamers you're subscribed to. To subscribe to a streamer, use `wtwitch -s [STREAMER]`. To unsubscribe from a streamer, use `wtwitch -u [STREAMER]`.

![Screenshot](Images/Screenshot2.png)

#### wtwitch -g [GAME], --get-streamers [GAME]
View the top streamers for a specified game. If the game name has spaces in it, like "World of Warcraft", you'll have to quote the game name or put a backslash before every space. For example, `wtwitch -g world\ of\ warcraft` or `wtwitch -g "world of warcraft"`. The game name is case insensitive.

![Screenshot](Images/Screenshot4.png)

#### wtwitch -p [PLAYER], wtwitch --player=[PLAYER]
Changes the player that gets passed to Streamlink. You can specify [any player that Streamlink supports](https://streamlink.github.io/players.html). Be aware that wtwitch passes the flag `--player-continuous-http` to Streamlink. Quicktime is the only player that doesn't support the HTTP transport mode, so wtwitch is incompatible with Quicktime (unless you modify the source code).

The preference is stored in the configuration file at `~/.config/wtwitch/config.json`.

#### wtwitch -t, --top-games
View the top streamed games on Twitch at the moment. 

![Screenshot](Images/Screenshot3.png)

#### wtwitch -s [STREAMER], --subscribe=[STREAMER]; wtwitch -u [STREAMER], unsubscribe=[STREAMER]
You can subscribe/unsubscribe to/from any streamer on Twitch. When using `wtwitch -c`, the status of your subscribed streamers will be printed. 