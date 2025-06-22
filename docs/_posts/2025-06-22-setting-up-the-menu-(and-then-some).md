---
project: dvdplayer
---
It's been a hot second since I've posted, but that doesn't mean I've been doing nothing. The biggest amount of progress was made in the use of the `dialog` package, which lets me program a menu with Bash commands. I also managed to set up a network drive for filesharing (despite my firewall) and various other improvements (including a Jurassic Park-y tangent at the end).

## Creating a Menu with `dialog`

As mentioned in my previous post, I needed a way to program a custom menu to navigate the Dapvop's services with a remote. What I found was a programmable TUI called `dialog`. Each menu screen can be called with a bash command, and the output can be captured in a variable to be used in other commands. There are tons of options for screens, including a calendar and password input form, but the one's I've found most useful so far are `menu`, which generates a list of options to be chosen from, and `fselect`, which lets as user browse a directory and choose a file. I'm still not sure what I'm going to use for the Youtube bookmarks, since those are editable and need to be easy to change, but there's enough flexibility that I'm sure there's a good way to design it.

As a note, pulling input from the `dialog` command is nontrivial. The command prints the interface to the Standard Output stream, and the actual chosen value to Standard Error. To actually store that in a variable, each `dialog` command is followed by a series of stream redirections (learned from [this man](https://www.youtube.com/watch?v=FJ7KJXmZRXA)). Essentially, the steps are as follows:
- `3>&1` opens a new I/O stream and feeds it to `stdout` (which is always 1)
- `1>&2` feeds the `stdout` I/O stream (1) into `stderr` (2)
- `2>&3` feeds the `stderr` I/O stream (2) into the custom stream (which is directed at `stdout`)
- `3>&-` closes the custom I/O stream
As best as I can tell, this serves to swap the Standard Out and Standard Error streams, but like a more conventional language would create a `temp` variable to store a value while the values of `x` and `y` are swapped. At any rate, it works beautifully, and I can store the user's selections in variables and run commands on them.

## Learning a Bit of Bash

Since `dialog` runs as a Bash command, the entire menu is being developed as a Bash script, something I might've done years ago in college, but it's been long enough that the syntax has since escaped me. I took a shorter Bash scripting course through Udemy, and I've got a good enough grasp on it that I'm making very solid progress. At the moment, the main menu, "Play DVD" option and "Play file" option are functional. There's a bit of fine-tuning to do, but they properly open VLC and play what I select.

{% include imagePost.html image="dapvop_menu.png" caption="The main menu of the Dapvop, designed with `dialog`" %}

`fselect` has proven to be a bit finicky. There are four "subscreens" that the user can tab through: a list of subfolders, a list of files, the currently selected file name, and the "OK" and "Cancel" buttons. It isn't very intuitive at the moment, but I can probably clean it up a bit once I'm mapping keypresses to a remote control.

There was an issue with `sudo`ing commands inside the script, as well. Originally, I had the script detect if the Windows-compatible partition was mounted, and if not, mount it. The `mount` command requires root access, so to run it within the script, the entire script would need to be run with `sudo`. However, VLC CAN'T be run with `sudo`, presumably for security reasons. This was simple enough to fix by setting the partition to mount on boot, removing the need to run the script with `sudo`.

## Setting up a Network drive

In a previous post, I mentioned the issue of putting files onto the Dapvop from a Windows computer, and the issue of needing to remove the whole drive from the laptop to do that. The solution I went with was to set up the Windows partition as a network-accessible drive using a package called `Samba`. Now, the drive is accessible to anyone on the same network, as long as they input the right login credentials. I can still plug the Dapvop into a Windows machine and transfer files that way as well, but this way I can copy files over the network with ease.

I had more trouble setting up Samba than I'd like to admit, primarily due to the firewall. The [wiki](https://wiki.archlinux.org/title/Samba) mentioned which ports needed to be open (137 and 138 through UDP, 139 and 445 through TCP), but no matter what combination of commands I entered through the backends (`iptables` and `nftables`) or the frontends (`firewalld` and `ufw`), the packets sent by my Windows machine to attempt connection kept being blocked (as shown by the `tcpdump` command). As near as I can figure, there were conflicting rules when multiple rulesets were being operated at once. I ended up with a `ufw` configuration that seems to be working.

## `ratpoison` Commands and Screenshotting

A large part of the keymapping I'll have to do can be set up with `ratpoison` keybindings, I think. I've already bound a few helpful commands in the `.ratpoisonrc` file in the home directory. At the moment, I've set Ratpoison's control key to be the Windows button, and I can take screenshots with WIN+F12. Those are saved in a folder in the home directory. Pretty handy for documenting this thing.

## Bonus: It's a Unix System (I Know This)

When I was looking for a good GUI to use with a remote, I had the inspiring idea (or possibly intrusive thought) to see if I could use the file visualizer from the end of Jurassic Park [as seen in this scene](https://www.youtube.com/watch?v=JOeY07qKU9c&t=31s). The system shown in the film is Silicon Graphics' 3D File System Navigator, an actual program, and one that inspired a Linux package called [File System Visualizer](https://fsv.sourceforge.net/). I thought I'd make a good GUI, but unfortunately, "hehe dinosaur movie" quickly turned into multiple false starts and failures to install the program (I got it working in the end, keep reading, ya goof).

The package itself is early-2000s-old, and depends on older versions of various other software, such as OpenGL. Trying to install it with a downloaded tarball didn't work, but I eventually found a version on ArchLinux's AUR repository (that I should have checked more thoroughly first, to be honest). THAT version got much closer to installing, but there were still some compatibility issues. I manually installed a few dependencies, and changed a few lines of C that were refusing to compile, and I eventually got it to run properly!

{% include imagePost.html image="file_system_visualizer.png" caption="A visualization of Dapvop's `/bin` with FSV" %}

File System Visualizer is just that, however, a visualizer. It can't actually run the files selected. Part of my Far Future TODO for this project may be to write a simple OpenGL GUI to emulate Jurassic Park's file navigator, but for now I'll be happy to get something feature complete.

Solving labyrinthine computer problems can be exhausting as it is, but at least I don't have to do it while velociraptors are breaking the door down.
