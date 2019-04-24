# wtwitch
A terminal-based Twitch app. Watch Twitch without proprietary JavaScript and without being tracked.

Usage of a config file (e.g. `~/.config/wtwitch/config.txt`) should be coming soon and should make customizing the script much easier.

## Usage
### wtwitch [STREAMER]
Watch the specified streamer. Do not inclue `https://www.twitch.tv/`, wtwitch adds this automatically.

![Screenshot](Images/Screenshot1.jpg)

### wtwitch -c, --check
Check to see the status of your favorite streams. To list your favorite streams, modify the `streamsToCheck` variable on line 64 of the script.

![Screenshot](Images/Screenshot2.jpg)