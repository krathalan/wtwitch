# wtwitch

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![Donate via Liberapay](https://img.shields.io/liberapay/receives/krathalan?label=Donate%20on%20Liberapay&logo=Liberapay)](https://liberapay.com/krathalan/donate)

A terminal program for Twitch. Watch and browse Twitch without proprietary JavaScript and without being tracked.

![Screenshot](https://krathalan.net/wtwitch1.webp)

Table of contents:

1. [Project status](#project-status)
2. [How to use](#how-to-use)
3. [Install](#install)
4. [More information](#more-information)
5. [Bugs and feature requests](#bugs-and-feature-requests)
6. [Contributions](#contributions)
7. [FAQ](#faq)
8. [Privacy](#privacy)
9. [Technical information](#technical-information)

## Project status
Wtwitch is generally considered to be feature-complete. I will continue to fix bugs, though the fixes may take a while. However, I will happily review and accept PRs. There is more work that can be done, in order of importance:

- Maintain compatibility with current Twitch API, including adding support for API request(s) useful to wtwitch users
- Improve translations
- Add a configuration menu so there are not a lot of configuration commands
- Any [requested enhancements](https://github.com/krathalan/wtwitch/issues?q=is%3Aissue+is%3Aopen+label%3Aenhancement)

## How to use
Wtwitch has the following commands:

```
=> [w]atch [name]      - Watch [name] streamer.
=> [s]ub [name(s)]     - Subscribe to [name] streamer.
                         You can subscribe to multiple streamers in one command.
=> [u]nsub [name(s)]   - Unsubscribe from [name] streamer.
                         You can unsubscribe from multiple streamers in one command.
=> [c]heck             - View your settings and the status of streamers you are
                         subscribed to.
=> [o]                 - Browse online streamers you are subscribed to and open
                         streams with fzf.
=> [e] [search-term]   - Search games/categories for [search-term].
=> [n] [search-term]   - Search streamers/channels for [search-term].
=> [g]ame [name]       - View the top streamers for [name] game/category.
=> [t]op               - View the top games and streamers on Twitch.
=> [v]od [name] [#]    - List or watch [name]'s VODs.
=> [f]                 - Toggle the printing of offline subscriptions with [c]heck.
=> [l]                 - Toggle the usage of colors in wtwitch output.
=> [p]layer [program]  - Change the player program that gets passed to streamlink.
=> [q]uality [quality] - Change the video quality that gets passed to streamlink.
=> [b]lock [name(s)]   - Block [name] streamer(s), preventing them from appearing in
                         any output. You can block multiple streamers in one command.
                         You can also use this command to unblock streamer(s).
=> [version]           - Print the current version of wtwitch.
=> [h]elp              - Print this help.
```

See [more information](#more-information) for help viewing the man page.

## Install
### Arch Linux
Install the official AUR package, maintained by the author of wtwitch (me): https://aur.archlinux.org/packages/wtwitch/

AUR releases are signed so you'll need to import my GPG key:

`<dev@krathalan.net> / 0C6B 73F3 91FA 26F0 EBCD 1F75 C0F9 AEE5 6E47 D174`

If you're having keyserver issues, grab it from my website: https://krathalan.net/keys/dev.asc

### Ubuntu
Please note that Ubuntu ships an older version of Streamlink that does not have bug fixes in it for the Twitch plugin. See more information here: https://github.com/streamlink/streamlink/issues/4670

You may need to install `curl` and `jq`. You may be able to install `streamlink` as an AppImage: https://github.com/streamlink/streamlink-appimage

Afterwards, [clone the repo](#other_distros).

### Other distros
Clone the repository: `git clone https://github.com/krathalan/wtwitch`

Then add the `src/` directory in the cloned wtwitch repo to your `$PATH`. You may need to install `curl`, `jq`, and `streamlink`. See this page for distro-specific streamlink installation instructions: https://streamlink.github.io/install.html

### macOS
You need to install additional dependencies through e.g. [homebrew](https://brew.sh/):

> `$ brew install bash coreutils curl jq streamlink`

Afterwards, [clone the repo](#other_distros).

### BSD systems
You will need to install Bash, the GNU coreutils, `curl`, `jq`, and `streamlink`.

Afterwards, [clone the repo](#other_distros).

## More information
See `man wtwitch` if you have the AUR package installed.

If not, you may view the man page online: https://krathalan.net/wtwitch.html

For an offline copy, without the AUR package, you can build the man page from source.

To build the man page, `cd` into the cloned wtwitch directory. Then generate the man page with [scdoc](https://git.sr.ht/~sircmpwn/scdoc/):

> `$ scdoc < wtwitch.1.scd > wtwitch.1`

Then view the man page:

> `$ man -l wtwitch.1`

## Bugs and feature requests
If you are reporting a bug, please attach a debug log.

To start wtwitch in debug mode, set the environment variable WTWITCH_DEBUG=on. You should also redirect all output to a log file. You can run wtwitch in debug mode in a one-off command like so:

> `$ WTWITCH_DEBUG=on wtwitch [command] &> debug.log`

Then paste/upload the contents of the `debug.log` file to your favorite paste service (e.g. https://gist.github.com/) and provide a link in your report.

Please file feature requests and report any bugs at: https://github.com/krathalan/wtwitch/issues

## Contributions
All contributions are welcome. Please try to adhere to the [Google Shell Style Guide](https://google.github.io/styleguide/shell.xml). Make sure your new code passes Shellcheck with no "shellcheck disable=SCXXXX" lines. Try looking at [Dylan's Pure Bash Bible](https://github.com/dylanaraps/pure-bash-bible) before using an external program.

Most needed are translations for languages other than English. No coding knowledge is necessary to submit translations. Anyone can contribute translations in any format they wish, and I will incorporate them into the program.

If you provide a better method of installation for a distro other than Arch, such as an Ubuntu PPA or Fedora Copr repo, please let me know and I will add it to this README.

## FAQ
### Are you going to implement Twitch chat?
No. Check out [Chatty](https://chatty.github.io/), a featureful Twitch chat client written in Java. It's available in the AUR: https://aur.archlinux.org/packages/chatty/

### Old signing key
For releases before 2.0.0:

`<krathalan@disroot.org> 02AA A23A BDF1 D538 BD88 9D25 1AAD E5E7 28FF C667`

## Privacy
Wtwitch never collects any usage data or data about the user. Wtwitch only connects to remote servers for the following reasons:

1. Directly to Twitch's API endpoint to get data about various streamers that you request
2. Through `streamlink` to Twitch's video servers to get video data for a streamer you request to watch

## Technical information
Wtwitch is written entirely in Bash, utilizing programs written mostly in C. It doesn't make any connections to any server other than Twitch's servers. As soon as a wtwitch command executes (e.g. `wtwitch c`), wtwitch stops running -- it doesn't stay open. (Wtwitch does stay open when you're watching a stream, but it uses no CPU and less than 5 MB of RAM.)

Here's a list of the CLI programs Wtwitch utilizes to process data and the language they're written in:

- [cURL](https://github.com/curl/curl), written mostly in C
- [GNU coreutils](https://github.com/coreutils/coreutils), written nearly entirely in C and shell
- [jq](https://github.com/stedolan/jq), written nearly entirely in C

Wtwitch utilizes [Streamlink](https://github.com/streamlink/streamlink), which is written in Python, but it's only used when the user actually opens a stream to watch. Streamlink isn't used when using any other features of Wtwitch.
