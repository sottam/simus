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

unit uSound;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface
uses
{$IFDef MSWINDOWS}
  MMSystem, Windows,
{$ENDIF}
{$IFnDEF MSWINDOWS}
  Unix, BaseUnix,
{$ENDIF}
  LCLIntf, LCLType, LMessages, openal, Sysutils;

procedure SoundPlay(Hz: Word; durMS: integer);

implementation

const
     soundSize = 11025;
var
     wavHdr: array [0..43] of byte = (
        $52, $49, $46, $46, $ff, $ff, $ff, $ff, $57, $41, $56, $45, $66, $6d, $74, $20,
        $10, $00, $00, $00, $01, $00, $01, $00, $11, $2b, $00, $00, $11, $2b, $00, $00,
        $01, $00, $08, $00, $64, $61, $74, $61, $ff, $ff, $ff, $ff);

type
    TSound = array [0.. sizeof (wavHdr) + soundSize-1] of byte;

var
    PSound: ^TSound;

    buffer : TALuint;
    source : TALuint;
    sourcepos: array [0..2] of TALfloat= ( 0.0, 0.0, 0.0 );
    sourcevel: array [0..2] of TALfloat= ( 0.0, 0.0, 0.0 );
    listenerpos: array [0..2] of TALfloat= ( 0.0, 0.0, 0.0);
    listenervel: array [0..2] of TALfloat= ( 0.0, 0.0, 0.0);
    listenerori: array [0..5] of TALfloat= ( 0.0, 0.0, -1.0, 0.0, 1.0, 0.0);

    argv: array of PALByte;
    format: TALEnum;
    size: TALSizei;
    freq: TALSizei;
    loop: TALInt;
    data: TALVoid;

    openalinitialized: boolean;

procedure SoundPlay(Hz: Word; durMS: integer);
var l: longint;
    p, period: integer;
begin
{$ifdef MSWINDOWS}
    getMem (psound, sizeof (psound^)+2);  {1 second}
    if hz <> 0 then
        period := 11025 div hz
    else
        period := 11025;
    p := sizeof (wavHdr);
    l := 0;
    while p <= soundSize-period do
        begin
            fillchar (psound^[p], period div 2 + 1, $60);
            p := p + period div 2;
            fillchar (psound^[p], period-(period div 2)+1, $a0);
            p := sizeof (wavHdr) +
                 integer (longint(11025)* l div longint(hz));
            l := l + 1;
        end;
    psound^[p-1] := $80;
    l := p - sizeof (wavHdr);
    move (l, wavHdr[40], 4);
    l := l + 36;
    move (l, wavHdr[4], 4);
    move (wavHdr, psound^, sizeof (wavHdr));


    sndPlaySound (pchar (psound), snd_async + snd_memory + snd_loop);
    sleep (durMS);
    sndPlaySound (NIL, snd_sync);

    freeMem (psound, sizeof (psound^)+2);  {1 second}
{$else}
       (*if openalinitialized <> true then
           begin
             InitOpenAL;
             AlutInit(nil,argv);
             openalinitialized:= true;
           end; *)

    format:= AL_FORMAT_MONO8;
    data:= @wavHdr;
    size:= sizeof (Psound);
    freq:= Hz;

    AlGenBuffers (1, @buffer);
    AlBufferData (buffer, format, data, size, freq);

    AlGenSources (1, @source);
    AlSourcei    ( source, AL_BUFFER, buffer);
    AlSourcef    ( source, AL_PITCH, 1.0 );
    AlSourcef    ( source, AL_GAIN, 1.0 );
    AlSourcefv   ( source, AL_POSITION, @sourcepos);
    AlSourcefv   ( source, AL_VELOCITY, @sourcevel);
    AlSourcei    ( source, AL_LOOPING, AL_TRUE);

    AlListenerfv ( AL_POSITION, @listenerpos);
    AlListenerfv ( AL_VELOCITY, @listenervel);
    AlListenerfv ( AL_ORIENTATION, @listenerori);

    AlSourcePlay(source);
    sleep(durMS);
    //AlSourceStop(source);
    alSourcePause(source);
    //AlDeleteBuffers(1, @buffer);
    //AlDeleteSources(1, @source);

{$endif}


end;

end.
