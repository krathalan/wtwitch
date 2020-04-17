# wtwitch

A terminal program for Twitch. Watch and browse Twitch without proprietary JavaScript and without being tracked.

![Screenshot](https://i.imgur.com/nAWbrEg.jpg)

Table of contents:

1. [Install](https://git.sr.ht/~krathalan/wtwitch#install)
2. [More information](https://git.sr.ht/~krathalan/wtwitch#more-information)
3. [FAQ](https://git.sr.ht/~krathalan/wtwitch#faq)

## Install
### Arch Linux
Install the official AUR package, maintained by the author of wtwitch (me): https://aur.archlinux.org/packages/wtwitch/

AUR releases are signed so you'll need to import my GPG key:  
`02AA A23A BDF1 D538 BD88  9D25 1AAD E5E7 28FF C667`

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

Afterwards, clone the repo or download the script manually like any distro other than Arch.

### Any distro
Clone the repository (recommended): `git clone https://git.sr.ht/~krathalan/wtwitch`

Or download the script manually: [wtwitch](wtwitch)

## More information
See `man wtwitch` if you have the AUR package installed. 

Otherwise, download the manual here: [wtwitch.1.scd](wtwitch.1.scd)

You can then generate the man page with [scdoc](https://git.sr.ht/~sircmpwn/scdoc/):

> `$ scdoc < wtwitch.1.scd > wtwitch.1`

Then view the man page:

> `$ man -l wtwitch.1`

## Bugs
To take a debug log with wtwitch, append "`-d &> debug.log`" to your command (e.g. `wtwitch -g 'destiny 2' -d &> debug.log`). Then paste the contents of the `debug.log` file to your favorite paste service (e.g. https://paste.sr.ht/) and provide a link in your report.

Please file requests and report any bugs at: https://todo.sr.ht/~krathalan/wtwitch

Alternatively, you may send them via email to: `~krathalan/wtwitch@todo.sr.ht`

## FAQ
### Why not use [Streamlink Twitch GUI](https://github.com/streamlink/streamlink-twitch-gui)?
Streamlink Twitch GUI is great for people uncomfortable with the command line. However, I personally was unsatisfied with it because of its weight and reliance on Xorg.

Since wtwitch is a terminal program, it can be run in any terminal emulator that supports Wayland for a nice Wayland-native experience. Streamlink Twitch GUI requires Xwayland as it uses Chromium to render and Chromium does not yet support Wayland.

When uncompressed, Streamlink Twitch GUI's files (for Linux x64) take up 225.4 MB of disk space. You can download and uncompress the files from [Streamlink Twitch GUI's GitHub releases page](https://github.com/streamlink/streamlink-twitch-gui/releases). Though, we have to remember that Streamlink Twitch GUI [also requires Streamlink to be installed](https://github.com/streamlink/streamlink-twitch-gui#download), so Streamlink Twitch GUI actually takes up ~230 MB. Wtwitch and its dependencies -- Streamlink and jq -- when installed, take up ~12 MB. You also need a player with both -- mpv takes up ~70 MB -- so the total disk usage for wtwitch is ~82 MB, compared to ~300 MB for Streamlink Twitch GUI.

Using `cloc` (https://github.com/AlDanial/cloc) to **c**ount **l**ines **o**f **c**ode:

> `$ git clone https://github.com/streamlink/streamlink-twitch-gui.git && cloc streamlink-twitch-gui/src/`  

| Language | files | blank | comment | code |
| -------- | ----- | ----- | ------- | ---- |
| JavaScript | 529 | 7759 | 2730 | 33151 |
| YAML | 47 | 4 | 44 | 3702 |
| LESS | 52 | 769 | 100 | 3409 |
| Handlebars | 73 | 47 | 0 | 2415 |
| JSON | 33 | 8 | 0 | 1702 |
| HTML | 3 | 2 | 0 | 70 |
| CSS | 1 | 2 | 2 | 14 |
| SUM | 738 | 8591 | 2876 | **44463** |

---

> `$ git clone https://git.sr.ht/~krathalan/wtwitch && cloc wtwitch/`  

| Language | files | blank | comment | code |
| -------- | ----- | ----- | ------- | ---- |
| Bourne Again Shell | 1 | 169 | 415 | 781 |
| Markdown | 1 | 42 | 0 | 74 |
| SUM | 2 | 211 | 415 | **855** |

---

## Privacy
Wtwitch never collects any usage data or data about the user. Wtwitch only connects to remote servers for the following reasons:

1. Directly to Twitch's API endpoint to get data about various streamers that you request
2. Through `streamlink` to Twitch's video servers to get video data for a streamer you request to watch

## Technical information
Wtwitch is written entirely in Bash, utilizing programs written mostly in C. It doesn't make any connections to any server other than Twitch's servers. As soon as a wtwitch command executes (e.g. `wtwitch -c`), wtwitch stops running -- it doesn't stay open. (Wtwitch does stay open when you're watching a stream, but it uses no CPU and less than 5 MB of RAM.)

Here's a list of the CLI programs Wtwitch utilizes to process data and the language they're written in: 

- [Wget](https://savannah.gnu.org/projects/wget/), written mostly in C
- [GNU coreutils](https://github.com/coreutils/coreutils), written nearly entirely in C and shell
- [jq](https://github.com/stedolan/jq), written nearly entirely in C

Wtwitch utilizes [Streamlink](https://github.com/streamlink/streamlink), which is written in Python, but it's only used when the user actually opens a stream to watch. Streamlink isn't used when doing anything else in wtwitch.
