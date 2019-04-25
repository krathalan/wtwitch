# wtwitch
A terminal-based Twitch app. Watch Twitch without proprietary JavaScript and without being tracked.

Usage of a config file (e.g. `~/.config/wtwitch/config.txt`) should be coming soon and should make customizing the script much easier.

## Dependencies
You must have [Streamlink](https://streamlink.github.io/) and [jq](https://stedolan.github.io/jq/) installed.

## Usage
### wtwitch [STREAMER]
Watch the specified streamer. Do not inclue `https://www.twitch.tv/`, wtwitch adds this automatically.

![Screenshot](Images/Screenshot1.jpg)

### wtwitch -c, --check
View the status of your favorite streams. To list your favorite streams, modify the `streamsToCheck` variable on line 64 of the script.

![Screenshot](Images/Screenshot2.png)

### wtwitch -l, --list-games
View the top streamed games on Twitch at the moment. 

![Screenshot](Images/Screenshot3.png)

### wtwitch -g [GAME], --get-streamers [GAME]
View the top streamers for a specified game. If the game name has spaces in it, like "World of Warcraft", you'll have to quote the game name or put a backslash before every space. For example, `wtwitch -g world\ of\ warcraft` or `wtwitch -g "world of warcraft"`. The game name is case insensitive.

![Screenshot](Images/Screenshot4.png)