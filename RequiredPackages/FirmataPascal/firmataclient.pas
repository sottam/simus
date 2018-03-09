unit FirmataClient;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazSerial, FirmataConstants, ExtCtrls, LazSynaSer, StdCtrls;

type
  TPin = record
    mode            : byte;
    analog_channel  : byte;
    supported_modes : UInt64;
    value           : integer;
  end;

type
  TCallback = procedure(message : array of byte);

const
  i2c_Mode_Write = $00;
  i2c_Mode_ReadOnce = $8;
  i2c_Mode_ReadContinuously = $10;
  i2c_Mode_StopReading = $18;

  i2c_AutoRestart_Stop = $00;
  i2c_AutoRestart_Restart = $40;

  i2c_Address_Mode_SevenBit = $00;
  i2c_Address_Mode_TenBit = $20;

type
  TFirmata = class
  private
   //vars
   LazSerial         : TLazSerial;
   Timer             : TTimer;

   ready             : boolean;
   AnalogPins        : array[0..15] of byte; //it will receive the number of the pins that have analog channel

   buf               : array[0..64] of byte;
   pin_info          : array[0..127] of TPin;
   rx_count          : integer;
   tx_count          : integer;

   parse_count       : integer;
   parse_command_len : integer;
   parse_buf         : array[0..4096] of byte;

   PFirmwareName     : string;

   LastStringMessage : string;

   ReportOnStartUp   : boolean;

   //serial
   serialCallBack     : array[0..15] of TCallback;

   //methods

   //Genuine Firmata
   procedure QueryPinState(pin : byte);
   procedure askBoardCapabilities();
   procedure askFirmware();

   //Support methods
   procedure initPinInfo();
   procedure initLazSerial(port : string; BaudRate : TBaudRate);
   procedure initTimer();
   procedure TimedRead(Sender: TObject);

   procedure firmataParser(buffer : array of byte; len : integer);
   procedure DecodeMessage();

   function ReturnAnalogPinNumber(pin :byte) : byte;

  public
   //vars
   LastUnknownMessage : string;
   //class methods

   //If a diferent baudRate is needed, add LazSynaser to uses section to use the second parameter
   //If you want to ask firmata report all pins on startup, set ReportOnStart to true
   constructor Create(port: string; BaudRate : TBaudRate = br_57600 ;ReportOnStart : boolean = false);

   destructor Destroy; override;
   //genuine Firmata
   procedure setPinMode( pin: byte; mode: byte);
   procedure digitalWrite( pin: byte; value: byte);
   procedure analogWrite(pin: byte; value: byte);
   procedure digitalReport(port: byte; enab: boolean);
   procedure analogReport(pin: byte; enab: boolean);
   procedure SystemReset();
   //i2c
   procedure i2cRequest(address : byte;   restart : byte; mode : byte; data : array of byte; len : integer); overload;
   procedure i2cRequest(address : uint16; restart : byte; mode : byte; data : array of byte; len : integer); overload;
   //implementar reply no parser.
   procedure i2cConfig (delay : uint16 ; data : array of byte; len : integer);overload;
   procedure i2cConfig (data : array of byte; len : integer);
   //serial
   procedure serialHWConfig(portID : byte; baudRate : uint32); overload;
   procedure serialSWConfig(portID : byte; baudRate : integer; rx_pin : byte; tx_pin : byte);
   procedure serialWrite(portID : byte; msg : array of byte; length: integer);
   procedure serialRead(portID : byte; maxBytesToRead : integer; callback: TCallback);
   procedure serialStop(portID : byte);
   procedure serialClose(portID : byte);
   procedure serialFlush(portID : byte);
   procedure serialListen(portID : byte);

   //support methods
   function  digitalRead(pin:integer) : integer;
   function  analogRead(pin:integer)  : integer;
   class function  availableSerialPorts()   : TStringList; static;
   //DEBUG
   procedure printPinInfo(Memo : TMemo);

  published
   property FirmwareName : string read PFirmwareName write PFirmwareName;

  end;


