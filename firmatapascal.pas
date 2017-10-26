{===============================================================================
|Firmata Protocol Implementation for FreePascal on Lazarus
|This implements version 2.6 of Firmata
|For serial interface on multiplatform it will use synaser.
|A part of Ararat Synapse Project
================================================================================}

unit FirmataPascal;

{$mode objfpc}{$H+}

interface

uses
  Classes, firmataconstants, SysUtils, synaser, Crt, StrUtils;

type
  TPino = record
    mode : byte;
    digitalValue : boolean;
    pwmValue : uint16;
    analogValue : uint16;
  end;

var
  dev: TBlockserial;
  bufIn: array[0..MAX_DATA_BYTES] of byte;
  bufOut: array[0..MAX_DATA_BYTES] OF byte;
  pins: array[0 .. 127] of TPino;
  Major_version, Minor_version: byte;
  Firmware_name: UnicodeString;
  CommListener : TProcedure;
  RunningListener : TThread;
  initialized : boolean;
  SelectedComm : String;




procedure initializeComm;  //Implementar algum tipo de auto deteccao de arduino
procedure initializeComm(port : String);
procedure finalizeComm;
procedure initializePins;
procedure askFirmware;     // Does not return the firmware, it is only used to determine if firmata is ready.
procedure setPinMode( pin: byte; mode: byte);       //working
procedure digitalWrite( pin: byte; value: byte);    //working
procedure analogWrite(pin: byte; value: byte);      //working
procedure digitalReport(port: byte; enabled: boolean);
procedure analogReport(pin: byte; enabled: boolean);
procedure SamplingInterval(interval : uint16);
procedure firmataReset();

function digitalRead(pin:integer) : integer;
function analogRead(pin:integer)  : integer;

procedure firmataParser();
procedure listenTx();
procedure purgeBuffer();

function ToBoolean(int : integer) : boolean;

implementation

procedure initializeComm;
    begin
      CommListener := @listenTx;
      dev:= TBlockserial.Create;
      writeln('Waiting for arduino to initialize...');
      writeln( synaser.GetSerialPortNames);
      dev.Connect(selectedComm);
      dev.config(57600,8,'N',SB1,false,false);

      if (dev.LastError <> 0) then
         begin
            Exit;
         end;


      askFirmware;
      initializePins;
      SamplingInterval(250);
      TThread.CreateAnonymousThread( CommListener ).Start;
      initialized := true;
      writeln('Arduino is ready!');
    end;

procedure initializeComm(port : String);
    begin
      if (initialized = false) then
         begin
            CommListener := @listenTx;
            dev:= TBlockserial.Create;
            writeln('Waiting for arduino to initialize...');
            dev.Connect(port);
            dev.config(57600,8,'N',SB1,false,false);

            if (dev.LastError <> 0) then
               begin
                  Exit;
               end
            else
              begin
                  askFirmware;
                  initializePins;
                  SamplingInterval(250);
                  RunningListener := TThread.CreateAnonymousThread( CommListener );
                  RunningListener.Start;
                  initialized := true;
                  writeln('Arduino is ready!');
              end;
         end
      else
        begin
          RunningListener.Terminate;
          dev.Purge;
          dev.Free;
          dev:= TBlockserial.Create;

          writeln('Waiting for arduino to initialize...');
          dev.Connect(port);
          dev.config(57600,8,'N',SB1,false,false);

          if (dev.LastError <> 0) then
               begin
                  Exit;
               end
            else
              begin
                  askFirmware;
                  initializePins;
                  SamplingInterval(250);
                  RunningListener := TThread.CreateAnonymousThread( CommListener );
                  RunningListener.Start;
                  initialized := true;
                  writeln('Arduino is ready!');
              end;
        end;
    end;

procedure initializePins;
var
   count : integer;
begin

  for count:= 0 to 127 do
  begin
       with pins[count] do
       begin
            mode := $00;
            digitalValue := false;
            pwmValue := $0000;
            analogValue := $0000;
       end;
  end;

end;

function ToBoolean(int : integer) : boolean;
begin
  if int <> 0 then
     ToBoolean := true
  else
     ToBoolean := false;

end;

procedure firmataReset();
begin
  bufOut[0] := SYSTEM_RESET;
  dev.SendBuffer(@bufOut, 1);
end;

procedure askFirmware;
var
  idx, idx2: integer;
  letra: uint16;
  widecharArray: array[0..MAX_DATA_BYTES] of widechar;
