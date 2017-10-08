unit FirmataConstants;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const
   FIRMWARE_MAJOR_VERSION =  2;
   FIRMWARE_MINOR_VERSION =  5;
   FIRMWARE_BUGFIX_VERSION = 7;

   {
    Version numbers for the protocol.  The protocol is still changing, so these
    version numbers are important.
    Query using the REPORT_VERSION message.
   }
   PROTOCOL_MAJOR_VERSION =  2; // for non-compatible changes
   PROTOCOL_MINOR_VERSION =  5; // for backwards compatible changes
   PROTOCOL_BUGFIX_VERSION = 1; // for bugfix releases

   MAX_DATA_BYTES =          64; // max number of data bytes in incoming messages

  // message command bytes (128-255/0x80-0xFF)

   DIGITAL_MESSAGE =         $90; // send data for a digital port (collection of 8 pins)
   ANALOG_MESSAGE =          $E0; // send data for an analog pin (or PWM)
   REPORT_ANALOG =           $C0; // enable analog input by pin #
   REPORT_DIGITAL =          $D0; // enable digital input by port pair

   SET_PIN_MODE =            $F4; // set a pin to INPUT/OUTPUT/PWM/etc
   SET_DIGITAL_PIN_VALUE =   $F5; // set value of an individual digital pin

   REPORT_VERSION =          $F9; // report protocol version
   SYSTEM_RESET =            $FF; // reset from MIDI

   START_SYSEX =             $F0; // start a MIDI Sysex message
   END_SYSEX =               $F7; // end a MIDI Sysex message

  // extended command set using sysex (0-127/$00-$7F)
  { $00-$0F redevved for udev-defined commands }

   SERIAL_DATA =             $60; // communicate with devial devices, including other boards
   ENCODER_DATA =            $61; // reply with encoders current positions
   devVO_CONFIG =            $70; // set max angle, minPulse, maxPulse, freq
   STRING_DATA =             $71; // a string message with 14-bits per char
   STEPPER_DATA =            $72; // control a stepper motor
   ONEWIRE_DATA =            $73; // send an OneWire read/write/reset/select/skip/search request
   SHIFT_DATA =              $75; // a bitstream to/from a shift register
   I2C_REQUEST =             $76; // send an I2C read/write request
   I2C_REPLY =               $77; // a reply to an I2C read request
   I2C_CONFIG =              $78; // config I2C settings such as delay times and power pins
   REPORT_FIRMWARE =         $79; // report name and version of the firmware
   EXTENDED_ANALOG =         $6F; // analog write (PWM, devvo, etc) to any pin
   PIN_STATE_QUERY =         $6D; // ask for a pin's current mode and value
   PIN_STATE_RESPONSE =      $6E; // reply with pin's current mode and value
   CAPABILITY_QUERY =        $6B; // ask for supported modes and resolution of all pins
   CAPABILITY_RESPONSE =     $6C; // reply with supported modes and resolution
   ANALOG_MAPPING_QUERY =    $69; // ask for mapping of analog to pin numbers
   ANALOG_MAPPING_RESPONSE = $6A; // reply with mapping info
   SAMPLING_INTERVAL =       $7A; // set the poll rate of the main loop
   SCHEDULER_DATA =          $7B; // send a createtask/deletetask/addtotask/schedule/querytasks/querytask request to the scheduler
   SYSEX_NON_REALTIME =      $7E; // MIDI Redevved for non-realtime messages
   SYSEX_REALTIME =          $7F; // MIDI Redevved for realtime messages

  // pin modes
   PIN_MODE_INPUT =          $00; // same as INPUT defined in Arduino.h
   PIN_MODE_OUTPUT =         $01; // same as OUTPUT defined in Arduino.h
   PIN_MODE_ANALOG =         $02; // analog pin in analogInput mode
   PIN_MODE_PWM =            $03; // digital pin in PWM output mode
   PIN_MODE_devVO =          $04; // digital pin in devvo output mode
   PIN_MODE_SHIFT =          $05; // shiftIn/shiftOut mode
   PIN_MODE_I2C =            $06; // pin included in I2C setup
   PIN_MODE_ONEWIRE =        $07; // pin configured for 1-wire
   PIN_MODE_STEPPER =        $08; // pin configured for stepper motor
   PIN_MODE_ENCODER =        $09; // pin configured for rotary encoders
   PIN_MODE_SERIAL =         $0A; // pin configured for devial communication
   PIN_MODE_PULLUP =         $0B; // enable internal pull-up resistor for pin
   PIN_MODE_IGNORE =         $7F; // pin configured to be ignored by digitalWrite and capabilityResponse

   TOTAL_PIN_MODES =         13;

implementation



end.

