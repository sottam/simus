
unit h2wiringpi;

(* Pascal wrapper unit for Gordon Henderson wiringPi library. The source can
 * be found at https://http://wiringpi.com
 *
 * hwiringpi: origanal Wrapper and
 * pascal sample by Alex Schaller.
 *
 * Fork
 * h2wiringpi: Version 0.1 By Allen Roton
 * wiringPi Version 2.23
 * $linklib
 *
 * wiringPi:
 *	Arduino compatable (ish) Wiring library for the Raspberry Pi
 *	Copyright (c) 2012 Gordon Henderson
 ***********************************************************************
 * This file is part of wiringPi:
 *	https://projects.drogon.net/raspberry-pi/wiringpi/
 *
 *    wiringPi is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    wiringPi is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with wiringPi.  If not, see <http://www.gnu.org/licenses/>.
 ***********************************************************************
 *)




{$linklib c}
{$linklib libwiringPi}
interface
// Handy defines
const
//     NUM_PINS          =        17;
//     WPI_MODE_PINS	=	 0;
//     WPI_MODE_GPIO	=	 1;
//     WPI_MODE_GPIO_SYS	=        2;
//     WPI_MODE_PHYS	=	 3;
//     WPI_MODE_PIFACE	=	 4;
//     WPI_MODE_UNINITIALISED=	-1;

// Pin modes

 	INPUT	=		 0;
	OUTPUT	=		 1;
	PWM_OUTPUT=		 2;
	GPIO_CLOCK=		 3;
	SOFT_PWM_OUTPUT=	 4;
	SOFT_TONE_OUTPUT=	 5;
	PWM_TONE_OUTPUT=	 6;

	LOW=			 0;
	HIGH=			 1;
type
 TPinMode = (pm_INPUT,pm_OUTPUT,pm_PWM_OUTPUT,pm_GPIO_CLOCK,pm_SOFT_PWM_OUTPUT,pm_SOFT_TONE_OUTPUT,pm_PWM_TONE_OUTPUT);
const
// Pull up/down/none


	PUD_OFF=		 0;
	PUD_DOWN=		 1;
	PUD_UP=			 2;
type TpullRisistor = (prPUD_OFF  ,prPUD_DOWN , prPUD_UP );

const
// PWM

	PWM_MODE_MS=		0;
	PWM_MODE_BAL=		1;

// Interrupt levels

	INT_EDGE_SETUP=		0;
	INT_EDGE_FALLING=	1;
	INT_EDGE_RISING=	2;
	INT_EDGE_BOTH=		3;

 type  Tintlevles = (il_EDGE_SETUP,il_EDIGE_FALLING,il_EDGE_RISING,il_EDGE_BOTH);
 const
   PI_MODELS : array [0..7] of string = (
    'PI_MODEL_UNKNOWN',
      'PI_MODEL_A',
      'PI_MODEL_B',
      'PI_MODEL_BP',
      'PI_MODEL_CM',
      'PI_MODEL_AP',
      'PI_MODEL_2',
      'NEW_UKNOWN'
   );

     PI_VERSIONS : array [0..5] of string = (
     	'PI_VERSION_UNKNOWN',
	'PI_VERSION_1',
	'PI_VERSION_1_1',
	'PI_VERSION_1_2',
	'PI_VERSION_2',
        'NEW_UKNOWN'
     );

        PI_MAKERS : array [0..5] of string = (
	'PI_MAKER_UNKNOWN',
	'PI_MAKER_EGOMAN',
	'PI_MAKER_SONY',
	'PI_MAKER_QISDA',
	'PI_MAKER_MBEST',
        'NEW_UNKNOWN');




   const


