---
project: embedded 
---
The schematics for the Arduino board itself are handy, and equally handy is the datasheet for the microcontroller it uses, the ATmega328P. The board uses another microcontroller, an ATmega16U2, to control the USB port, but it looks like most, if not all, of my code will focus on the -328P. Being a microcontroller as opposed to a microprocessor, it has all of the components it needs (RAM, Flash memory) self-contained, so important block diagrams and such are going to be found in the -328P datasheet (linked below).

I'll also be adding screenshots of particularly interesting diagrams to the gallery for this project. Not all of them will show up in actual posts, but I'll make sure to have links for each of the source documents.

## Relevent Links
- [ATmega328P Datasheet](http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-7810-Automotive-Microcontrollers-ATmega328P_Datasheet.pdf)