implementation
//class methods
constructor TFirmata.Create(port : string; BaudRate : TBaudRate = br_57600 ; ReportOnStart : boolean = false);
begin
  initPinInfo();
  initLazSerial(port, BaudRate);
  initTimer();

  ReportOnStartUp:=ReportOnStart;

  LazSerial.Active:= True;
  LazSerial.Open;


  askFirmware();
  //hangs while firmata is starting only after
  //receiving firmware, pin cap and analog mapping
  //we are ready to go.
  while ready = false do
  begin
    TimedRead(nil);
    sleep(40);
  end;

  Timer.Enabled:= true;

end;

destructor TFirmata.Destroy();
begin
  Timer.Enabled:=false;
  LazSerial.Close;
  Timer.Destroy;
  LazSerial.Destroy;
end;

//Genuine TFirmata
procedure TFirmata.setPinMode( pin: byte; mode: byte);
begin

  buf[0] := SET_PIN_MODE;
  buf[1] := ReturnAnalogPinNumber(pin);
  buf[2] := mode;
  LazSerial.WriteBuffer(buf,3);
  pin_info[pin].mode:= mode;
  pin_info[pin].value:= 0;
  tx_count+=3;
  end;

procedure TFirmata.digitalWrite( pin: byte; value: byte);
begin
  buf[0] := SET_DIGITAL_PIN_VALUE;
  buf[1] := ReturnAnalogPinNumber(pin);
  buf[2] := value;
  pin_info[pin].value:= value;
  LazSerial.WriteBuffer(buf,3);
  tx_count+=3;
  end;

procedure TFirmata.analogWrite(pin: byte; value: byte);
begin
  buf[0] := ANALOG_MESSAGE OR pin;
  buf[1] := value AND $7F;
  buf[2] := value >> 7 AND $7F;
  pin_info[pin].value:= value;
  LazSerial.WriteBuffer(buf,3);
  tx_count+=3;
  end;

procedure TFirmata.digitalReport(port: byte; enab: boolean);
begin
  buf[0] := REPORT_DIGITAL OR port;
  buf[1] := byte(enab);
  LazSerial.WriteBuffer(buf,2);
  tx_count+=2;
end;

procedure TFirmata.analogReport(pin: byte; enab: boolean);
begin
  buf[0] := REPORT_ANALOG OR pin;
  buf[1] := byte(enab);
  LazSerial.WriteBuffer(buf,2);
  tx_count+=2;
end;

procedure TFirmata.SystemReset();
begin
  initPinInfo();

  buf[0] := SYSTEM_RESET;
  LazSerial.WriteBuffer(buf,1);
  tx_count+=1;
end;

procedure TFirmata.QueryPinState(pin : byte);
var
  len : integer;
begin
  len:=0;
  if(pin_info[pin].supported_modes > 0) then
  begin
    buf[0] := START_SYSEX;
    buf[1] := PIN_STATE_QUERY;
    buf[2] := pin;
    buf[3] := END_SYSEX;
    len := 4;
    LazSerial.WriteBuffer(buf, len);
    tx_count+= len;
  end;
end;

procedure TFirmata.askBoardCapabilities();
var
   len : integer;
   idx : integer;
begin
  buf[0] := START_SYSEX;
  buf[1] := ANALOG_MAPPING_QUERY;
  buf[2] := END_SYSEX;
  buf[3] := START_SYSEX;
  buf[4] := CAPABILITY_QUERY;
  buf[5] := END_SYSEX;
  len:= 6;
  //for automatic transmission on initialization
  if ReportOnStartUp = true then
  begin
    for idx:= 0 to 15 do
    begin
      len+=1;
      buf[len] := $C0 or idx;  // report analog
      len+=1;
      buf[len] := 1;
      len+=1;
      buf[len] := $D0 or idx;  // report digital
      len+=1;
      buf[len] := 1;
    end;
  end;

  LazSerial.WriteBuffer(buf,len);
  tx_count += len;
