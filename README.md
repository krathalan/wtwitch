# wtwitch
A terminal-based Twitch app. Watch and browse Twitch without proprietary JavaScript and without being tracked.

Table of contents:

1. [Intro](https://gitlab.com/krathalan/wtwitch#intro)
2. [Default behavior](https://gitlab.com/krathalan/wtwitch#default-behavior)
3. [Dependencies](https://gitlab.com/krathalan/wtwitch#dependencies)
4. [Usage](https://gitlab.com/krathalan/wtwitch#usage)
5. [FAQ](https://gitlab.com/krathalan/wtwitch#faq)

## Intro
Wtwitch is a terminal-based app that uses the Twitch API and Streamlink to provide Twitch subscription and playback functionality without signing up for a Twitch account and without running Twitch's proprietary JavaScript.

## Default behavior
### Player
Wtwitch will tell Streamlink to use mpv by default. Wtwitch favors mpv because mpv supports [Wayland](https://wayland.freedesktop.org/), whereas VLC does not (yet). Mpv also supports custom window titles, like "Watching overwatchleague on Twitch (1080p 60.000fps)". 

However, wtwitch will use VLC if you have VLC installed and *don't* have mpv installed. You can set which video player you'd like wtwitch to pass to Streamlink with `wtwitch -p [PLAYER]`. You can pass [any player you'd pass to Streamlink](https://streamlink.github.io/players.html#player-compatibility), and wtwitch will make sure the player you're trying to set as the default player is installed.

### Quality
Wtwitch tells Streamlink to choose the "best" quality by default. You can set which quality you'd like wtwitch to pass to Streamlink with `wtwitch -q [QUALITY]`. You can pass any quality you'd pass to Streamlink, even fallback qualities (like "720p,480p,worst"), and wtwitch will make sure your input is valid.

### Miscellaneous
Wtwitch tells Streamlink to bypass Twitch ads. If you want to support a streamer, consider donating to them directly rather than subscribing to them on Twitch, as [Twitch takes 50% of the subscription fee](https://www.polygon.com/2018/6/25/17502380/monteization-youtube-channel-memberships-patreon-twitch-affiliate-partner).

The configuration file is located at `~/.config/wtwitch/config.json`. It should rarely take more than a few kilobytes of space (dependent on how many streamers you're subscribed to), at most.

You can make wtwitch executable with the command `chmod a+x wtwitch`. Additionally, you can [add the script to your $PATH](https://stackoverflow.com/questions/20054538/add-a-bash-script-to-path). Using both, you can use the command `wtwitch` in any directory in your terminal like a regular terminal program, instead of having to type `bash wtwitch [OPTION] [ARG]` in the directory the script is in.

## Dependencies
You must have [Streamlink](https://streamlink.github.io/), [jq](https://stedolan.github.io/jq/), [cURL](https://curl.haxx.se/), and a [video player compatible with Streamlink](https://streamlink.github.io/players.html#player-compatibility) installed (preferably [mpv](https://mpv.io/)). cURL comes with most Linux installations, but some might be missing it.

You can install all dependencies with the command...
- Arch: `sudo pacman -S streamlink jq curl`
- Fedora: `sudo dnf install -y python3-streamlink jq curl`
- Ubuntu: `sudo apt update && sudo apt install python3-streamlink jq curl`
- Void: `sudo xbps-install -S streamlink jq curl`

### Licenses
[Streamlink is licensed under the 2-clause BSD license](https://github.com/streamlink/streamlink/blob/master/LICENSE), which is [an FSF-approved free software license](https://www.gnu.org/licenses/license-list.en.html#FreeBSD). 

[jq is licensed under the MIT license](https://github.com/stedolan/jq/blob/master/COPYING) [(which is technically the Expat license)](https://en.wikipedia.org/wiki/MIT_License#Variants), which is [an FSF-approved free software license](https://www.gnu.org/licenses/license-list.en.html#Expat).

[cURL uses a slightly modified version of the MIT license](https://github.com/curl/curl/blob/master/COPYING). cURL's license is incompatible with the GPL because it prevents the names of copyright holders from being "used in advertising or otherwise to promote the sale, use or other dealings
in this Software without prior written authorization of the copyright holder." However, I believe the FSF would still classify this license as a free software license, as the Apache License (version 1) contains a similar advertising clause and is still categorized as a free software license. Since wtwitch is using cURL externally instead of borrowing some of cURL's code, wtwitch can still be licensed under the GPLv3.

[mpv is licensed under the GPLv2 and LGPLv2.1 licenses](https://github.com/mpv-player/mpv/blob/master/Copyright). Both are [FSF-approved](https://www.gnu.org/licenses/license-list.html#GPLv2).

## Usage
`bash wtwitch [OPTION] [ARG]`

Option | Description | Example
--- | --- | ---
-h, --help | show brief help | `bash wtwitch -h`
(no option) [STREAMER] | watch the specified streamer | `bash wtwitch overwatchleague`
-c, --check | view which subscribed Twitch streams are online and your settings | `bash wtwitch -c`
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
Watch the specified streamer. Do not inclue `https://www.twitch.tv/`, wtwitch adds this automatically. Wtwitch creates the streamlink process as a background process, so you don't have to keep your terminal open.

Wtwitch will make sure the specified streamer is actually live before starting Streamlink.

![Screenshot](Images/Screenshot-No-Option.jpg)

#### wtwitch -c, --check
View the status of the streamers you're subscribed to and your settings. To subscribe to a streamer, use `wtwitch -s [STREAMER]`. To unsubscribe from a streamer, use `wtwitch -u [STREAMER]`.

Wtwitch caches the results of the check operation in `~/.cache/wtwitch/` to reduce Twitch API calls. The cache expires every 60 seconds. If you subscribe to or unsubscribe from a streamer, the cache becomes invalidated. The cache is only marked as updated if the full check operation completed successfully, and the cache files get deleted if wtwitch exits with an error. Like the configuration file, the cache should rarely take more than a few kilobytes of space -- dependending on how many streamers you're subscribed to.

Your subscriptions are stored in the configuration file at `~/.config/wtwitch/config.json`.

![Screenshot](Images/Screenshot-Check.png)

#### wtwitch -g [GAME], --get-streamers=[GAME]
View the top streamers for a specified game. If the game name has spaces in it, like "World of Warcraft", you'll have to quote the game name or put a backslash before every space. For example, `wtwitch -g world\ of\ warcraft` or `wtwitch -g "world of warcraft"`. The game name is case insensitive.

![Screenshot](Images/Screenshot-Get-Streamers.png)

#### wtwitch -p [PLAYER], --change-player=[PLAYER]
Changes the player that gets passed to Streamlink. You can specify [any player that Streamlink supports](https://streamlink.github.io/players.html). Be aware that wtwitch passes the flag `--player-continuous-http` to Streamlink. Quicktime is the only player that doesn't support the HTTP transport mode, so wtwitch is incompatible with Quicktime (unless you modify the source code).

Wtwitch will make sure the player you're trying to set as the default player is installed.

Your player preference is stored in the configuration file at `~/.config/wtwitch/config.json`.

#### wtwitch -q [QUALITY], --change-quality=[QUALITY]
Changes the quality that gets passed to Streamlink. You can specify [any quality that Streamlink supports](https://streamlink.github.io/cli.html#cmdoption-arg-stream), including fallback qualities, and wtwitch will make sure your input is valid.

Full list of acceptable individual qualities: worst, 160p, 360p, 480p, 720p, 720p60, 1080p60, best.

Examples of acceptable quality settings (non-exclusive):
- best
  - Default setting
  - Behavior: always selects the highest quality available
- 720p,480p,best
  - Behavior: tries to get a 720p stream, then if that fails, a 480p stream, then if that fails, the best stream available
- 360p,worst
  - Behavior: tries to get a 360p stream, then if that fails, the worst stream available

Your quality preference is stored in the configuration file at `~/.config/wtwitch/config.json`.

![Screenshot](Images/Screenshot-Quality.png)

#### wtwitch -t, --top-games
View the top watched games on Twitch at the moment. 

![Screenshot](Images/Screenshot-Top-Games.png)

#### wtwitch -s [STREAMER], --subscribe=[STREAMER]; wtwitch -u [STREAMER], unsubscribe=[STREAMER]
You can subscribe/unsubscribe to/from any streamer on Twitch. When using `wtwitch -c`, the status of your subscribed streamers will be printed. 

Wtwitch will make sure the streamer exists before allowing you to subscribe to them.

Your subscriptions are stored in the configuration file at `~/.config/wtwitch/config.json`.

## FAQ
### Why not use [Streamlink Twitch GUI](https://github.com/streamlink/streamlink-twitch-gui)?
Streamlink Twitch GUI is great for people uncomfortable with the command line. However, I personally was unsatisfied with it for a number of reasons.

To start, when uncompressed, Streamlink Twitch GUI's files (for Linux x64) take up 225.4 MB of disk space. You can download and uncompress the files from [Streamlink Twitch GUI's GitHub releases page](https://github.com/streamlink/streamlink-twitch-gui/releases). Though, we have to remember that Streamlink Twitch GUI [also requires Streamlink to be installed](https://github.com/streamlink/streamlink-twitch-gui#download), so Streamlink Twitch GUI actually takes up ~230 MB. Wtwitch and its dependencies -- Streamlink and jq -- when installed, take up ~12 MB. You also need a player with wtwitch -- mpv takes up ~70 MB -- so the total disk usage for wtwitch is ~82 MB, compared to ~230 MB for Streamlink Twitch GUI. 

Additionally, Streamlink Twitch GUI's source consists of a multitude of files of varying lengths in a complex folder structure, altogether at least over 3000 lines of code. Wtwitch is only written in Bash, and all the code is contained in one file at under 900 lines of code. It's much easier for someone to audit the source code of or contribute to Wtwitch compared to Streamlink Twitch GUI.

> "Streamlink Twitch GUI is a NW.js application, which means that it is a web application written in JavaScript (EmberJS), HTML (Handlebars) and CSS (LessCSS) and is being run by a Node.js powered version of Chromium." ([from Streamlink Twitch GUI's Github page](https://github.com/streamlink/streamlink-twitch-gui#description))

Streamlink Twitch GUI is built on NW.js, which is similar to Electron. I'd rather not use Chrome/Chromium if I don't have to. Given the existence of projects like [ungoogled-chromium](https://github.com/Eloston/ungoogled-chromium#motivation-and-philosophy), it's clear that Chromium automatically makes a multitude of non-user-initiated connections to Google, which I'd rather my computer *not* do. Additionally, [JavaScript sucks](https://whydoesitsuck.com/why-does-javascript-suck/). 

Finally, security seems to be a sore point with NW.js:
> "Node frames have following extra capabilities than normal frames: ... Bypass all security restrictions, such as sandboxing, same origin policy etc. For example, you can make cross origin XHR to any remote sites, or access to \<iframe\> element whose src points to remote sites in node frames." ([from the NW.js documentation](http://docs.nwjs.io/en/latest/For%20Users/Advanced/Security%20in%20NW.js/))

Wtwitch is written entirely in Bash, utilizing programs written mostly in C. It doesn't make any connections to any server other than Twitch's servers. As soon as a wtwitch command executes (e.g. `wtwitch -c`), wtwitch stops running -- it doesn't stay open. (Wtwitch does stay open when you're watching a stream, but it uses no CPU and less than 1 MB of RAM.) This design makes wtwitch much more resource efficient than Streamlink Twitch GUI.

Here's a list of the CLI programs Wtwitch utilizes to process data and the language they're written in: 

- [cURL](https://github.com/curl/curl), written mostly in C
- [GNU coreutils](https://github.com/coreutils/coreutils), written nearly entirely in C and shell
- [jq](https://github.com/stedolan/jq), written nearly entirely in C

Wtwitch utilizes [Streamlink](https://github.com/streamlink/streamlink), which is written in Python, but it's only used when the user actually opens a stream to watch. Streamlink isn't used when doing anything else in wtwitch.