begin
  bufOut[0] := START_SYSEX;
  bufOut[1] := REPORT_FIRMWARE;
  bufOut[2] := END_SYSEX;
  dev.SendBuffer(@bufOut,3);
  dev.Purge;
  dev.RecvBufferEx(@bufIn,MAX_DATA_BYTES,5000);

  //Get and save firmware info acquired
  Major_version := bufIn[1];
  Minor_version := bufIn[2];

  idx:= 7;
  idx2 := 0;
  while idx < MAX_DATA_BYTES do
  begin
       letra := bufIn[idx] OR bufIn[idx + 1] shr 7;
       idx += 2;
       widecharArray[idx2] := wideChar(letra);

       if bufIn[idx] OR bufIn[idx + 1] = $F7 then
          begin
            widecharArray[idx2 + 1] := #0;
            Firmware_name := WideCharToString(widecharArray);
            write('Firmware: ');
            write(Major_version);
            write('.');
            write(Minor_version);
            write(' ');
            writeln(Firmware_name);
            break;
          end;
       idx2 += 1;
  end;

end;

procedure setPinMode( pin: byte; mode: byte);
begin
  bufOut[0] := SET_PIN_MODE;
  bufOut[1] := pin;
  bufOut[2] := mode;
  pins[pin].mode:= mode;
  dev.SendBuffer(@bufOut,3);
  end;

procedure digitalWrite( pin: byte; value: byte);
begin
  bufOut[0] := SET_DIGITAL_PIN_VALUE;
  bufOut[1] := pin;
  bufOut[2] := value;
  pins[pin].digitalValue:= boolean(value);
  dev.SendBuffer(@bufOut,3);
  end;

procedure analogWrite(pin: byte; value: byte);
begin
  bufOut[0] := ANALOG_MESSAGE OR pin;
  bufOut[1] := value AND $7F;
  bufOut[2] := value >> 7 AND $7F;
  pins[pin].pwmValue:= bufOut[1] OR bufOut[2] << 7;;
  dev.SendBuffer(@bufOut,3);
  end;

procedure digitalReport(port: byte; enabled: boolean);
begin
  bufOut[0] := REPORT_DIGITAL OR port;
  bufOut[1] := byte(enabled);
  dev.SendBuffer(@bufOut,2);
end;

procedure analogReport(pin: byte; enabled: boolean);
begin
  bufOut[0] := REPORT_ANALOG OR pin;
  bufOut[1] := byte(enabled);
  dev.SendBuffer(@bufOut,2);
end;

function digitalRead(pin: integer) : integer;
begin
   digitalRead := integer(pins[pin].digitalValue);
end;

function analogRead(pin:integer)  : integer;
begin
     analogRead := pins[pin].analogValue;
end;

procedure purgeBuffer();
var idx:integer;
begin
  idx:= 0;
  while idx < MAX_DATA_BYTES do
  begin
       bufOut[idx] := 0;
       idx +=1;
  end;
end;

procedure firmataParser();
var
    Read: uint16;
    port, pin : integer;
    mask : uint16;
  begin
    dev.CanRead(-1);
    dev.RecvBufferEx(@bufIn,MAX_DATA_BYTES, 1);
    if ( (bufIn[0] AND $F0 ) = ANALOG_MESSAGE ) then
       begin
            Read:= bufIn[1] OR bufIn[2] << 7;
            pins[(bufIn[0] AND $0F )].analogValue:= Read;
       end
    else
        if  ( (bufIn[0] AND $F0 ) = DIGITAL_MESSAGE ) then
           begin
                port := (bufIn[0] AND $0F );
                pin  := port * 8;
                mask := $0001;
                Read := bufIn[1] OR bufIn[2] << 7;
                for pin := (port * 8) to (pin + 8) do
                begin
                     pins[pin].digitalValue:= ToBoolean(read AND mask);
                     mask := mask shl 1;
                end;
           end;
    dev.Purge();
    purgeBuffer();
  end;

procedure listenTx();
var
    repetir : boolean;
    begin
      repetir := true;
      while repetir = true do
           begin
                firmataParser();
           end;
    end;

procedure SamplingInterval(interval : uint16);
begin
   bufOut[0] := START_SYSEX;
   bufOut[1] := SAMPLING_INTERVAL;
   bufOut[2] := interval ;
   bufOut[3] := interval >> 8;
   bufOut[4] := END_SYSEX;
   dev.SendBuffer(@bufOut,5);

end;

procedure finalizeComm;
begin
  if initialized = true then
    dev.Purge;
    dev.free;
end;

end.