end;

procedure TFirmata.askFirmware();
begin
  buf[0] := START_SYSEX;
  buf[1] := REPORT_FIRMWARE;
  buf[2] := END_SYSEX;
  LazSerial.WriteBuffer(buf,3);
  tx_count+= 3;
end;

//Support Methods

procedure TFirmata.initPinInfo();
var
   count : integer;
begin
  for count:=0 to 127 do
  begin
    with pin_info[count] do
    begin
      mode:= 255;
      analog_channel := 127;
      supported_modes := 0;
      value:=0
    end;
  end;

  for count:= 0 to 15 do
    AnalogPins[count]:= $FF;
end;

procedure TFirmata.initLazSerial(port: string; BaudRate : TBaudRate);
begin
  LazSerial:= TLazSerial.Create(nil);

  LazSerial.BaudRate:= BaudRate;
  LazSerial.DataBits:=db8bits;
  LazSerial.Parity:=pNone;
  LazSerial.StopBits:=sbOne;
  LazSerial.FlowControl:=fcNone;
  LazSerial.Device:= port;
end;

procedure TFirmata.initTimer();
begin
  Timer:= TTimer.Create(nil);

  Timer.Interval:=20;
  Timer.Name:='FirmataTimer';
  Timer.OnTimer:= @TimedRead;
end;

procedure TFirmata.TimedRead(Sender: TObject);
var
   idx         : integer;
   Fmsg        : AnsiString;
   byteMessage : array of byte;
begin
    Fmsg := '';
    Fmsg := LazSerial.ReadData;

    if(Fmsg.IsNullOrEmpty(Fmsg)) then
    begin
         exit;
    end;
    rx_count+= (Fmsg.Length) ;
    SetLength(byteMessage,Fmsg.Length);
    //converts array of char to array of byte
    for idx:= 1 to (Fmsg.Length) do
    begin
      byteMessage[idx-1] := byte(Fmsg[idx]);
    end;
    //Call the parser
    firmataParser(byteMessage, Fmsg.Length)
end;

procedure TFirmata.firmataParser(buffer : array of byte; len : integer);
var
   idx: integer;
   msn: byte;
begin
    for idx := 0 to len do
    begin
      msn := buffer[idx] and $F0;
      if ((msn = ANALOG_MESSAGE) or (msn = DIGITAL_MESSAGE) or (msn = REPORT_VERSION)) then
      begin
        parse_command_len := 3;
	parse_count := 0;
      end{
      else if ((msn = REPORT_ANALOG) or (msn = REPORT_DIGITAL) ) then
      begin
        parse_command_len := 2;
	parse_count := 0;
      end }
      else if (buffer[idx] = START_SYSEX) then
      begin
        parse_count := 0;
	parse_command_len := sizeof(parse_buf);
      end
      else if(buffer[idx] = END_SYSEX) then
      begin
        parse_command_len := parse_count + 1;
      end
      else if (buffer[idx] and $80 > 0) then
      begin
        parse_command_len := 1;
	parse_count := 0;
      end;

      if(parse_count < SizeOf(parse_buf) ) then
      begin
        parse_buf[parse_count] := buffer[idx];
        parse_count+= 1;
      end;

      if(parse_count = parse_command_len) then
      begin
        DecodeMessage();
        parse_count:=0;
        parse_command_len:=0;
      end;
    end;

end;

procedure TFirmata.DecodeMessage();
var
   cmd        : byte;
   analog_ch  : integer;
   analog_val : integer;
   port_num   : integer;
   port_val   : integer;
   pin        : integer; //contador
   val        : integer;
   mask       : byte;
   firmName   : array of char;
   strMsg     : array of char;
   len        : integer;
   idx        : integer; //contador
   jdx        : integer; //contador
   n          : integer;
   //i2c
   slave_addr : byte;
   i2c_message: string;
   //serial
   portID     : byte;
   serialMsg  : array of byte;
