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

unit uAutoPrg;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  Windows,
{$ELSE}
  LCLIntf, LCLType, LMessages,
{$ENDIF}
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uSimus, Clipbrd;

type
  TformAutoMonta = class(TForm)
    b_nop: TButton;
    b_sta: TButton;
    b_lda: TButton;
    b_add: TButton;
    b_or: TButton;
    b_and: TButton;
    b_not: TButton;
    b_trap: TButton;
    b_jn: TButton;
    b_jz: TButton;
    b_in: TButton;
    b_out: TButton;
    b_jnz: TButton;
    b_hlt: TButton;
    Label1: TLabel;
    l_descricao: TLabel;
    l_operando: TLabel;
    e_operando: TEdit;
    b_incluir: TButton;
    b_org: TButton;
    b_equ: TButton;
    b_end: TButton;
    b_ds: TButton;
    b_db: TButton;
    e_comentario: TEdit;
    b_coment: TButton;
    b_rotulo: TButton;
    l_instr: TLabel;
    c_indireto: TCheckBox;
    e_rotulo: TEdit;
    l_rotulo: TLabel;
    b_sts: TButton;
    b_lds: TButton;
    b_push: TButton;
    b_pop: TButton;
    b_adc: TButton;
    b_sbc: TButton;
    b_sub: TButton;
    b_xor: TButton;
    b_shr: TButton;
    b_shl: TButton;
    b_sra: TButton;
    b_jc: TButton;
    b_jnc: TButton;
    b_jmp: TButton;
    b_jsr: TButton;
    b_ret: TButton;
    b_dw: TButton;
    c_imediato: TCheckBox;
    procedure preset(oper: string);
    procedure presetComOper(oper: string);
    procedure presetDesvio(oper: string);
    procedure presetIO(oper: string);
    procedure presetPseudo(oper: string);
    procedure b_nopClick(Sender: TObject);
    procedure b_staClick(Sender: TObject);
    procedure b_incluirClick(Sender: TObject);
    procedure b_ldaClick(Sender: TObject);
    procedure b_addClick(Sender: TObject);
    procedure b_orClick(Sender: TObject);
    procedure b_andClick(Sender: TObject);
    procedure b_notClick(Sender: TObject);
    procedure b_subClick(Sender: TObject);
    procedure b_trapClick(Sender: TObject);
    procedure b_jnClick(Sender: TObject);
    procedure b_jzClick(Sender: TObject);
    procedure b_inClick(Sender: TObject);
    procedure b_outClick(Sender: TObject);
    procedure b_jnzClick(Sender: TObject);
    procedure b_hltClick(Sender: TObject);
    procedure b_orgClick(Sender: TObject);
    procedure b_equClick(Sender: TObject);
    procedure b_endClick(Sender: TObject);
    procedure b_dsClick(Sender: TObject);
    procedure b_dbClick(Sender: TObject);
    procedure b_comentClick(Sender: TObject);
    procedure b_rotuloClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure b_sbcClick(Sender: TObject);
    procedure b_xorClick(Sender: TObject);
    procedure b_shlClick(Sender: TObject);
    procedure b_shrClick(Sender: TObject);
    procedure b_sraClick(Sender: TObject);
    procedure b_jcClick(Sender: TObject);
    procedure b_jncClick(Sender: TObject);
    procedure b_stsClick(Sender: TObject);
    procedure b_ldsClick(Sender: TObject);
    procedure b_jsrClick(Sender: TObject);
    procedure b_retClick(Sender: TObject);
    procedure b_pushClick(Sender: TObject);
    procedure b_popClick(Sender: TObject);
    procedure c_indiretoClick(Sender: TObject);
    procedure c_imediatoClick(Sender: TObject);
    procedure b_adcClick(Sender: TObject);
    procedure b_jmpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formAutoMonta: TformAutoMonta;

implementation

var
  operador: string;

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

//--------------------------------------------------------------

procedure TformAutoMonta.preset(oper: string);
begin
    l_instr.caption := oper;
    operador := oper;

    l_rotulo.visible := oper <> '';
    e_rotulo.visible := oper <> '';
    c_indireto.visible := false;
    c_imediato.visible := false;
    l_operando.visible := false;
    e_operando.visible := false;
end;

procedure TformAutoMonta.presetComOper(oper: string);
begin
    preset(oper);
    c_indireto.visible := true;
    c_imediato.visible := true;
    l_operando.visible := true;
    e_operando.visible := true;
end;

procedure TformAutoMonta.presetDesvio(oper: string);
begin
    preset(oper);
    c_indireto.visible := true;
    l_operando.visible := true;
    e_operando.visible := true;
end;

