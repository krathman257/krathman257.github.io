---
project: dvdplayer
---
After a little poking and prodding, I managed to get Arch Linux properly installed on the external hard drive. There's still one or two teething problems, but overall things are going really well.

In looking at the other drives on the laptop (the ones that were showing up properly in the BIOS), they were all listed as MBR devices, rather than the UEFI I had set up the Linux installation as. The BIOS was also set to `Legacy` booting instead of `UEFI`, and since my Windows drive wouldn't boot under `UEFI`, I decided to just reinstall Linux with a MBR booting framework. The partitioning was very similar, except I didn't need an EFI partition. I'm using GRUB as the bootloader (note to self: set GRUB to not ask which OS to load during every boot. I only have one!). Here are the IDs I used to set the partitions' filesystems:
- Linux swap - 82
- Linux (ext4) - 83
- NTFS - 07

I'm not totally sure how related that issue was to the drive not being detected at all, though. There's a small chance the laptop can only see one bootable USB device at a time (which would have been an issue with both the external drive and installation USB plugged in), but I'm not sure that was it. The installation works fine now, but the drive is only detected on a reboot: I'll start the laptop, the drive won't be detected, reboot the laptop, and it's detected and boots just fine. I'm thinking that the external drive takes too long to spin up to be detected by the BIOS the first time. I hope that's the issue, since it won't be a problem when I make the move to USB.

## Setting up

I'm taking my time with setting up the environment. It's neat to have such a bare-bones distribution to work with.

I've identified a few services I want running on start-up, so I should probably figure out which file to add those to.

The Windows partition is working exactly as I hoped it would. I can add files to the partition from my desktop, mount the partition into `/external` on Linux and use the files as I normally would. It's also the only partition visible from Windows, which simplifies things. It should make it super easy to add video files I want to play from my TV (music files, as well?). I'll just need to make mounting the partition functional from a remote; either it'll happen on boot, or when that option is selected from whatever menu I end up making. One small issue that's recently occurred to me is that to plug the Dapvop USB into my computer, I'll need to shut the OS down completely (seems obvious in retrospect). It shouldn't be too much of a problem, but keep in mind to make that process as quick and effortless as possible.

I tried hooking the Dapvop up to my TV via HDMI, and it works perfectly. It clones the screen automatically, and a setting in the TV can have it default to the last input when starting up, so as long as the Dapvop is on, it shouldn't try to load all the extra apps and whatnot that I'm trying to avoid.

## Power play

I've come to the realization (again, it makes sense in retrospect) that turning the Dapvop on with a remote won't be trivial. The power button is located under the folded screen, and I don't think there's a way to trigger boot-up behavior via USB. A possible workaround to this may involve keeping the OS in a super low-power mode at all times, basically waiting for a signal from the remote to wake up and "turn on," but if the OS has to be completely shut down to be removed and connected to a Windows device for an MP4 transfer, that wouldn't necessarily work.

Just brainstorming here, but if I can keep the OS small enough, it might be possible to load the entire thing into the RAM, eject the USB, do what I need to at the Windows machine, and reinsert and resync the Linux files. For reference, the OS is currently taking up about 2.3 GB, and the laptop has about 8 GB of RAM.

I have no clue if that's feasible or not, but it's something to consider, at any rate.
