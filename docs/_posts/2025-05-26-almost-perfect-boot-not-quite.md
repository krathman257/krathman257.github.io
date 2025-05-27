---
project: dvdplayer 
---
Having all but decided to make the Dapvop's software a USB-bootable installation of Arch Linux, I was trying to decide what size USB to order. Just when I had decided to actually research the installation sizes of the packages I expected to use, I realized I had a spare 1 TB external hard drive lying around, so it gets the honor of hosting Dapvop-Alpha (I might have set the hostname to -Beta, but that's an easy fix for later).

I followed the installation guide on the Arch Linux wiki (links to that guide and the wiki in general are in the project page), and good gravy that thing is comprehensive. It laid out every step with tons of documentation and explanations for even the most basic utilities (much appreciated, since despite having probably used many of these before, a detailed refresher is more than needed). Since it's so comprehensive, I won't be going over my exact process (seriously, read the guide!), but I will make a note of anything in particular I changed for this particular installation.

## Partitioning

When partitioning the hard drive, I mostly followed the recommendations of the guide, with an additional partition that may or may not play out how I hope it does. I'll also note the filesystem ID used during setup:
- EFI System Partition (1 GB) [1]
- Linux Swap (4 GB) [19]
- Linux x86-64 root (128 GB) [23]
- Windows Basic Data (The rest, ~730 GB) [11]

That last partition is intended to be able to hold MP4s that I can load from a Windows computer and play right from the Dapvop. At least at this stage, it works exactly the way I hoped: it was the only recognizable partition on my main desktop outside of the hard drive manager.

## Additional Packages

In addition to the default packages installed with Arch Linux, the guide recommended a few additional categories of packages to install at the same time. This is a list of what I chose:
- `intel-ucode` - To help with Intel processor microcode updates... or something. I think.
- `e2fsprogs` - Filesystem utilities for ext4 (the Linux partition)
- `ntfs-3g` - Filesystem utilities for NTFS (the Windows partition)
- `iwd` - Wireless network daemon
- `sof-firmware` - Apparently good for laptop audio systems
- `nano` - Basic text editor
- `vim` - Cool cat text editor for hotkey enjoyers
- `man-db`, `man-pages`, `texinfo` - Help page utilities

## Booting Issue

While the drive does register properly from my desktop, the laptop isn't registering it as a bootable medium. I think the issue lies in the Boot Loader step at the end. I read through it and it almost seemed as though it would be handled automatically because of the way I partitioned the drive, but I should give it more of an in-depth readthrough. It's looking like I can set up an EFI boot stub, but I'm not totally sure what that means (hence the reading I still need to do).

As a note, on step `1.6 Verify the boot mode`, the command returned `No such file or directory`, meaning it booted in BIOS mode as opposed to UEFI. Again, not too sure what that means or if it's related to the laptop's inability to recognize the drive, but there's a lot of acroynms crossing over between the two issues, so better to write, I suppose.

## The False Alarm

The final step in the installation guide involves rebooting the computer and removing the installation medium (so the computer can, theoretically, boot from the newly installed OS). When I did that, my laptop suddenly wouldn't even post to the BIOS- it immediately went to a "Critically low battery" screen I'd never seen before and shut down. Kind of standard for a laptop, but the friggin thing was plugged in.

Since it had popped up just as I was trying the reboot, and no amount of unplugging and replugging was fixing the low battery screen, I was worried I had somehow bricked it, and the motherboard's firmware couldn't read the battery level or something. Imagine my suprise when I plugged it into a different outlet, and then it started charging properly.

I'm not saying literally every computer problem can be solved by unplugging it and plugging it back in, but what bad timing, to run out of battery JUST as I'm trying a fresh boot.