{
// Pi model types and version numbers
//	Intended for the GPIO program Use at your own risk.

	PI_MODEL_UNKNOWN=	0
	PI_MODEL_A=		1
	PI_MODEL_B		2
	PI_MODEL_BP		3
	PI_MODEL_CM		4
	PI_MODEL_AP		5
	PI_MODEL_2		6

	PI_VERSION_UNKNOWN	0
	PI_VERSION_1		1
	PI_VERSION_1_1		2
	PI_VERSION_1_2		3
	PI_VERSION_2		4

	PI_MAKER_UNKNOWN	0
	PI_MAKER_EGOMAN		1
	PI_MAKER_SONY		2
	PI_MAKER_QISDA		3
	PI_MAKER_MBEST		4


 }

    // Pin mappings from P1 connector to WiringPi library
    // Px represents to physical pin on the RaspberryPi P1 connector

    // P1
    // P2
    P3  = 8;
    // P4
    P5  = 9;
    //P6
    P7  = 7;
    P8  = 15;
    //P9
    P10 = 16;
    P11 = 0;
    P12 = 1;
    P13 = 2;
    //P14
    P15 = 3;
    P16 = 4;
    // P17
    P18 = 5;
    P19 = 12;
    // P20
    P21 = 13;
    P22 = 6;
    P23 = 14;
    P24 = 10;
    // P25
    P26 = 11;
    // pi2
    P27 = 30;
    P28 = 31;
    P29 = 21;
    // P30 =  GND
    P31  = 22;
    P32 = 26;
    P33 = 23;
    //P34 = GND;
    P35 = 24;
    P36 = 27;
    P37 = 25;   // ops was 24
    P38 = 28;
    // P39 = GND
    P40 = 29;

    PI_2_WiretoPhy : array[0..29] of integer = (
      11, 12,     //0,1
      13, 15,     //2,3
      16, 18,     //4,5
      22, 7,      //6,7
      3,  5,      //8,9
      24, 26,     //10,11
      19, 21,     //12,13
      23, 8,      //14,15
      10,-17,     //16,17
     -18,-19,     //18,19
     -20, 29,     //20,21
      31, 33,     //22,23
      35, 37,     //24,25
      32, 36,     //26,27
      38, 40      //28,29
    ) ;
   // -1 GND
   // -5 5V
   // -3 3.3V
   // -6
   // -7
    PI_2_Phy_toWire : array [1..40] of integer =
      ( -3,  -5,
         8,  -5,
         9,  -1,
         7,   15,
        -1,   16,
         0,   1,
         2,  -1,
         3,   4,
        -3,   5,
         12, -1,
         13,  6,
         14,  10,
        -1,   11,
        -6,  -7,
         21, -1,
         22,  26,
         23, -1,
         24,  27,
         25,  28,
        -1,   29
      );
 // FROM gipo.c for alts
// static char *alts [] =
//{
//  "IN", "OUT", "ALT5", "ALT4", "ALT0", "ALT1", "ALT2", "ALT3"
//} ;
  altmodes : array[0..7] of string = ('IN', 'OUT', 'ALT5', 'ALT4', 'ALT0', 'ALT1', 'ALT2', 'ALT3');

    // Core wiringPi functions

//extern struct wiringPiNodeStruct *wiringPiFindNode (int pin) ;

//extern struct wiringPiNodeStruct *wiringPiNewNode  (int pinBase, int numPins) ;


//This initialises wiringPi and assumes that the calling program is going to be using the wiringPi pin numbering scheme. This is a simplified numbering scheme which provides a mapping from virtual pin numbers 0 through 16 to the real underlying Broadcom GPIO pin numbers. See the pins page for a table which maps the wiringPi pin number to the Broadcom GPIO pin number to the physical location on the edge connector.
//This function needs to be called with root privileges.
//extern int  wiringPiSetup       (void) ;
Function wiringPiSetup:longint;cdecl;external;