begin

  cmd:= (parse_buf[0] and $F0);

  if( (cmd = ANALOG_MESSAGE) and (parse_count = 3) ) then
  begin
    analog_ch := parse_buf[0] and $0F;
    analog_val:= parse_buf[1] or (parse_buf[2] << 7);

    for pin:=0 to 127 do
    begin
      if(pin_info[pin].analog_channel = analog_ch) then
      begin
        pin_info[pin].value := analog_val;
        exit;
      end;

    end;
    exit;
  end;

  if( (cmd = DIGITAL_MESSAGE) and (parse_count = 3) ) then
  begin
    port_num:= (parse_buf[0] and $0F);
    port_val:= parse_buf[1] or (parse_buf[2] << 7);
    mask    := $01;

    for pin := (port_num * 8) to ((port_num * 8) + 7) do
    begin
      if( (pin_info[pin].mode = PIN_MODE_INPUT) or (pin_info[pin].mode = PIN_MODE_PULLUP) ) then
      val := (port_val and mask);
      if val > 0 then val:= 1;

      if (pin_info[pin].value <> val) then
      begin
        pin_info[pin].value := val;
      end;

      mask := mask << 1;
    end;

    exit;

  end;
  //sysex message
  if ( (Parse_buf[0] = START_SYSEX) and (parse_buf[parse_count - 1] = END_SYSEX) ) then
  begin
    case parse_buf[1] of
      REPORT_FIRMWARE:
        begin
          len:= 0;
          idx:= 4;
          SetLength(firmName, 160);
          while idx < (parse_count - 2) do
          begin
            firmName[len] := char( ( (parse_buf[idx] and $7F) or ( (parse_buf[idx + 1] and $7F) << 7 ) ) );
            len+=1;
            idx+=2;
          end;

          firmName[len]:= '-';
          len+=1;
          firmName[len]:= char(parse_buf[2] + $30); // $30 is ASCII CODE FOR ZERO NUMBER
          len+=1;
          firmName[len]:= '.';
          len+=1;
          firmName[len]:= char(parse_buf[3]+ $30);
          len+=1;
          firmName[len]:= char(0);

          SetString(PFirmwareName,PChar(@firmName[0]), Length(firmName));

          // query the board's capabilities only after hearing the
          // REPORT_FIRMWARE message.  For boards that reset when
          // the port open (eg, Arduino with reset=DTR), they are
          // not ready to communicate for some time, so the only
          // way to reliably query their capabilities is to wait
          // until the REPORT_FIRMWARE message is heard.
          askBoardCapabilities();
        end;
      CAPABILITY_RESPONSE:
        begin
          for pin:= 0 to 127 do
          begin
            pin_info[pin].supported_modes:= 0;
          end;

          idx:= 2;
          n := 0;
          pin := 0;

          while idx < parse_count do
          begin
            if(parse_buf[idx] = 127) then
            begin
              pin+=1;
              n := 0;
            end;
            if (n = 0) then
            begin
              pin_info[pin].supported_modes:= pin_info[pin].supported_modes or (1 << parse_buf[idx]);
            end;
            n:= n xor 1;
            idx+=1;
          end;
          //At this point we have firmware, pin cap, analog map.
          //After receiving and parsing them, we can say Firmata is Ready.
          ready := true;

          // send a state query for every pin with any modes
          {
          for pin:=0 to 127 do
             QueryPinState(pin);  }

        end;
      ANALOG_MAPPING_RESPONSE:
        begin
          pin:= 0;
          jdx:=0;
          for idx := 2 to (parse_count - 2) do
          begin
            pin_info[pin].analog_channel:= parse_buf[idx];
            if(parse_buf[idx] <> 127) then
            begin
              AnalogPins[jdx] := pin; //save the real number of the analog pins in the array
              jdx+=1;
            end;
            pin+=1;
          end;
        end;
      PIN_STATE_RESPONSE:
        begin
          if parse_count < 6 then exit;
          pin := parse_buf[2];
          pin_info[pin].mode := parse_buf[3];
          pin_info[pin].value := parse_buf[4];
          if(parse_count > 6) then
          begin
            pin_info[pin].value:= (pin_info[pin].value) or (parse_buf[5] << 7);
          end;
          if(parse_count > 7) then
          begin
            pin_info[pin].value:= (pin_info[pin].value) or (parse_buf[6] << 14);
          end;
        end;
      I2C_REPLY:
        begin
          slave_addr:= parse_buf[2] + (parse_buf[3] << 7);
          i2c_message[1] := char(parse_buf[4] + (parse_buf[5] << 7));

          if(parse_buf[parse_count - 1] <> END_SYSEX) then
          begin
            for idx:= 6 to (parse_count - 1) do
            begin
              i2c_message[idx - 4]:= char(parse_buf[idx]);
            end;
          end;
          { TODO : IMPLEMENTAR ARMAZENAGEM DE I2C MESSAGES }
        end;
      SERIAL_MESSAGE:
        begin
          if parse_buf[2] = SERIAL_REPLY then
          begin
            portID:=parse_buf[2] and $0F;
            SetLength(serialMsg,((parse_count-5) div 2));
            idx:=3;
            jdx:=0;

            while idx < (parse_count-2) do
            begin
              serialMsg[jdx]:= parse_buf[idx] or (parse_buf[idx + 1] << 7);
              jdx+=1;
              idx+=2;
            end;
            //call registed callback function
            serialCallBack[portID](serialMsg);
          end;
        end;
      STRING_DATA:
        begin
            len:= 0;
            idx:= 2;
            SetLength(strMsg, (parse_count - 3) div 2);
            while idx < (parse_count - 1) do
            begin
              strMsg[len] := char( ( (parse_buf[idx] and $7F) or ( (parse_buf[idx + 1] and $7F) << 7 ) ) );
              len+=1;
              idx+=2;
            end;

            SetString(LastStringMessage,PChar(@strMsg[0]), Length(strMsg));
        end

    else
      begin
        LastUnknownMessage:= LastUnknownMessage.Empty;
        for idx:=1 to (parse_count - 2) do
        begin
          LastUnknownMessage+= char(parse_buf[idx]);
        end;
      end;
    end;
  end
