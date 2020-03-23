# key2mod
Use a normal key as a modifier, e.g. Space acts as Control when pressed with a second key, but as Space when pressed alone.

## Installing
- Make sure you have [libevdev](https://www.freedesktop.org/software/libevdev/doc/latest/index.html) installed 
- Clone this repository and build with
```
gcc key2mod.c -o key2mod -Wall `pkg-config --cflags --libs libevdev`
```
- Copy the resulting binary to a directory in your $PATH, like /usr/bin/

## Usage
Access to /dev/input/* and /dev/uinput is required, this can be achieved by running this as root. Basic usage:
```
key2mod -e <eventfile> -k <key> -m <modifier>
```
Replace <eventfile> with the appropriate file for your keyboard in /dev/input (/dev/input/by-id makes finding the correct file easy), <key> and <modifier> with the keynames like KEY_SPACE or KEY_LEFTCTRL. These names can be optained by running `evtest <eventfile>`.
Use the option -f to run in the background. Example:
```
key2mod -e /dev/input/event0 -k KEY_SPACE -m KEY_LEFTCTRL -f
```
When receiving SIGINT or SIGTERM cleanup is performed and the program exits.

## How it works and limitations
This program reads all events coming from the keyboard, all events that are not ``<key> pressed`` are passed through to uinput. When ``<key> pressed`` is received, it waits for either any other key to be pressed or ``<key>`` to be released, to send the appropriate events to uinput.

This means that pressing the used key alone will generate the event at the release, which makes this unsuitable for games or other applications where timing is important. Also when trying to input a combination like shift+ctrl+key the normal modifier needs to be pressed first as otherwise the combination of modifiers and the key will be send separately.