//This initialises wiringPi but uses the /sys/class/gpio interface rather than accessing the hardware directly. This can be called as a non-root user provided the GPIO pins have been exported before-hand using the gpio program. Pin numbering in this mode is the native Broadcom GPIO numbers – the same as wiringPiSetupGpio() above, so be aware of the differences between Rev 1 and Rev 2 boards.
//Note: In this mode you can only use the pins which have been exported via the /sys/class/gpio interface before you run your program. You can do this in a separate shell-script, or by using the system() function from inside your program to call the gpio program.
//Also note that some functions have no effect when using this mode as they’re not currently possible to action unless called with root privileges. (although you can use system() to call gpio to set/change modes if needed)
//extern int  wiringPiSetupSys    (void) ;
 Function wiringPiSetupSys:longint;cdecl;external;


// This is identical to wiringPiSetup, however it allows the calling programs to use the Broadcom GPIO pin numbers directly with no re-mapping.
// this function needs to be called with root privileges, and note that some pins are different from revision 1 to revision 2 boards.
//extern int  wiringPiSetupGpio   (void) ;
Function wiringPiSetupGpio:longint;cdecl;external;

//Identical to wiringPiSetupGpio, however it allows the calling programs to use the physical pin numbers on the P1 connector only.
// this function needs to be called with root priviliges.
//extern int  wiringPiSetupPhys   (void) ;
Function wiringPiSetupPhys:longint;cdecl;external;

//extern void pinModeAlt          (int pin, int mode) ;
Procedure pinModeAlt(pin:longint; mode:longint);cdecl;external;

//extern void pinMode             (int pin, int mode) ;
Procedure pinMode(pin:longint; mode:longint);cdecl;external;

Procedure pinMode_pas(pin:longint; mode:TPinMode);

//extern void pullUpDnControl     (int pin, int pud) ;
Procedure pullUpDnControl(pin:longint; pud:longint);cdecl;external;

//  This sets the pull-up or pull-down resistor mode on the given pin, which should be set as an input.
// Unlike the Arduino, the BCM2835 has both pull-up an down internal resistors.
// The parameter pud should be; PUD_OFF, (no pull up/down), PUD_DOWN (pull to ground) or PUD_UP (pull to 3.3v)
// The internal pull up/down resistors have a value of approximately 50KΩ on the Raspberry Pi.
//T his function has no effect on the Raspberry Pi’s GPIO pins when in Sys mode.
// If you need to activate a pull-up/pull-down, then you can do it with the gpio program in a script before you start your program.
procedure pullUpDnControl_pas(pin : longint ; pud : tpullRisistor);

//extern int  digitalRead         (int pin) ;
Function digitalRead(pin:longint):longint;cdecl;external;
//extern void digitalWrite        (int pin, int value) ;
Procedure digitalWrite(pin:longint; value:longint);cdecl;external;
//extern void pwmWrite            (int pin, int value) ;
Procedure pwmWrite(pin:longint; value:longint);cdecl;external;
//extern int  analogRead          (int pin) ;
Function analogRead(pin:longint):longint;cdecl;external;
//extern void analogWrite         (int pin, int value) ;
Procedure analogWrite(pin:longint; value:longint);cdecl;external;


// PiFace specifics
//	(Deprecated)

//extern int  wiringPiSetupPiFace (void) ;
//extern int  wiringPiSetupPiFaceForGpioProg (void) ;	// Don't use this - for gpio program only

// On-Board Raspberry Pi hardware specific stuff

//extern int  piBoardRev          (void) ;
Function piBoardRev:longint;cdecl;external;
// USE AT YOU OWN RISK
//extern void piBoardId           (int *model, int *rev, int *mem, int *maker, int *overVolted) ;
Procedure piBoardId(
  var modle : longint ;
  var rev : longint;
  var mem : longint;
  var maker : longint ;
  var obervolted :longint );cdecl;external;
// USE AT YOUR OWN RISK
function piboardtostr() : string ;

