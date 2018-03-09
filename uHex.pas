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

unit uHex;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  Windows,
{$ELSE}
  LCLIntf, LCLType,
{$ENDIF}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, LCLTranslator, DefaultTranslator, ResString;

type
  TformHex = class(TForm)
    Edit1: TEdit;
    l_resposta: TLabel;
    Button1: TButton;
    GroupBox1: TGroupBox;
    de_binario: TRadioButton;
    de_decimal: TRadioButton;
    de_hexa: TRadioButton;
    GroupBox2: TGroupBox;
    para_binario: TRadioButton;
    para_decimal: TRadioButton;
    para_hexa: TRadioButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formHex: TformHex;

function hexToInt (s: string): integer;

implementation

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

function hexToInt (s: string): integer;
var i, b: integer;
    valor: integer;
begin
    trim(s);
    valor := 0;
    for i := 1 to length (s) do
        begin
            b := ord(upcase(s[i]));
            if b >= ord('A') then b := b - 7;
            b := b and $f;
            valor := (valor shl 4) or b;
        end;
    hexToInt := valor;
end;

procedure TformHex.Button1Click(Sender: TObject);
var s: string;
    i, valor: integer;
const
    tabbin: set of char = ['0', '1'];
    tabdec: set of char = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    tabhex: set of char = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
                           'A', 'B', 'C', 'D', 'E', 'F'];
label erro;
begin
    s := edit1.text;
    trim (s);

    if de_binario.checked then
        begin
            valor := 0;
            for i := 1 to length (s) do
               begin
                   if not (s[i] in tabbin) then goto erro;
                   valor := (valor shl 1) or (ord(s[i]) and 1);
               end;
        end
    else
    if de_decimal.checked then
        begin
            for i := 1 to length (s) do
               if not (s[i] in tabdec) then goto erro;
            valor := strToInt(s)
        end
    else
        begin
            for i := 1 to length (s) do
               if not (upcase(s[i]) in tabhex) then goto erro;
            valor := hexToInt (s);
        end;

    if para_binario.Checked then
        begin
            s := '';
            for i := 1 to 16 do
                begin
                    s := chr (valor and 1 + ord('0')) + s;
                    valor := valor shr 1;
                end;
        end
    else
    if para_decimal.Checked then
        s := intToStr (valor)
    else
        s := intToHex (valor, 4);

    l_resposta.caption := s;
    exit;

erro:
    showMessage (SValorDigitadoInconsistente);
end;

end.