end;

function TFirmata.ReturnAnalogPinNumber(pin :byte) : byte;
begin
  if pin >= $A0 then
  begin
    ReturnAnalogPinNumber:= AnalogPins[(pin and $0F)];
  end
  else
    ReturnAnalogPinNumber := pin;
end;

function  TFirmata.digitalRead(pin: integer) : integer;
begin
   digitalRead := pin_info[pin].value;
end;

function  TFirmata.analogRead(pin:integer)  : integer;
begin
   pin:=ReturnAnalogPinNumber(pin);
   analogRead := pin_info[pin].value;
end;
//i2c
procedure TFirmata.i2cRequest(address : byte;   restart : byte; mode : byte; data : array of byte; len : integer); overload;
var idx,buf_count : integer;
begin
  buf[0] := START_SYSEX;
  buf[1] := I2C_REQUEST;
  buf[2] := (address and $7F);
  buf[3] := $00 and restart and i2c_Address_Mode_SevenBit and mode;
  buf_count:= 4;
  for idx:= 0 to (len - 1) do
  begin
    buf[buf_count]:= (data[idx] and $7F);
    buf_count+=1;
    buf[buf_count]:= ((data[idx] >> 7) and $7F);
    buf_count+=1;
  end;
  buf[buf_count]:= END_SYSEX;
  tx_count+= (buf_count);
  LazSerial.WriteBuffer(buf, buf_count);