//extern int  wpiPinToGpio        (int wpiPin) ;
Function wpiPinToGpio(wpiPin:longint):longint;cdecl;external;
//extern int  physPinToGpio       (int physPin) ;
Function physPinToGpio(physPin:longint):longint;cdecl;external;
//extern void setPadDrive         (int group, int value) ;
Procedure setPadDrive(group:longint; value:longint);cdecl;external;
//extern int  getAlt              (int pin) ;
Function getAlt(pin:longint):longint;cdecl;external;
// from getalt to array of sting
function getaltpintostr(pin : longint):string;

//extern void pwmToneWrite        (int pin, int freq) ;
Procedure pwmToneWrite(group:longint; freq:longint);cdecl;external;
//extern void digitalWriteByte    (int value) ;
Function digitalWriteByte(value:longint):longint;cdecl;external;
//extern void pwmSetMode          (int mode) ;
Procedure pwmSetMode(mode:longint);cdecl;external;
//extern void pwmSetRange         (unsigned int range) ;
Procedure pwmSetRange(range:dword);cdecl;external;     //unsigned
//extern void pwmSetClock         (int divisor) ;
Procedure pwmSetClock(divisor:longint);cdecl;external;
//extern void gpioClockSet        (int pin, int freq) ;
Procedure gpioClockSet(pin:longint; freq:longint);cdecl;external;


// Interrupts
//	(Also Pi hardware specific)

// DEPICATED use wiringPiISR
//extern int  waitForInterrupt    (int pin, int mS) ;
Function waitForInterrupt(pin:longint;mS:longint):longint;cdecl;external;
//extern int  wiringPiISR         (int pin, int mode, void (*function)(void)) ;
Function wiringPiISR(pin:longint;mode:longint ;  pcallbback : pointer):longint;cdecl;external;
//  wiringPiISR
Function wiringPiISR_pas(pin:longint; mode:Tintlevles ;  pcallbback : pointer):longint;



// Threads

//extern int  piThreadCreate      (void *(*fn)(void *)) ;
//extern void piLock              (int key) ;
//extern void piUnlock            (int key) ;

// Schedulling priority

//extern int piHiPri (const int pri) ;

// Extras from arduino land

//extern void         delay             (unsigned int howLong) ;
Procedure delay(howLong:dword);cdecl;external;
//extern void         delayMicroseconds (unsigned int howLong) ;
Procedure delayMicroseconds(howLong:dword);cdecl;external;
//extern unsigned int millis            (void) ;
// This returns a number representing the number of milliseconds since your
//program called one of the wiringPiSetup functions. It returns an
// unsigned 32-bit number which wraps after 49 days.
Function millis:dword;cdecl;external;
//extern unsigned int micros            (void) ;
Function micros:dword;cdecl;external;

// where ?

Procedure wiringPiGpioMode(mode:longint);cdecl;external;





//extern void gpioClockSet        (int pin, int freq) ;



implementation
uses sysutils;

procedure pullUpDnControl_pas(pin : longint ; pud : tpullRisistor);
begin
  pullUpDnControl(pin,ord(pud));
end;

Procedure pinMode_pas(pin:longint; mode:TPinMode);
begin
     pinMode(pin, ord(mode));
end;
Function wiringPiISR_pas(pin:longint; mode:Tintlevles ;  pcallbback : pointer):longint;
begin

   result := wiringPiISR(pin,ord(mode) , pcallbback) ;

end;
function piboardtostr() : string ;

 var modle : longint ;
 var rev : longint;
 var mem : longint;
 var maker : longint ;
 var obervolted :longint;

begin
  result := 'UnKown';

  piBoardId(modle,rev,mem,maker,obervolted );

  result :=  'MODLE: ' + PI_MODELS[modle] + ' REV: ' + inttostr(rev) + ' MAKER: ' + PI_MAKERS[maker]    +    ' MEM: ' + inttostr(mem);

 // if obervolted <> 0 then
 //  result := result + ' OVER VOLT' + inttostr(obervolted );


end;

function getaltpintostr(pin : longint):string;
begin

  result := altmodes[ getAlt(pin) ];
end;
end.

