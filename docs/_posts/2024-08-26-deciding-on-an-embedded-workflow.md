---
project: embedded 
---
Despite the code working fine, it was a bit of a hassle to figure out a toolchain that would upload the code to the Arduino properly. When working from such a basic level, there aren't any error messages; either the LED blinks properly, or it doesn't. For the longest time, no matter what flags I used, the LED would blink three times, pause, and repeat. This turned out to be the Arduino's way of starting up (shown by the three blinks), finding no code in the right spot, and restarting from the top (starting up again, blinking three more times, and repeat). After a lot of trial and error (and watching what the Arduino IDE used when switched to `verbose` mode), I did finally find a toolchain that would let me upload code properly.

## Compile

`avr-gcc -Os -Wall -mmcu=atmega328p -DF_CPU=16000000L -c -o blink.o blink.c led.h time.h`

`gcc` is the tried and true GNU C compiler, and the AVR-specific `avr-gcc` works exactly as designed.
- `-Os` optimizes the output file for size
- `-Wall` sets the tool to display all warning messages
- `-mmcu` specifies the target, in this case, the Arduino's ATMega328P
- `-DF_CPU` defines the target's clock speed
- `-c` sets the compiler to compile the code but not link it
- `-o` sets the output file

`avr-gcc` is also used to link the resulting object file into a `.elf`

## Copy

`avr-objcopy -O ihex -R .eeprom blink.elf blink.hex`

Why this step is needed will take more research, though the book I'm following does mention that some boards require steps like this. An AVR-specific version of `objcopy` is used to convert the `.elf` executable into a `.hex` file.

- `-O` specifies the ouput format, in this case, an Intel Hex format
- `-R` removes the EEPROM section from the executable. Again, more research is needed to figure out why

## Upload

`avrdude -p atmega328p -c arduino -P /dev/ttyACM0 -U flash:w:blink.hex:i`

And then the magic happens: the executable is uploaded to the board with a tool called `avrdude`.

- `-p` specifies the microcontroller
- `-c` specifies the programmer
- `-P` specifies the device port that the target is connected to
- `-U` performs a memory operation. The format is `[MEMORY TYPE]:[OPERATION]:[FILE]:[FILE FORMAT]`

The file gets uploaded and the LED starts blinking the way it should.

## Helpful Tools

Since all of this was put into a `Makefile`, I added two other commands to help with the process. `clean` removes any generated files, and `dump` uses `avrdude` to read the Arduino's flash memory into a dump file. Reading the dump with `xxd` can show how the data is formatted in memory.

## Debugging

Now this was a point of particular pain for me. The O'Reilly book I'm following has a great deal to say on debugging, and I really wanted to use some of the tools mentioned to do some in-depth analysis as I learned: setting breakpoints, reading memory addresses on the fly, all that jazz. The issue is with the hardware available on the Arduino.

My original plan was to use another tried and true GNU tool, `gdb`, which has an AVR version helpfully names `avr-gdb`. From what I can tell, `gdb` needs a small piece of software running on the Arduino to communicate with as it takes control of the CPU (for functions such as breakpoints). The issue is that the piece of software I found, called `avarice`, communicates with JTAG, a hardware standard that supports on-chip debugging. Unfortunately, the ATMega328p doesn't use JTAG, but a different standard called debugWire.

debugWire does allow debugging control, but does so over the RESET pin of the microcontroller. That's all fine and dandy, but the RESET pin is connected to various bits of the Arduino board. For example, it's used along with the USB port to allow the board to reset while code is uploaded. There is a section on the board meant to be separated and soldered as necessary, which would allow the RESET pin to be used for debugging, but that requires tools that I don't have.

Reading online, it seems the easiest solution is the use the Serial library built into the Arduino IDE to `println` relevant messages to the Serial Monitor. Naturally, I haven't learned enough about the board to write my own Serial library, so for now, future code will probably be written in the Arduino IDE for testing purposes. 

I plan on using pre-built Arduino functions as little as possible, and migrating back to my toolchain when I have some form of custom debugging solution. Choosing a learning environment is tricky task; is it better to learn with as many pre-built tools to aid me as possible, using professionally crafted IDEs and libraries keeping me from reinventing the wheel, or should I start as low-level as possible, using `vim` and CLI tools to force me to learn the processes and nitty-gritty details? Is top-down or bottom-up learning more effective for diving into embedded systems? I don't know, but one thing's for sure: learning embedded programming with no form of debugging would only be needless handicap and a fast lane to frustration.