end;

procedure TFirmata.i2cRequest(address : uint16; restart : byte; mode : byte; data : array of byte; len : integer); overload;
var idx,buf_count : integer;
begin
  buf[0] := START_SYSEX;
  buf[1] := I2C_REQUEST;
  buf[2] := (address and $7F);
  buf[3] := $00 and restart and i2c_Address_Mode_SevenBit and mode and ((address >> 7) and $07);
  buf_count:= 4;
  for idx:= 0 to (len - 1) do
  begin
    buf[buf_count]:= (data[idx] and $7F);
    buf_count+=1;
    buf[buf_count]:= ((data[idx] >> 7) and $7F);
    buf_count+=1;
  end;
  buf[buf_count]:= END_SYSEX;
  tx_count+= (buf_count);
  LazSerial.WriteBuffer(buf, buf_count);
end;

procedure TFirmata.i2cConfig (delay : uint16 ; data : array of byte; len : integer);
var idx,buf_count : integer;
begin
  buf[0]:=START_SYSEX;
  buf[1]:=I2C_CONFIG;
  buf[2]:=(delay and $007F);
  buf[3]:=(delay >> 7) and $007F;
  buf_count:= 4;
  for idx:= 0 to (len - 1) do
  begin
    buf[buf_count]:= (data[idx] and $7F);
    buf_count+=1;
    buf[buf_count]:= ((data[idx] >> 7) and $7F);
    buf_count+=1;
  end;
  buf[buf_count]:= END_SYSEX;
  tx_count+= (buf_count);
  LazSerial.WriteBuffer(buf, buf_count);
end;

procedure TFirmata.i2cConfig (data : array of byte; len : integer);
var idx,buf_count : integer;
begin
  buf[0]:=START_SYSEX;
  buf[1]:=I2C_CONFIG;
  buf_count:= 2;
  for idx:= 0 to (len - 1) do
  begin
    buf[buf_count]:= (data[idx] and $7F);
    buf_count+=1;
    buf[buf_count]:= ((data[idx] >> 7) and $7F);
    buf_count+=1;
  end;
  buf[buf_count]:= END_SYSEX;
  tx_count+= (buf_count);
  LazSerial.WriteBuffer(buf, buf_count);
end;
//serial
procedure TFirmata.serialHWConfig(portID : byte; baudRate : uint32);
begin
  if portID > 4 then exit; //only 4 HW serialport are supported
  buf[0]:= START_SYSEX;
  buf[1]:= SERIAL_MESSAGE;
  buf[2]:= SERIAL_CONFIG or portID;
  buf[3]:= baudRate and $007F;
  buf[4]:= (baudRate >> 7) and $007F;
  buf[5]:= (baudRate >> 14) and $007F;
  buf[6]:= END_SYSEX;
  LazSerial.WriteBuffer(buf, 7);
  tx_count+= 7;
end;

procedure TFirmata.serialSWConfig(portID : byte; baudRate : integer; rx_pin : byte; tx_pin : byte);
begin
  if portID < 8 then exit;
  buf[0]:= START_SYSEX;
  buf[1]:= SERIAL_MESSAGE;
  buf[2]:= SERIAL_CONFIG or portID;
  buf[3]:= baudRate and $007F;
  buf[4]:= (baudRate >> 7) and $007F;
  buf[5]:= (baudRate >> 14) and $007F;
  buf[6]:= rx_pin and $7F;
  buf[7]:= tx_pin and $7F;
  buf[8]:= END_SYSEX;
  LazSerial.WriteBuffer(buf, 9);
  tx_count+= 9;
end;

procedure TFirmata.serialWrite(portID : byte; msg : array of byte; length: integer);
var
  idx, jdx : integer;