procedure TformAutoMonta.presetIO(oper: string);
begin
    preset(oper);
    l_operando.visible := true;
    e_operando.visible := true;
end;

procedure TformAutoMonta.presetPseudo(oper: string);
begin
    preset(oper);
    l_rotulo.visible := (oper <> 'ORG') and (oper <> 'END');
    e_rotulo.visible := l_rotulo.visible;
    l_operando.visible := true;
    e_operando.visible := true;
end;

//--------------------------------------------------------------

procedure TformAutoMonta.FormActivate(Sender: TObject);
begin
    preset('');
end;

//--------------------------------------------------------------

procedure TformAutoMonta.c_indiretoClick(Sender: TObject);
begin
    if c_imediato.Checked then
        e_operando.text := '@'
    else
        e_operando.text := '';
end;

procedure TformAutoMonta.c_imediatoClick(Sender: TObject);
begin
    if c_imediato.Checked then
        e_operando.text := '#'
    else
        e_operando.text := '';
end;

//--------------------------------------------------------------

procedure TformAutoMonta.b_incluirClick(Sender: TObject);
var s: string;
begin
    if e_operando.Visible and (trim(e_operando.text) = '') then
        begin
            showMessage ('Por favor, preencha o operando');
            exit;
        end;

    if (operador = 'ORG') or (operador = 'EQU') or (operador = ':') then
        if trim (e_rotulo.text) = '' then
            begin
                showMessage ('Por favor, preencha o rótulo');
                exit;
            end;

    s := '';
    if operador = ';' then
        s := '; ' + e_comentario.text
    else
    if operador = ':' then
        s := e_rotulo.text + ':'
    else
        begin
            if e_rotulo.visible and (trim(e_rotulo.text) <> '') then
                begin
                    s := e_rotulo.text;
                    if operador <> 'EQU' then s := s + ':';
                end;
            s := copy (s+ '          ', 1, 10);
            s := s + copy (operador + '        ', 1, 8) + e_operando.text;
        end;

    if (operador <> ';') and (e_comentario.Text <> '') then
    begin
        while length (s) < 30 do s := s + ' ';
        s := s + '; ' + e_comentario.text;
    end;

    s := s + #$0d + #$0a;
    Clipboard.SetTextBuf(@s[1]);
    formPrincipal.editor.PasteFromClipboard;

    e_operando.text := '';
    e_comentario.text := '';
    e_rotulo.text := '';
end;

//--------------------------------------------------------------

procedure TformAutoMonta.b_nopClick(Sender: TObject);
begin
    preset ('NOP');
    l_descricao.caption :=
        'O comando NOP (no operation) é usado apenas para gastar tempo.';
end;

procedure TformAutoMonta.b_hltClick(Sender: TObject);
begin
    preset ('HLT');
    l_descricao.caption :=
        'O comando HLT (halt) para a máquina.';
end;

procedure TformAutoMonta.b_staClick(Sender: TObject);
begin
    presetComOper ('STA');
    l_descricao.caption :=
        'O comando STA (store accumulator) transfere o valor do acumulador ' +
        'para a posição de memória indicada pelo operando.';
end;

procedure TformAutoMonta.b_ldaClick(Sender: TObject);
begin
    presetComOper ('LDA');
    l_descricao.caption :=
        'O comando LDA (load accumulator) atribui ao acumulador o conteúdo da ' +
        'posição de memória indicada pelo operando.';
end;

procedure TformAutoMonta.b_addClick(Sender: TObject);
begin
    presetComOper ('ADD');
    l_descricao.caption :=
        'O comando ADD soma ao acumulador o conteúdo de uma posição de ' +
        'memória indicada pelo operando.';
end;

procedure TformAutoMonta.b_adcClick(Sender: TObject);
begin
    presetComOper ('ADC');
    l_descricao.caption :=
        'O comando ADC (add with carry) soma ao acumulador o conteúdo de uma '+
        'posição de memória indicada pelo operando, acrescido do valor do Carry (vai um).';
end;

procedure TformAutoMonta.b_subClick(Sender: TObject);
begin
    presetComOper ('SUB');
    l_descricao.caption :=
        'O comando SUB (subtract) subtrai do acumulador o conteúdo de uma ' +
        'posição de memória indicada pelo operando.';
end;

procedure TformAutoMonta.b_sbcClick(Sender: TObject);
begin
    presetComOper ('SBC');
    l_descricao.caption :=
        'O comando SBC (subtract with carry) subtrai do acumulador o conteúdo ' +
        'de uma posição de memória indicada pelo operando, decrementando-o se ' +
        'o carry ligado.';
end;

procedure TformAutoMonta.b_notClick(Sender: TObject);
begin
    preset('NOT');
    l_descricao.caption :=
        'O comando NOT (negate) transforma 1 em 0 e 0 em 1 nos bits do acumulador.';
