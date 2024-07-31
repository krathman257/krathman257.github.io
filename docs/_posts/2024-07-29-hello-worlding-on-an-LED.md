---
project: embedded
---
I've gotten to the "Hello, World!" point of this embedded project, and I've definitely found that the Arduino IDE is higher level than I'd like it, though it does have some perks.

Since boards generally don't have inherent displays, the book I'm following uses an easy to manipulate LED (which 99% of boards should have) to act as a basic first program: get the light to blink. Simple. TOO simple, in fact, since the Arduino comes with a variety of happy little functions that handle a lot of the low level manipulation for me, which backfires a bit when that's exactly what I'm trying to learn.

Here's the program that blinks the LED at 1Hz using Arduino's high level functions (the structure is still based on the book's recommendations):

```
const int LED_PIN = 13;
int ledState = LOW;

//Arduino structure
void setup(){
  ledInit();
}

void loop(){
  ledToggle();
  delay(500);
}

//Set LED pin to OUTPUT
void ledInit(){
  pinMode(LED_PIN, OUTPUT);
}

//Depending on LED state, flip to opposite
void ledToggle(){
  ledState = (ledState == LOW ? HIGH : LOW);
  digitalWrite(LED_PIN, ledState);
}
```

While intuitive, functions like `pinMode`, `digitalWrite` and `delay` are black boxes that don't teach me as much as I'd like. Thankfully, with the book's guidance and the documentation I've found (see previous posts), I was able to find the registers I needed to manipulate. Arduino still provides variables that point to the registers, so strictly speaking I didn't need to find the exact addresses, but it's still vindicating that I found the right ones anyway (proven by printing the variables to the Serial Monitor).

The pin I needed was Pin 13, which was controlled by the 5th bits of the Port B registers on the microcontroller. Only needing to change the 5th bit of each register, I created a bit mask for the bit manipulation, `0x20` (or `0010 0000`, the bits are labeled 0-7, remember).

`pinMode` is replaced by two lines of code. The first sets the proper bit in the Port B direction register, referred to as `DDRB`. This controls whether the pin is set for input or output. Since I needed it to be set high (for output), `OR`ing it with the bit mask activated it. The second line, though technically unneeded, sets the proper bit in the Port B data register low, turning the LED off. This was done by `AND`ing the register with the inverse of the bit mask. It's probably best to intentionally set the bit, but I don't think it's totally necessary, either.

`ledToggle` is a simple `if/else` statement. The conditional is whether the `AND` of the data register and the bit mask is 0: if it's not (meaning the 5th bit in the data register is high), disable it with the line used above (`AND` the masks inverse). Otherwise, activate it (`OR` the mask).

Making a custom `delay_ms` function was trickier. The book recommended a `while` loop iterating down the number of instructions it could complete in the given time (so milliseconds X instructions per millisecond), but that number needed to be `volatile`, or else the C compiler would optimize out the seemingly pointless loop. The issue is that the Arduino's 8-bit microcontroller wasn't liking that `volatile long` (a 32-bit data type). I ended up using Arduino's `millis` function to much the same effect, though I'm not sure the book meant for me to have access to a counter so early.

The complete code for the lower level solution is below (if I end up making a Git for this project, I'll add these there, as well):

```
/* 
 * DDRB = 0x24
 * PORTB = 0x25
 */
//Mask pointing to the 5th bit
#define P5_MASK (0x20)

//Arduino structure
void setup(){
  ledInit();

  //Print DDRB and PORTB addresses
  //Serial.begin(9600);
  //Serial.println((long) &DDRB, HEX);
  //Serial.println((long) &PORTB, HEX);
}

void loop(){
  ledToggle();
  delay_ms(500);
}

void ledInit(){
  //Initialize direction, data registers
  DDRB |= P5_MASK;
  PORTB &= ~P5_MASK;
}

void ledToggle(){
  if(PORTB & P5_MASK){
    //Turn LED off
    PORTB &= ~P5_MASK;
  }
  else{
    //Turn LED on
    PORTB |= P5_MASK;
  }
}

void delay_ms(int milliseconds){
  unsigned long currentTime = millis();
  while(millis() < currentTime + milliseconds);
}
```

Another facet of the Arduino IDE is that it allows me to easily compile and run this code, something that'll be covered in the book's next chapter. If it provides a lower level way to do that, I might be able to set the registers directly using their addresses, as opposed to the Adruino-defined variables.

## Update

I figured out the proper alternative to Arduino's premade register variables! Like I said, I had the addresses right (well, mostly, the process documentation gave two addresses per register, depending on the ASM instruction used, so I knew it was one of two addresses). The issue is that the macro I was setting for `DDR_B` was simply `(0x24)`, which C was reading as a number as opposed to an address. By declaring the macro as `(*(int *)0x24)` (read as "value of the integer pointer at address `0x24`"), and doing the same for `PORT_B`, I can set the registers directly without worrying about Arduino's standards!

I also figured out how to get `delay_ms` working without Arduino's `millis` function! The issue with the book's solution wasn't the `volatile` keyword, but that it was misinterpreting the `long` value when multiplying `int`s together. Defining `CYCLES_PER_MS` as `((long) 474)` instead of `(474)` fixed the function, and now the code is completely Arduino-independent.
