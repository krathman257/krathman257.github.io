---
project: embedded 
---

These are mostly just some notes I have on embedded memory (from the O'Reilly book), and the memory on the Arduino specifically. I'm also including an update on the project in general at the bottom.

## Memory

Memory is divided into three categories: Random Access Memory (RAM), Read-Only Memory (ROM), and a Hybrid combination of the previous two. Each category has different flavors, but generally speaking, RAM is volatile (loses its information when it loses power) and is easy to write to, while ROM is nonvolatile and requires specific techniques to write information to it ("Read-Only" being a slight misnomer but decent general rule).

### RAM

RAM is a quickly-accessible memory type used for temporary data and operations, and has two major flavors, Static RAM and Dynamic RAM. SRAM holds its information so long as it has electricity, while Dynamic RAM requires a separate refresher module called a DRAM controller to constantly refresh held bits several times per second. Without the DRAM controller, the bits would quickly lose their information, though the advantage is that DRAM is much cheaper than SRAM.

### ROM

True ROM is mostly used for firmware, due to the difficulty with changing it. It can come in severl different flavors, mostly ranging in how it's programmed. Masked ROM is programmed in production and cannot be changed. Programmable ROM (PROM) can be bought blank and written to a single time. Erasable PROM (EPROM) can be erased with a special device, and then reprogrammed (though the process is more cumbersome than the Hybrid options below).

### Hybrid

Fancy, new-fangled space-age technology has allowed use to play God and combine RAM and ROM into memory types that have many of the advantages of each. Nonvolatile RAM (NVRAM) is standard RAM that has a power backup, ensuring that it never loses electricity, and so never loses its information, essentially acting nonvolatile. Electrically erasable PROM (EEPROM) is a form of EPROM that can be reprogrammed without the use of a special device, though it can only be written to a limited number of times. Flash memory is a standard for nonvolatile memory, being much, much less limited with rewrites than EEPROM.

### Memory on the Arduino

The Arduino Uno R3 has three forms of memory in the ATMega328P microcontroller, 2KB of SRAM, 32KB of Flash, and 1KB of EEPROM. The SRAM is used much as RAM is used on a standard computer, and the Flash memory is where any written code is uploaded to. EEPROM can be used to save information between system resets, such as state information (due to the memory type's limited write cycles, it's probably best to not mess with this until I have a decent project requiring something like that).

## Project Update

Up until now, I've been accessing the O'Reilly book I've been using, *Programming Embedded Systems* by Michael Barr, as a loaned library eBook on Libby. It's gotten renewed up until now, but someone has finally placed a hold on it, which means I'll lose access to this for a while. There are other books on embedded systems at the library to look through, and I can place a hold on this eBook or get a physical copy through the Interlibrary Loan system. In the meantime, I wanted to make a note of topics this book covers that I didn't get around to reading about, and want to make sure I learn about properly. At any rate, it's a lesson to try and keep a more consistent schedule, especially when I don't actually own the book I'm using!

- Memory testing (Data bus, Address bus, and Device tests)
- Bit manipulation
- Serial device drivers
- Interrupts
- Real-time operating systems
- Embedded Linux
- Common peripherals (Field programmable gate arrays, networking)
- Optimization