end;

procedure TformAutoMonta.b_andClick(Sender: TObject);
begin
    presetComOper('AND');
    l_descricao.caption :=
        'O comando AND realiza um "e" lógico entre o acumulador e o conteúdo ' +
        ' de uma posição de memória indicada pelo operando.';
end;

procedure TformAutoMonta.b_orClick(Sender: TObject);
begin
    presetComOper('OR');
    l_descricao.caption :=
        'O comando OR realiza um "ou" lógico entre o acumulador e o conteúdo ' +
        ' de uma posição de memória indicada pelo operando.';
end;

procedure TformAutoMonta.b_xorClick(Sender: TObject);
begin
    presetComOper('XOR');
    l_descricao.caption :=
        'O comando XOR (exclusive OR) realiza um "xor" lógico entre o acumulador ' +
        'e o conteúdo de uma posição de memória indicada pelo operando.';
end;

procedure TformAutoMonta.b_shlClick(Sender: TObject);
begin
    preset('SHL');
    l_descricao.caption :=
        'O comando SHL (shift left) desloca os bits do acumulador para ' +
        'a esquerda (ou seja, multiplica por 2). O bit 0 recebe o valor 0. ' +
        'O bit 7 (que seria perdido) é armazenado no Carry.';
end;

procedure TformAutoMonta.b_shrClick(Sender: TObject);
begin
    preset('SHR');
    l_descricao.caption :=
        'O comando SHR (shift right) desloca os bits do acumulador para ' +
        'a direita (ou seja, divide por 2).  O bit 7 recebe o valor 0. ' +
        'O bit 0 (que seria perdido) é armazenado no Carry.';
end;

procedure TformAutoMonta.b_sraClick(Sender: TObject);
begin
    preset('SHA');
    l_descricao.caption :=
        'O comando SHA(shift right aritmético) desloca os bits do acumulador para ' +
        'a direita (ou seja, divide por 2). O bit 7 é mantido igual.  ' +
        'O bit 0 (que seria perdido) é armazenado no Carry.';
end;

procedure TformAutoMonta.b_inClick(Sender: TObject);
begin
    presetIO('IN');
    l_descricao.caption :=
        'O comando IN (input) carrega no acumulador o ' +
        'valor lido num dispositivo externo indicado pelo operando.  Nesse '+
        'simulador os dispositivos são: chaves (endereço 0) e o status ' +
        'de "dado disponível" das chaves (endereço 1).';
end;

procedure TformAutoMonta.b_outClick(Sender: TObject);
begin
    presetIO('OUT');
    l_descricao.caption :=
        'O comando OUT (output) transfere o valor do acumulador para ' +
        'um dispositivo externo indicado pelo operando.  Nesse '+
        'simulador o único dispositivo disponível é um visor '+
        '(endereço 0).';
end;

procedure TformAutoMonta.b_trapClick(Sender: TObject);
begin
    presetIO('TRAP');
    l_descricao.caption :=
        'O comando TRAP simula a execução uma função de sistema operacional, '+
        'para simplificar a programação de entrada e saída.';
end;

procedure TformAutoMonta.b_jmpClick(Sender: TObject);
begin
    presetDesvio('JMP');
    l_descricao.caption :=
        'O comando JMP (jump) desvia a execução do programa para o endereço ' +
        'indicado pelo operando (ou seja, coloca este endereço no registrador ' +
        'PC).';
end;

procedure TformAutoMonta.b_jnClick(Sender: TObject);
begin
    presetDesvio('JN');
    l_descricao.caption :=
        'O comando JN (jump if negative) desvia a execução do programa ' +
        'para o endereço indicado pelo operando, apenas quando a última ' +
        'operação realizada produziu um valor com o bit 7 ligado.';
end;

procedure TformAutoMonta.b_jzClick(Sender: TObject);
begin
    presetDesvio('JZ');
    l_descricao.caption :=
        'O comando JZ (jump if zero) desvia a execução do programa ' +
        'para o endereço indicado pelo operando, apenas quando a última ' +
        'operação realizada produziu um valor zero';
end;

procedure TformAutoMonta.b_jnzClick(Sender: TObject);
begin
    presetDesvio('JNZ');
    l_descricao.caption :=
        'O comando JNZ (jump if not zero) desvia a execução do programa ' +
        'para o endereço indicado pelo operando ender, apenas quando a ' +
        'última operação realizada produziu um valor diferente de ' +
        'zero.';
end;

procedure TformAutoMonta.b_jcClick(Sender: TObject);
begin
    presetDesvio('JC');
    l_descricao.caption :=
        'O comando JC (jump if carry) desvia a execução do programa ' +
        'para o endereço indicado pelo operando ender, apenas quando a ' +
        'última operação aritmética realizada não coube nos 8 bits do' +
        'destino.';