begin
  buf[0]:= START_SYSEX;
  buf[1]:= SERIAL_MESSAGE;
  buf[2]:= SERIAL_WRITE or portID;
  idx:=3;
  jdx:=0;
  //IF MESSAGE IS LARGER THAN MAX BUFFER, IT WILL BE TRUNCATED
  while ( (jdx < length) or (idx >= (MAX_DATA_BYTES - 5)) ) do
  begin
    buf[idx]:= (msg[jdx]) and $7F;
    idx+=1;
    buf[idx]:= (msg[jdx] >> 7) and $7F;
    idx+=1;
    jdx+=1;
  end;
  buf[idx]:= END_SYSEX;
  LazSerial.WriteBuffer(buf, idx);
  tx_count+= idx;
end;

procedure TFirmata.serialRead(portID : byte; maxBytesToRead : integer; callback: TCallback);
begin
  buf[0]:= START_SYSEX;
  buf[1]:= SERIAL_MESSAGE;
  buf[2]:= SERIAL_READ or portID;
  buf[3]:= SERIAL_READ_MODE_CONT;

  if maxBytesToRead = 0 then
  begin
    buf[4]:= END_SYSEX;
    LazSerial.WriteBuffer(buf, 5);
    tx_count+= 5;
  end
  else
  begin
    buf[4]:= maxBytesToRead and $007F;
    buf[5]:= (maxBytesToRead) >> 7 and $007F;
    buf[6]:= END_SYSEX;
    LazSerial.WriteBuffer(buf, 7);
    tx_count+=7;
  end;
  serialCallBack[portID]:= callback;

end;

procedure TFirmata.serialStop(portID : byte);
begin
  buf[0]:= START_SYSEX;
  buf[1]:= SERIAL_MESSAGE;
  buf[2]:= SERIAL_READ or portID;
  buf[3]:= SERIAL_READ_MODE_STOP;
  buf[4]:= END_SYSEX;
  LazSerial.WriteBuffer(buf, 5);
  tx_count+=5;
end;

procedure TFirmata.serialClose(portID : byte);
begin
  buf[0]:= START_SYSEX;
  buf[1]:= SERIAL_MESSAGE;
  buf[2]:= SERIAL_CLOSE or portID;
  buf[3]:= END_SYSEX;
  LazSerial.WriteBuffer(buf, 4);
  tx_count+=4;
end;

procedure TFirmata.serialFlush(portID : byte);
begin
  buf[0]:= START_SYSEX;
  buf[1]:= SERIAL_MESSAGE;
  buf[2]:= SERIAL_FLUSH or portID;
  buf[3]:= END_SYSEX;
  LazSerial.WriteBuffer(buf, 4);
  tx_count+=4;
end;

procedure TFirmata.serialListen(portID : byte);
begin
    if portID < 8 then exit; // listen only applies to software serial ports
    buf[0]:= START_SYSEX;
    buf[1]:= SERIAL_MESSAGE;
    buf[2]:= SERIAL_LISTEN or portID;
    buf[3]:= END_SYSEX;
    LazSerial.WriteBuffer(buf, 4);
    tx_count+=4;
end;

class function TFirmata.availableSerialPorts()   : TStringList; static;
var
  OutPutList: TStringList;
const
  Delimiter : Char = ',';
begin
  OutPutList := TStringList.Create;
  try
     OutPutList.Clear;
     OutPutList.Delimiter       := Delimiter;
     OutPutList.StrictDelimiter := True; // Requires D2006 or newer.
     OutPutList.DelimitedText   := GetSerialPortNames();
 finally
     availableSerialPorts:= OutPutList;
  end;

end;

procedure TFirmata.printPinInfo(Memo : TMemo);
var
  pin : TPin;
  idx : integer;
begin
 idx:=0;
  for pin in pin_info do
    begin
       memo.Append(idx.ToString + ':' + pin.analog_channel.ToString);
       idx+=1;
    end;
end;

end.

