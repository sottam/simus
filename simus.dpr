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

program Simus;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

uses
{$IFnDEF MSWINDOWS}
  clocale,
{$ENDIF}
  Forms, Interfaces, DefaultTranslator, LCLTranslator,
  uSimus in 'uSimus.pas' {formPrincipal},
  uSimula in 'uSimula.pas',
  uHex in 'uHex.pas' {formHex},
  uAbout in 'uAbout.pas' {AboutBox},
  uAutoPrg in 'uAutoPrg.pas' {formAutoMonta},
  uvars in 'uvars.pas',
  uAssemb in 'uAssemb.pas',
  uconsole in 'uconsole.pas' {FormConsole},
  uSound in 'uSound.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TformPrincipal, formPrincipal);
  Application.CreateForm(TformHex, formHex);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TformAutoMonta, formAutoMonta);
  Application.CreateForm(TFormConsole, FormConsole);
  Application.Run;
end.