end;

procedure TformAutoMonta.b_jncClick(Sender: TObject);
begin
    presetDesvio('JNC');
    l_descricao.caption :=
        'O comando JNC (jump if not carry) desvia a execução do programa ' +
        'para o endereço indicado pelo operando ender, apenas quando a ' +
        'última operação aritmética realizada coube nos 8 bits do' +
        'destino.';
end;

procedure TformAutoMonta.b_orgClick(Sender: TObject);
begin
    presetPseudo ('ORG');
    l_descricao.caption :=
        'A pseudo-instrução ORG (origin) indica ao assembler ' +
        'a posição de memória onde será colocada a próxima instrução.';
    operador := 'ORG ';
    l_instr.caption := operador;
end;

procedure TformAutoMonta.b_equClick(Sender: TObject);
begin
    presetPseudo ('EQU');
    l_descricao.caption :=
        'A pseudo-instrução EQU (equate) atribui um nome a um certo valor.' +
        'Esse comando é frequentemente usado para especificar variáveis que ' +
        'são posicionadas em certo endereço de memória.'+#$0d+
        'Por exemplo para posicionar a variável x no endereço hexa f0 use:'#$0d+
        '            X EQU 0F0H';
end;

procedure TformAutoMonta.b_endClick(Sender: TObject);
begin
    presetPseudo ('END');
    l_descricao.caption :=
        'A pseudo-instrução END indica que o programa fonte acabou.  '+
        'O operando é usado para pré-carregar o PC com o endereço inicial de ' +
        'execução do programa.';
end;

procedure TformAutoMonta.b_dsClick(Sender: TObject);
begin
    presetPseudo ('DS');
    l_descricao.caption :=
        'A pseudo-instrução DS (define storage) reserva um número de ' +
        'palavras na memória definido pelo operando.';
end;

procedure TformAutoMonta.b_dbClick(Sender: TObject);
begin
    presetPseudo ('DB');
    l_descricao.caption :=
        'A pseudo-instrução DB (define bytes) carrega nesta palavra ' +
        'de memória o valor definido pelo operando.';
end;

procedure TformAutoMonta.b_comentClick(Sender: TObject);
begin
    preset (';');
    l_rotulo.visible := false;
    e_rotulo.visible := false;

    l_descricao.caption :=
        'Os comentários são começados por ponto e vírgula.';
end;

procedure TformAutoMonta.b_rotuloClick(Sender: TObject);
begin
    preset (':');
    l_descricao.caption :=
        'Um rótulo é um nome dado à posição de memória da instrução a seguir. ' +
        'O nome é seguido por dois pontos';
end;

procedure TformAutoMonta.b_stsClick(Sender: TObject);
begin
    presetDesvio('STS');
    l_descricao.caption :=
        'O comando STS (store into stack pointer) transfere 16 bits da memória ' +
        'indicada pelo operando para o apontador da pilha (Stack Pointer).';
end;

procedure TformAutoMonta.b_ldsClick(Sender: TObject);
begin
    presetComOper ('LDS');
    l_descricao.caption :=
        'O comando STS (load from stack pointer) transfere o apontador da pilha ' +
        '(Stack Pointer) para 16 bits na memória indicada pelo operando.';
end;

procedure TformAutoMonta.b_jsrClick(Sender: TObject);
begin
    presetDesvio ('JSR');
    l_descricao.caption :=
        'O comando JSR (jump to subroutine) executa uma chamada de subrotina. ' +
        'Para isso, transfere os 16 bits do PC (Program Counter) para a pilha ' +
        'e coloca no PC os 16 bits indicados no operando.  O SP é decrementado ' +
        'de 2.';
    end;

procedure TformAutoMonta.b_retClick(Sender: TObject);
begin
    preset ('RET');
    l_descricao.caption :=
        'O comando RET (return from subroutine), retorna de uma chamada JSR. ' +
        'Para isso, transfere para o PC 16 bits da pilha, e atualiza o SP. ' +
        'O SP é decrementado de 2.';
end;

procedure TformAutoMonta.b_pushClick(Sender: TObject);
begin
    preset ('PUSH');
    l_descricao.caption :=
        'O comando PUSH (push to stack), coloca o conteúdo do acumulador no ' +
        'topo da pilha.  O SP é decrementado de 1.';
end;

procedure TformAutoMonta.b_popClick(Sender: TObject);
begin
    preset ('POP');
    l_descricao.caption :=
        'O comando POP (pop from stack), traz para o acumulador o topo da pilha ' +
        '(8 bits).  O SP é decrementado de 1.';
end;

end.

