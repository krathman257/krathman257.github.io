---
project: dvdplayer
---
A windows manager, that is! I've set up a tiling window manager to manipulate multiple programs simultaneously via keyboard shortcuts. There's still a lot of configuration to do, but along with playing video and audio properly(!!), progress was made.

The boot issue from the previous post, where the boot drive was only sometimes detected by the BIOS, went away on its own, the way computer problems sometimes do. Fingers crossed it doesn't pop up again.

## Ratpoison: A Window Manager

I've set up a tiling window manager called Ratpoison to allow me to switch between screens containing terminals and programs. Each screen is maximized, and can be switched with the configured hotkey command (the current default is Ctrl-t, but the Arch Linux wiki entry suggested the Windows logo button, which isn't a bad idea). Ratpoison runs on top of X11, a display server I needed to configure as well. Neither initially started on boot-up, but that was fixed by adding `exec startx` to `~/.bash_profile` (which starts the X11 server on login) and `exec ratpoison` to `~/.xinitrc` (which starts ratpoison when X11 starts).

Some minor configuration was needed. I added settings to X11 via `~/.Xresources` to, for example, change the text from black-on-white to white-on-black (dark mode FTW). I'm sure a lot of hotkeys are going to need to get changed around in Ratpoison, too, especially when I add the remote control.

## The Audio / Visual Experience

I have all three methods of watching videos that I want to implement working. I'm using Firefox for Youtube videos and VLC for MP4 files and DVDs. Initially, audio wasn't playing properly, but once I set up the PulseAudio package, I could control the sound levels with the `pavucontrol` GUI. I'll likely need to find the right terminal commands to adjust volume at some point, since the GUI is designed for a mouse. The same goes for Firefox and VLC, actually; both work fine with a mouse, but a remote control is closer to a keyboard, and I'll have to map the buttons to terminal commands and button presses, I'd imagine.

I know there are various extensions for Firefox that will likely help, such as adblockers and a Youtube TV emulator. VLC has some packages and modification I should look into, as well. There are some warnings in the terminal when it starts up, and there seems to be a little screentearing as video plays, as well.

## Networking

I found a solid networking interface that I think I'll be able to control with a remote control. It's a TUI (Text User Interface, which I didn't know had a term actually WAIT TWOEY LIKE IN LITTLE SHOP OF HORRORS I LOVE THIS) called Impala. It's set up to automatically connect to my home network, but I'll still need the ability to change networks since mobility is part of the point of this project. Impala has no `man` docs, but the controls are listed on its [Github page](https://github.com/pythops/impala?tab=readme-ov-file#-usage).

## `su` VS. `su --login`

One issue I had with getting some of these programs to run had to do with permissions. Some programs needed root access to run, and others specifically wouldn't run with root access. All the while, it seemed unclear what permissions I had, despite moving between root and my basic user, "dapvop".

It turns out, there's a difference between switching users with `su`, and using `su --login` or simply logging in as a certain user. When using `su`, it keeps the environment that the initial user was in. Specifically logging in, however, resets the environment, which dramatically changes the permissions that programs see the user as having (among many other things, I'm sure).

To avoid this issue in the future, be sure to log in as "dapvop" and use `sudo` when needed.

## Next on the Agenda

Immediate goals:

- Find a configurable, keyboard-controllable TUI/GUI to act as the Dapvop's home screen
- Configure Ratpoison's initial window arrangement and set up automatic windows for the main menu, Firefox, VLC, and Impala
- Explore and install Firefox extensions to make Youtube keyboard-controllable
- Find the best way to control VLC via keyboard

Long Term Goals:

- Explore sleep/hibernation options
- Decide how large of a USB drive to buy
- Decide which USB-remote control to buy
- Disable mouse cursor
