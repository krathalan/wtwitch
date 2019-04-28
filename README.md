# wtwitch
A terminal-based Twitch app. Watch and browse Twitch without proprietary JavaScript and without being tracked.

Wtwitch will tell Streamlink to use GNOME MPV by default. If GNOME MPV is not installed, wtwitch will tell Streamlink to use VLC -- the default Streamlink player. Wtwitch favors GNOME MPV because GNOME MPV supports [Wayland](https://wayland.freedesktop.org/), whereas VLC does not (yet). You can set which video player you'd like wtwitch to pass to Streamlink with `wtwitch -p [PLAYER]`.

Wtwitch tells Streamlink to choose the "best" quality by default. You can set which quality you'd like wtwitch to pass to Streamlink with `wtwitch -q [QUALITY]`. You can pass any quality you'd pass to Streamlink, even fallback qualities (like "720p,480p,worst"), and wtwitch will make sure your input is correct.

The configuration file is located at `~/.config/wtwitch/config.json`. It should rarely take more than a few kilobytes of space (dependent on how many streamers you're subscribed to), at most.

You can make wtwitch executable with the command `chmod a+x wtwitch`. Additionally, you can [add the script to your $PATH](https://stackoverflow.com/questions/20054538/add-a-bash-script-to-path). Using both, you can use the command `wtwitch` in any directory in your terminal, instead of having to type `bash wtwitch [OPTION] [ARG]` in the directory the script is in every time.

## Dependencies
You must have [Streamlink](https://streamlink.github.io/) and [jq](https://stedolan.github.io/jq/) installed. You can install both on Fedora with the command `sudo dnf install -y python3-streamlink jq`.

[Streamlink is licensed under the 2-clause BSD license](https://github.com/streamlink/streamlink/blob/master/LICENSE), which is [FSF approved](https://www.gnu.org/licenses/license-list.en.html#FreeBSD). 

[jq is licensed under the MIT license](https://github.com/stedolan/jq/blob/master/COPYING) [(which is technically the Expat license)](https://en.wikipedia.org/wiki/MIT_License#Variants), which is [FSF approved](https://www.gnu.org/licenses/license-list.en.html#Expat).

## Usage
`bash wtwitch [OPTION] [ARG]`

Option | Description | Example
--- | --- | ---
-h, --help | show brief help | `bash wtwitch -h`
(no option) [STREAMER] | watch the specified streamer | `bash wtwitch overwatchleague`
-c, --check | view which subscribed Twitch streams are online | `bash wtwitch -c`
-g [GAME], --get-streamers=[GAME] | view the top streamers for a specified game | `bash wtwitch -g "world of warcraft"`
-p [PLAYER], --change-player=[PLAYER] | changes the default player in `~/.config/wtwitch/config.json` that gets passed to Streamlink | `bash wtwitch -p gnome-mpv`
-q [QUALITY], --change-quality=[QUALITY] | changes the default quality in `~/.config/wtwitch/config.json` that gets passed to Streamlink | `bash wtwitch -q "720p,480p,worst"`
-s [STREAMER], --subscribe=[STREAMER] | subscribes to a specific streamer | `bash wtwitch -s overwatchleague`
-t, --top-games | lists the top games on twitch | `bash wtwitch -t`
-u [STREAMER], --unsubscribe=[STREAMER] | unsubscribes from a specified streamer | `bash wtwitch -u overwatchleague`

### Additional usage information with screenshots
#### wtwtich -h, --help

![Screenshot](Images/Screenshot-Help.png)

#### wtwitch [STREAMER]
Watch the specified streamer. Do not inclue `https://www.twitch.tv/`, wtwitch adds this automatically. 

Wtwitch will make sure the specified streamer is actually live before starting Streamlink.

![Screenshot](Images/Screenshot-No-Option.jpg)

#### wtwitch -c, --check
View the status the streamers you're subscribed to. To subscribe to a streamer, use `wtwitch -s [STREAMER]`. To unsubscribe from a streamer, use `wtwitch -u [STREAMER]`.

Your subscriptions are stored in the configuration file at `~/.config/wtwitch/config.json`.

![Screenshot](Images/Screenshot-Check.png)

#### wtwitch -g [GAME], --get-streamers [GAME]
View the top streamers for a specified game. If the game name has spaces in it, like "World of Warcraft", you'll have to quote the game name or put a backslash before every space. For example, `wtwitch -g world\ of\ warcraft` or `wtwitch -g "world of warcraft"`. The game name is case insensitive.

![Screenshot](Images/Screenshot-Get-Streamers.png)

#### wtwitch -p [PLAYER], --change-player=[PLAYER]
Changes the player that gets passed to Streamlink. You can specify [any player that Streamlink supports](https://streamlink.github.io/players.html). Be aware that wtwitch passes the flag `--player-continuous-http` to Streamlink. Quicktime is the only player that doesn't support the HTTP transport mode, so wtwitch is incompatible with Quicktime (unless you modify the source code).

Wtwitch will make sure the player you're trying to set as the default player is installed.

The player preference is stored in the configuration file at `~/.config/wtwitch/config.json`.

#### wtwitch -q [QUALITY], --change-quality=[QUALITY]
Changes the quality that gets passed to Streamlink. You can specify [any quality that Streamlink supports](https://streamlink.github.io/cli.html#cmdoption-arg-stream), including fallback qualities, and wtwitch will make sure your input is correct.

Full list of acceptable individual qualities: worst, 160p, 360p, 480p, 720p, 720p60, 1080p60, best.

Examples of acceptable quality settings (non-exclusive):
- best
  - Default setting
  - Behavior: always selects the highest quality available
- 720p,480p,best
  - Behavior: tries to get a 720p stream, then if that fails, a 480p stream, then if that fails, the best stream available
- 360p,worst
  - Behavior: tries to get a 360p stream, then if that fails, the worst stream available

The quality preference is stored in the configuration file at `~/.config/wtwitch/config.json`.

![Screenshot](Images/Screenshot-Quality.png)

#### wtwitch -t, --top-games
View the top streamed games on Twitch at the moment. 

![Screenshot](Images/Screenshot-Top-Games.png)

#### wtwitch -s [STREAMER], --subscribe=[STREAMER]; wtwitch -u [STREAMER], unsubscribe=[STREAMER]
You can subscribe/unsubscribe to/from any streamer on Twitch. When using `wtwitch -c`, the status of your subscribed streamers will be printed. 

Wtwitch will make sure the streamer exists before allowing you to subscribe to them.

Your subscriptions are stored in the configuration file at `~/.config/wtwitch/config.json`.