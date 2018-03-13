//
//    Copyright 2016 Gabriel P. Silva and José Antonio S. Borges
//
//    This file is part of simulator SimuS.
//
//    SimuS  is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    SimuS is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with SimuS.  If not, see <http://www.gnu.org/licenses/>.
//
//    Este arquivo é parte do programa simulador SimuS.
//
//    SimuS é um software livre; você pode redistribuí-lo e/ou
//    modificá-lo dentro dos termos da Licença Pública Geral GNU como
//    publicada pela Fundação do Software Livre (FSF); na versão 3 da
//    Licença, ou (na sua opinião) qualquer versão.
//
//    Este programa é distribuído na esperança de que possa ser útil,
//    mas SEM NENHUMA GARANTIA; sem uma garantia implícita de ADEQUAÇÃO
//    a qualquer MERCADO ou APLICAÇÃO EM PARTICULAR. Veja a
//    Licença Pública Geral GNU para maiores detalhes.
//
//    Você deve ter recebido uma cópia da Licença Pública Geral GNU junto
//    com este programa, se não, veja em <http://www.gnu.org/licenses/>.
//

unit utrap;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface
uses
{$IFDef MSWINDOWS}
  windows,
{$ENDIF}
{$IFnDEF MSWINDOWS}
  Unix, BaseUnix,
  {$IFDef CPUARM}
    h2wiringpi,
  {$ENDIF}
{$ELSE}
  LCLIntf, LCLType,
{$ENDIF}
  forms, uvars, uConsole, uSound, sysutils;

procedure execTrap (var ACC: int8; operandReg: int16);
{$IFnDEF MSWINDOWS}
  {$IFDef ARMCPU}
    procedure wiringPiStarted();
  {$ENDIF}
{$ENDIF}

implementation
uses uSimula, uSimus;

var
   isWiringPiStarted: boolean = false;


{$IFnDEF MSWINDOWS}
  {$IFDef CPUARM}
procedure wiringPiStarted();
begin
  if isWiringPiStarted = false then
  begin
    wiringPiSetup();
    isWiringPiStarted := true;
  end;
end;
  {$ENDIF}
{$ENDIF}

procedure NoBlockingSleep(miliseconds : Cardinal);
var
  tc : DWORD;
begin
  tc := GetTickCount64;
  while (GetTickCount64 < tc + miliseconds) and (not Application.Terminated) do
    Application.ProcessMessages;
end;

procedure execTrap (var ACC: int8; operandReg: int16);
(* var c: byte;*)
var s: string;
    i, ncarac, tempo: integer;
    pino, valor, pud, modo: integer;
    freq, durMS: integer;
    wPiStarted: boolean;
begin
    application.processMessages;
    case ACC of
        1: begin {leitura de um caractere da console}
               ACC := ord(formConsole.memoChar);
           end;

        2: begin  {escreve caractere apontado por operandReg na console}
                  {ACC retorna a letra escrita}
               formConsole.memoWrite(chr(memoria[operandReg]));
               ACC := memoria[operandReg];
           end;

        3: begin  {leitura de linha terminada por CR da console}
                  {estrutura do buffer:  ncarac (8 bits), buffer[256]}
                  {retorna em ACC o número de letras lidas, o CR não vem}
               ncarac := pegaMemoria(operandReg, 8);
               s := formConsole.memoRead (ncarac);
               for i := 1 to length(s) do
                    memoria[(operandReg+i) and $ffff] := ord(s[i]);
               ACC := length(s);
           end;

        4: begin   {escreve linha na console, buffer termina por null}
               s := '';
               i := 0;
               while memoria[operandReg+i] <> $0 do
                   begin
                       formConsole.memoWrite(chr(pegaMemoria(operandReg+i, 8)));
                       i := i + 1;
                   end;
               ACC := i;

               // nota: ACC volta com o número de letras escritas, ou zero, se problemas
               // caracteres especiais: CR, LF, FF
           end;

        5: begin
               // temporização.  tempo em milésimos de segundos
               tempo := pegaMemoria(operandReg, 16);
               formPrincipal.TimerDeExecucao.Enabled:=false;
               NoBlockingSleep(tempo);
               formPrincipal.TimerDeExecucao.Enabled:=true;
               //sleep (tempo);
           end;

        6: begin
               // gerar tom:  frequência, duração em ms  --> bloqueante
               freq  := pegaMemoria(operandReg, 16);
               durMS := pegaMemoria(operandReg+2, 16);
               soundPlay (freq, durMS);
           end;

        7: begin
               // retorna número pseudo aleatório entre 0-99
               ACC := random (100);
           end;

        8: begin
               // semente aleatoria
               randSeed := pegaMemoria(operandReg, 8);
           end;

        //RaspPiTraps
{$IFnDEF MSWINDOWS}
  {$IFDef CPUARM}
        100: begin   //inicializa wiringPi Lib
               wiringPiStarted();
             end;

        101: begin   //Define Modo do pino
               wiringPiStarted();
               pino := pegaMemoria(operandReg, 8);
               modo := PegaMemoria(operandReg+1, 8);
               if modo = PWM_OUTPUT then
                   begin
                     s:= 'gpio mode ' + IntToStr(pino) + ' pwm';
                     fpsystem(s);
                   end
               else
                   begin
                     h2wiringpi.pinMode(pino,modo);
                   end;
             {INPUT = 0
              OUTPUT = 1
              PWM = 2}
             end;
        102: begin //define um valor no pino digital
               wiringPiStarted();
               pino := pegaMemoria(operandReg, 8);
               valor := pegaMemoria(operandReg+1, 8) and 1;
               h2wiringpi.digitalWrite(pino,valor);
             end;
        103: begin  //le um valor de um pino digital
               wiringPiStarted();
               pino := pegaMemoria(operandReg, 8);
               ACC := h2wiringpi.digitalRead(pino);
             end;

        104: begin    //Configura o modo da resistencia Pull-up
               wiringPiStarted();
               pino := pegaMemoria(operandReg, 8);
               pud := pegaMemoria(operandReg+1, 8);
               case pud of
                  0:begin
                      h2wiringpi.pullUpDnControl(pino, PUD_OFF);
                    end;
                  1:begin
                      h2wiringpi.pullUpDnControl(pino, PUD_DOWN);
                    end;
                  2:begin
                      h2wiringpi.pullUpDnControl(pino, PUD_UP);
                    end;
               end;
             end;

        105: begin  //configura o duty-cicle de um registrador PWM
               wiringPiStarted();
               pino := pegaMemoria(operandReg, 8);
               valor := pegaMemoria(operandReg+1, 16) and $3FF;
               //pwmWrite(pino,valor);
               s:= 'gpio pwm ' + IntToStr(pino) + ' ' + IntToStr(valor);
               fpsystem(s);
             end;
  {$ENDIF}
{$ENDIF}
    end;
    application.processMessages;
end;

end.
