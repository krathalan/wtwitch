# wtwitch

A terminal program for Twitch. Watch and browse Twitch without proprietary JavaScript and without being tracked.

![Screenshot](https://i.imgur.com/oaxH3ss.jpg)

Table of contents:

1. [Install](https://git.sr.ht/~krathalan/wtwitch#install)
2. [More information](https://git.sr.ht/~krathalan/wtwitch#more-information)
3. [FAQ](https://git.sr.ht/~krathalan/wtwitch#faq)

## Install
### Arch Linux
Install the official AUR package, maintained by the author of wtwitch (me): https://aur.archlinux.org/packages/wtwitch/

### Any distro
Download the script manually

## More information
See the [man page](wtwitch.1.scd).

## FAQ
### Why not use [Streamlink Twitch GUI](https://github.com/streamlink/streamlink-twitch-gui)?
Streamlink Twitch GUI is great for people uncomfortable with the command line. However, I personally was unsatisfied with it for a number of (fairly trivial) reasons.

When uncompressed, Streamlink Twitch GUI's files (for Linux x64) take up 225.4 MB of disk space. You can download and uncompress the files from [Streamlink Twitch GUI's GitHub releases page](https://github.com/streamlink/streamlink-twitch-gui/releases). Though, we have to remember that Streamlink Twitch GUI [also requires Streamlink to be installed](https://github.com/streamlink/streamlink-twitch-gui#download), so Streamlink Twitch GUI actually takes up ~230 MB. Wtwitch and its dependencies -- Streamlink and jq -- when installed, take up ~12 MB. You also need a player with wtwitch -- mpv takes up ~70 MB -- so the total disk usage for wtwitch is ~82 MB, compared to ~230 MB for Streamlink Twitch GUI.

Using `cloc` (https://github.com/AlDanial/cloc) to **c**ount **l**ines **o**f **c**ode:

> `$ git clone https://github.com/streamlink/streamlink-twitch-gui.git && cloc streamlink-twitch-gui/src/`  

| Language | files | blank | comment | code |
| -------- | ----- | ----- | ------- | ---- |
| JavaScript | 554 | 7995 | 2760 | 34118 |
| YAML | 47 | 4 | 60 | 3896 |
| LESS | 54 | 806 | 104 | 3557 |
| Handlebars | 81 | 48 | 0 | 2588 |
| JSON | 38 | 8 | 0 | 2063 |
| HTML | 3 | 2 | 0 | 70 |
| CSS | 1 | 2 | 2 | 14 |
| SUM | 778 | 8865 | 2926 | **46306** |

---

> `$ git clone https://gitlab.com/krathalan/wtwitch.git && cloc wtwitch/`  

| Language | files | blank | comment | code |
| -------- | ----- | ----- | ------- | ---- |
| Bourne Again Shell | 1 | 128 | 342 | 531 |
| Markdown | 1 | 20 | 0 | 34 |
| SUM | 2 | 148 | 342 | **565** |

---

> "Streamlink Twitch GUI is a NW.js application, which means that it is a web application written in JavaScript (EmberJS), HTML (Handlebars) and CSS (LessCSS) and is being run by a Node.js powered version of Chromium." ([from Streamlink Twitch GUI's Github page](https://github.com/streamlink/streamlink-twitch-gui#description))

Since Streamlink Twitch GUI uses Chromium to render everything, Streamlink Twitch GUI can't support hardware video decoding since [Chromium doesn't support it on Linux](https://fossbytes.com/chrome-hardware-acceleration-on-linux-dont-expect-google/). Using a native player with wtwitch like mpv allows users to watch twitch streams with hardware video decoding which frees up resources for other programs and dramatically reduces battery usage on mobile devices.

And security seems to be a sore point with NW.js:
> "Node frames have following extra capabilities than normal frames: ... Bypass all security restrictions, such as sandboxing, same origin policy etc. For example, you can make cross origin XHR to any remote sites, or access to \<iframe\> element whose src points to remote sites in node frames." ([from the NW.js documentation](http://docs.nwjs.io/en/latest/For%20Users/Advanced/Security%20in%20NW.js/))

---

Wtwitch is written entirely in Bash, utilizing programs written mostly in C. It doesn't make any connections to any server other than Twitch's servers. As soon as a wtwitch command executes (e.g. `wtwitch -c`), wtwitch stops running -- it doesn't stay open. (Wtwitch does stay open when you're watching a stream, but it uses no CPU and less than 5 MB of RAM.) This design, along with native hardware video decoding, makes wtwitch much more resource efficient than Streamlink Twitch GUI.

Here's a list of the CLI programs Wtwitch utilizes to process data and the language they're written in: 

- [Wget](https://savannah.gnu.org/projects/wget/), written mostly in C
- [GNU coreutils](https://github.com/coreutils/coreutils), written nearly entirely in C and shell
- [jq](https://github.com/stedolan/jq), written nearly entirely in C

Wtwitch utilizes [Streamlink](https://github.com/streamlink/streamlink), which is written in Python, but it's only used when the user actually opens a stream to watch. Streamlink isn't used when doing anything else in wtwitch.
