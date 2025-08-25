---
project: dvdplayer
---
I've got the Dapvop working in a state that I'm happy with, or happy enough with. It's completely functional now, letting me browse to DVDs, video files, and Youtube with a remote control. It's still a little janky, but it does what it needs to, so I'm going to put some finishing notes here, and then work on getting it configured properly on a USB drive (as opposed to the external hard drive it's on right now).

## Controlling Remotely with a Remote Control

There were a few options I toyed with to control the Dapvop remotely, including a phone app written in Android Studio that could have connected via Wifi or Bluetooth. In the end, I opted for the most intuitive, if more hardware-dependent option. I got a Flirc USB IR receiver, which lets me program any universal remote to perform keypresses. I tried configuring the remote so that I could use the same one as the remote I use for the TV, but things got too convoluted when both machines started interpreting keypresses, so I got a second remote to control the Dapvop.

The keypresses are configured using the package `flirc_util` to control which remote button acts as which keypress. Keypresses can also include modifiers, like Control or Alt, or basic functions, like Sleep. Unfortunately, I didn't see a way to have button presses directly translate to terminal commands, but that ended up not being an issue.

## My Laptop is a Heavy Sleeper

One issue I didn't expect to have is what I can only conclude is a hardware issue with my laptop model. For reference, I'm using an Acer E5-575-33BM. A feature I've wanted to add is the ability to put the laptop in a Sleep or Hibernate state, either from the Dapvop menu or a remote keypress, and wake it up with a keypress from the remote. This works just fine, AS LONG AS THE LAPTOP MONITOR IS OPEN. I've searched through the BIOS settings, looked at forums and whatnot, and as far as I can tell, this model of laptop will not wake up from a sleep state if the laptop is closed. What's more, if the laptop is closed, it often goes to sleep automatically after a short while, even if a video is playing.

I've thought about looking into workarounds, but honestly, it isn't too much of an issue to have the laptop cracked open a bit to keep it responsive. One aspect of this project I try to keep in mind is its portability, and it's impossible to tell what hardware quirks each laptop the I plug the Dapvop into will or won't have. I'm not sure when or if I might even test this on another laptop, but in the meantime, this is a quirk I don't mind living with.

The automatic sleeping feels like it has a solution, though. I might have to look into solving that issue, if only because it irks me a bit that it's unsolved.

## Monitor Goes On, Monitor Goes Off

Another issue I ran into is controlling which screens, between the laptop screen and the TV, do and don't display. There have been times when I boot up the Dapvop, plugged into the TV, and the TV refuses to recognize a signal until I run a `xrandr` command. What's more, I was hoping to find a way to switch the laptop screen off if I press the right remote button; if the laptop has to be left cracked open, I might as well turn it off when I'm looking at the TV, right?

I wrote a quick bash script to cycle through which screen is on and which is off, but for some reason, the `xrandr` command messes with `ratpoison`, or possible `xorg` as a whole. It'll enable and disable the right monitors, but the enabled screens won't properly show the `ratpoison` frames unless I actively flip to a different one. I'm not sure why the monitors are re-enabling blank like that, but again, it's not too much of an issue; the laptop monitor being on isn't a distraction, and if it becomes one, I can revisit the issue.

For now, I've added an option in the Dapvop's Settings menu to Detect Monitors, which runs a `xrandr` command to enable both the TV and the laptop monitor.

## Next steps

Now that I've got ArchLinux more or less configured how I want it, my next move is going to be to reinstall everything onto a USB drive. "Reinstall" being the key word here; I installed a lot of packages and files that aren't necessary anymore as I tested different solutions to problems, and the root directory now takes up more space than it needs to. I *could* go through and uninstall and delete anything I don't need anymore, but my reasoning is that going through a second time to configure all these packages and settings will help me learn the process better. Repetition, repetition, repetition, right?

I won't be doing it from scratch, though. I'm going to copy a few config files and other things (including the Dapvop menu script, natch) over to the USB, so I won't need to reconfigure *everything*. I might have to bounce back and forth between Dapvop Alpha nd the USB installation before I get everything right (who needs virtual machines?), but here's a cursory list of the packages I'm using in the final configuration (there may be more I'm forgetting, I'll make sure to note those in my next post):

`e2fsprogs`, `ntfs-3g`, `sof-firmware`, `vim`, `man-db`, `man-pages`, `texinfo`, `xorg`, `ratpoison` (AUR), `pavucontrol`, `vlc`, `firefox`, `firefox-ublock-origin`, `dialog`, `samba`, `flirc-bin` (AUR), `networkmanager`, `wsdd`, `ufw`

`df -h` lists my root directory at 8.9 GB, we'll have to see how that changes in the fresh configuration.
