# qml wayland mini desktop

webmonkey having fun with qml and wayland...

![screencap](wincap.gif?raw=1)

## features

- mouse button visualiser
- editable cursor text (speech) bubble
- window preview list on the left
- selected window maximised on the right

## usage

1. save a small image as `avatar.png` (the one from kernel.org fits nicely;)
2. change keyboard layout in [`startw`](./startw)
3. run: `./startw`

> NOTE: i only tried this on x11...

## deps

- qt6-declarative
- qt6-wayland
- qt6-quickcontrols2 (TODO: replace SwipeView?)
- pyside6
- qterminal (or change the terminal in [`main.qml`](./main.qml))

> with small modifications this should also work with qt5 and pyside2

## todo

- middle click in window list to close main window?
- left click in window list should focus main window?
- keyboard shortcut visualiser?
- speech to text...
  - tried [vosk](https://alphacephei.com/vosk/), "simple" setup, but got hilarous (and even "dangerous") results... (or my english is just that bad...)

<br>
<hr>

All files in this repo - _where i have the say about_ - shall be in Public Domain.
