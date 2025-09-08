---
short_name: dvdplayer
name: Laptop-to-DVD-Player Conversion
github: https://github.com/krathman257/Dapvop
---
## Initial Thoughts

Combining a aged laptop with a mostly-useless Smart TV might be a bit overdoing it, but I might as well use it as an opportunity to learn some more Linux.

Smart TVs are too smart for their own good. Poor things, they don't know how bloated their software is. Everytime I want to watch a simple Youtube video, I need to go through autoplaying advertisments and loading screens. It's a small problem to have, to be sure, but what if I could use this problem to learn something?

I've got a laptop, all but worthless. I mean, it still works, but watching it try to boot up Windows 10 is like watching Thomas Parnell's Pitch Drop Experiment. It does, however, have a CD drive, and I'm sure it would to better with a lighter-weight operating system.

That sucker's getting turned into a DVD player.

## Final Thoughts

The Dapvop is completed. It runs off of a USB drive and can play DVDs, video files and Youtube videos, all while being controlled with a universal remote. Files can be uploaded either with the USB plugged into a different computer, or over wifi through a network drive. It does what I need it to do, faster and with fewer ads that the Smart TV it's taking over for. It's janky as all get-out, but that's part of the charm.

As I was developing the Dapvop, I came across Home Theater PCs, or HTPCs. A lot of the software they mention is essentially exactly what I was looking for, but by the time I found them, I was too invested in making my pile of Bash and jank. I'll leave some links down below in the Important Links section for posterity, because some of the programs mentioned, like Kodi, might be better solutions if I end up wanted to improve this, so it can be a better device, as opposed to half-learning experience, half-actual solution.

### Long Term TODO

These are just one or two bits of jank I might want to focus on if I ever come back to this project.

- There isn't a great way to turn the laptop monitor off while the HDMI output stays on. I tried using `xrandr` to switch them, but it caused a bit of weirdness with `ratpoison`, causing the displayed frame to go blank. Might be worth fixing.
- I initially planned for there to be a way to add bookmarked Youtube pages to the Dapvop's menu. That never materialized. It works fine as it is, since Youtube TV has an on-screen keyboard, but having a way to bookmark certain pages or playlists wouldn't be a bad feature.
- The laptop currently refuses to wake from sleep if the lid is closed. As far as I've seen, it's a hardware limitation of the laptop model, but if I feel like banging my head against a brick wall of a problem, that one's ripe for the picking.
- Many modern movies have a music-too-loud-voices-too-soft problem. This may be fixable using VLC's many options. Explore?
- `dialog`'s file selector is confusing to navigate. Find an alternative, or at least a better control scheme.
- Some of the packages I chose, Firefox and VLC specifically, I chose since I was more familiar with them. However, there might be more light-weight, simpler solutions. Look into bringing the Linux root directory size down from 5.1GB.

## Important Links

- [Arch Linux Wiki](http://wiki.archlinux.org)
- [Arch Linux Wiki - Installation Guide](http://wiki.archlinux.org/title/Installation_guide)
- [Wikipedia - Home Theater PC](https://en.wikipedia.org/wiki/Home_theater_PC)
- [/r/htpc Wiki](https://r-htpc.github.io/wiki/)
