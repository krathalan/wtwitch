# wtwitch

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![Donate via Liberapay](https://img.shields.io/liberapay/receives/krathalan?label=Donate%20on%20Liberapay&logo=Liberapay)](https://liberapay.com/krathalan/donate)

A terminal program for Twitch. Watch and browse Twitch without proprietary JavaScript and without being tracked.

![Screenshot](https://krathalan.net/wtwitch.webp)

Table of contents:

1. [How to use](#how-to-use)
2. [Install](#install)
3. [More information](#more-information)
4. [Bugs and feature requests](#bugs-and-feature-requests)
5. [Contributions](#contributions)
6. [FAQ](#faq)
7. [Privacy](#privacy)
8. [Technical information](#technical-information)

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
=> [e] [search-term]   - Search games/categories for [search-term].
=> [n] [search-term]   - Search streamers/channels for [search-term].
=> [g]ame [name]       - View the top streamers for [name] game/category.
=> [t]op               - View the top games and streamers on Twitch.
=> [v]od [name] [#]    - List or watch [name]'s VODs.
=> [f]                 - Toggle the printing of offline subscriptions with [c]heck.
=> [l]                 - Toggle the usage of colors in wtwitch output.
=> [p]layer [program]  - Change the player program that gets passed to streamlink.
=> [q]uality [quality] - Change the video quality that gets passed to streamlink.
=> [b]lock [name(s)]   - Block [name] streamer, preventing them from appearing in any
                         output. You can block multiple streamers in one command.
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

### macOS
You need to install additional dependencies through e.g. [homebrew](https://brew.sh/):

```
brew install bash coreutils jq
```

Afterwards, [clone the repo](#any-distro).

### Ubuntu
Please note that Ubuntu ships an older version of Streamlink that does not have bug fixes in it for the Twitch plugin.

You have a few options:

1. Contact the maintainer of Streamlink for Ubuntu

2. Use a different distribution which provides a more up-to-date Streamlink

3. Use the Streamlink installation instructions for Ubuntu [from Streamlink's website](https://streamlink.github.io/install.html):

```
$ sudo add-apt-repository ppa:nilarimogard/webupd8

$ sudo apt update

$ sudo apt install streamlink
```

Afterwards, clone the repo like any distro other than Arch.

### Any distro
Clone the repository: `git clone https://github.com/krathalan/wtwitch`

Then add the cloned wtwitch directory to your `$PATH`.

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

### Why not use [Streamlink Twitch GUI](https://github.com/streamlink/streamlink-twitch-gui)?
Streamlink Twitch GUI is great for people uncomfortable with the command line. However, I personally was unsatisfied with it because of its weight and reliance on Xorg.

Since wtwitch is a terminal program, it can be run in any terminal emulator that supports Wayland for a nice Wayland-native experience. Streamlink Twitch GUI requires Xwayland as it uses Chromium to render and Chromium does not yet support Wayland.

When uncompressed, Streamlink Twitch GUI's files (for Linux x64) take up 225.4 MB of disk space. You can download and uncompress the files from [Streamlink Twitch GUI's GitHub releases page](https://github.com/streamlink/streamlink-twitch-gui/releases). Though, we have to remember that Streamlink Twitch GUI [also requires Streamlink to be installed](https://github.com/streamlink/streamlink-twitch-gui#download), so Streamlink Twitch GUI actually takes up ~230 MB. Wtwitch and its dependencies -- Streamlink and jq -- when installed, take up ~12 MB. You also need a player with both -- mpv takes up ~70 MB -- so the total disk usage for wtwitch is ~82 MB, compared to ~300 MB for Streamlink Twitch GUI.

Using `cloc` (https://github.com/AlDanial/cloc) to **c**ount **l**ines **o**f **c**ode:

```
  $ git clone https://github.com/streamlink/streamlink-twitch-gui.git && cloc streamlink-twitch-gui/src/

-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
JavaScript                     547           8035           3122          36387
YAML                            72              7            110           6207
LESS                            54            782            103           3450
Handlebars                      75             52              0           2581
JSON                            34              8              0           2035
HTML                             3              2              0             71
CSS                              1              3              3             20
-------------------------------------------------------------------------------
SUM:                           786           8889           3338          50751
-------------------------------------------------------------------------------
```

---

```
  $ git clone https://github.com/krathalan/wtwitch && cloc wtwitch/

--------------------------------------------------------------------------------
Language                      files          blank        comment           code
--------------------------------------------------------------------------------
Bourne Again Shell                2            239            704           1102
Markdown                          1             60              0            123
YAML                              1              0              0             23
--------------------------------------------------------------------------------
SUM:                              4            299            704           1248
--------------------------------------------------------------------------------

```

### Old signing key
For releases before 2.0.0:

`<krathalan@disroot.org> 02AA A23A BDF1 D538 BD88 9D25 1AAD E5E7 28FF C667`

## Privacy
Wtwitch never collects any usage data or data about the user. Wtwitch only connects to remote servers for the following reasons:

1. Directly to Twitch's API endpoint to get data about various streamers that you request
2. Through `streamlink` to Twitch's video servers to get video data for a streamer you request to watch

## Technical information
Wtwitch is written entirely in Bash, utilizing programs written mostly in C. It doesn't make any connections to any server other than Twitch's servers. As soon as a wtwitch command executes (e.g. `wtwitch -c`), wtwitch stops running -- it doesn't stay open. (Wtwitch does stay open when you're watching a stream, but it uses no CPU and less than 5 MB of RAM.)

Here's a list of the CLI programs Wtwitch utilizes to process data and the language they're written in:

- [cURL](https://github.com/curl/curl), written mostly in C
- [GNU coreutils](https://github.com/coreutils/coreutils), written nearly entirely in C and shell
- [jq](https://github.com/stedolan/jq), written nearly entirely in C

Wtwitch utilizes [Streamlink](https://github.com/streamlink/streamlink), which is written in Python, but it's only used when the user actually opens a stream to watch. Streamlink isn't used when doing anything else in wtwitch.
