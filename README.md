# wtwitch
A terminal-based Twitch app. Watch Twitch without proprietary JavaScript and without being tracked.

Usage of a config file (e.g. `~/.config/wtwitch/config.txt`) should be coming soon and should make customizing the script much easier.

## Usage
### wtwitch [STREAMER]
Watch the specified streamer. Do not inclue `https://www.twitch.tv/`, wtwitch adds this automatically.

![Screenshot](Images/Screenshot1.png)

### wtwitch -c, --check
Check to see the status of your favorite streams. To list your favorite streams, modify the `streamsToCheck` variable on line 64 of the script.

![Screenshot](Images/Screenshot2.png)

### wtwitch -l, --list-games
Look at what the top streamed games on Twitch at the moment are. The data pulled from Twitch doesn't seem to be very accurate and there's a fair number of duplicates or missing information. Strange output is not wtwitch's fault.

![Screenshot](Images/Screenshot3.png)