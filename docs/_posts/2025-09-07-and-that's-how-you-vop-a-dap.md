---
project: dvdplayer
---
It took a couple of days to remember how I configured everything, but it's all re-set up now. The whole Dapvop is on a USB drive, working perfectly. Or as well as it was working on the external hard drive, at any rate.

I created a [Github repository](https://github.com/krathman257/Dapvop) with the more important configuration files, including `dapvop_menu.sh`, and wrote a README describing the specific steps I took, so I won't go into those details here. Most of the important points are described in my previous notes here, anyway.

## Final Statistics

The final size of the root directory was 5.1GB. I'm sure that could be smaller if I used a lighter-weight solution for Youtube or VLC, but I'll put shrinking the size in my long term TODO list on the main project page.

As for loading times, here's how long it took to get to a Youtube video without the Dapvop:
- TV completely off: 90s
- TV asleep: 45s

Here's how long it takes with the Dapvop:
- TV off, Dapvop off: 74s
- TV asleep, Dapvop off: 46s
- TV asleep, Dapvop asleep: 20s

So yeah, the time improvement isn't too bad, especially when you factor in that there are no Youtube ads.

## How Windows Treats Hard Drives vs. USB Drives

When I initially set up Dapvop Alpha with the partitions it needed to separate the root directory from the windows-visible storage, the storage partition was the only one visible when I plugged it into Windows. Which is precisely how I wanted it. "Good!" I thought, the silly little naif that I was, "That's one less problem!" Imagine my surprise when I set up the exact same partition table on a USB drive, and plugging it into Windows led to a flood of pop-ups apologizing for not being able to open two partitions, and asking if I'd like to format them.

Apparently, Windows is more forward with USB partitions than hard drives. I had to do some digging to find a solution to hide the Linux partitions from Windows, and the solution I found is a tad convoluted, but it works.

Originally, the partition table was set up as a BIOS with MBR setup. I had to add a 1MB partition for GRUB to load from due to the change, but switching from MBR to GPT gave me access to various attributes I could set with `gdisk`, namely 62 (hidden) and 63 (no auto-mount); once I set the Linux partitions with those, they no longer showed up in Windows Explorer. The catch is that the partition types MUST be a Microsoft type (I chose `Microsoft Basic Data`), as opposed to the `Linux` or `Linux Swap` types they were before. Thankfully, Linux doesn't care, it boots just fine either way.

Slightly more annoyingly, when configuring GRUB, the 1MB partition it loads from HAD to be of type `BIOS Boot`, or else it wouldn't be able to find it. Once GRUB was configured, I switched it back to `Microsoft Basic Data` and it still behaves the way I'd expect it to, but it still feels like a janky solution.

## Github's File Size Limit

Originally, my plan was to upload an image of the disk to Github, letting people download the image and load it to their own USB drive, but the people who run Github (cowards) apparently have a file size limit in place: you get a warning for anything over 50MB, and anything over 100MB is blocked entirely.

Look, I understand that Github isn't really the place for disk images, and putting my configuration files in the repository instead showcases what needed to be configured better, anyway. I understand that.

They're still cowards, though.

## And Lo the Sun Sets on Another Project

I set out to turn my laptop into a DVD player, and I did. I mean, it's not the *best* solution, but I learned some Linux, a bit of Bash, got a little Jurassic Park-y along the way, and it does work. I'll update the main project page, and add a bit about possible room for improvement
