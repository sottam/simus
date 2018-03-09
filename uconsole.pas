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

unit uconsole;

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
  Dialogs, StdCtrls, Menus, LCLTranslator, DefaultTranslator;

type
  TFormConsole = class(TForm)
    MainMenu1: TMainMenu;
    Limpar1: TMenuItem;
    Esconder1: TMenuItem;
    texto: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Esconder1Click(Sender: TObject);
    procedure Limpar1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure memoWrite (s: string);
    function memoRead (maxCarac: integer): string;
    function memoChar: char;
  end;

var
  FormConsole: TFormConsole;
  bufConsole: string;

implementation

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

procedure TFormConsole.memoWrite (s: string);
begin
    texto.Caption := texto.Caption + s;
end;

function TFormConsole.memoRead (maxCarac: integer): string;
var c: char;
    bufLido: string;
    s: string;
begin
    bufLido := '';
    repeat
         repeat
              c := memoChar;
              application.processMessages;
         until c <> #$0;

         if c = #$08 then // backspace
              begin
                  if length (bufLido) <> 0 then
                      begin
                          s := texto.Caption;
                          delete (s, length(s), 1);
                          texto.Caption := s;
                          delete (bufLido, length(bufLido), 1);
                      end;
              end
         else
         if c <> #$0d then // enter
             begin
                 if length (bufLido) < maxCarac then
                     begin
                         memoWrite (c);
                         bufLido := bufLido + c;
                     end;
             end
         else
             begin
                 memoWrite (#$0d);
                 memoWrite (#$0a);
                 result := bufLido;
             end;
    until c = #$0d;
end;

function TFormConsole.memoChar: char;
begin
    if bufConsole <> '' then
        begin
            result := bufConsole[1];
            delete (bufConsole, 1, 1);
        end
    else
        result := #$0;
end;

procedure TFormConsole.FormKeyPress(Sender: TObject; var Key: Char);
begin
    bufConsole := bufConsole + Key;
end;

procedure TFormConsole.Esconder1Click(Sender: TObject);
begin
    hide;
end;

procedure TFormConsole.Limpar1Click(Sender: TObject);
begin
    texto.caption := '';
end;

end.
