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

unit uSimula;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface
uses uvars, utrap, dialogs;

function pegaMemoria (ender, nbits: integer): integer;
function modoEnderValido (ind_ti, modoEnder: integer): boolean;

procedure zeraMemoria;
procedure inicMaquina (zerando: boolean);
procedure executaInstrucao;

implementation

procedure zeraMemoria;
var i: integer;
begin
    for i := 0 to WORD_MASK do
        memoria[i] := 0;
end;


procedure inicMaquina (zerando: boolean);
begin
    if zerando then zeraMemoria;
    PC := 0;
    SP := 0;
    ACC := 0;
    ALU_N := false;
    ALU_Z := false;
    ALU_C := false;

    displayReg := 0;
    keyReg:= 0;
    keyStatusReg:= 0;
    bannerReg := '   SAPIENS-8';
end;

{----------------------------------------------------}

procedure atualizaNZ;
begin
    ALU_N := (ACC and $80) <> 0;
    ALU_Z := ACC = 0;
end;

function extraiACC_NZC (ACC_carry: integer): int8;
begin
    ALU_N := (ACC_carry and $80) <> 0;
    ALU_Z := (ACC_carry and $FF) = 0;
    ALU_C := (ACC_carry and CARRY_MASK) <> 0;
    result := ACC_carry and BYTE_MASK;
end;

{----------------------------------------------------}

function pegaMemoria (ender, nbits: integer): integer;
var e, v1, v2: integer;
begin
    e := ender and WORD_MASK;
    v1 := memoria[e] and $ff;
    if nbits = 8 then
        v2 := 0
    else
        begin
            e := (ender+1) and WORD_MASK;
            v2 := memoria[e] and $ff;
        end;
    result := (v2 shl 8) or v1;
end;

{----------------------------------------------------}

function modoEnderValido (ind_ti, modoEnder: integer): boolean;
var p: integer;
begin
    p := tabInstrucoes[ind_ti].params;
    modoEnderValido := false;

    if p = NADA then
         modoEnderValido := true
    else
        if (p = VALOR) and (modoEnder <> DIRETO) then
            modoEnderValido := false
        else
            case modoEnder of
                0: modoEnderValido := (p and DIRETO) <> 0;
                1: modoEnderValido := (p and INDIRETO) <> 0;
                2: modoEnderValido := (p and IMEDIATO) <> 0;
                3: modoEnderValido := (p and IMEDIATO_16) <> 0;
            end;
end;

{----------------------------------------------------}

procedure executaInstrucao;
var ind_ti: integer;
begin
    instReg   := memoria[PC] shr 2;          { busca instrucao e decodifica }
    modoEnder := 1 shl (memoria[PC] and 3);  { gera 1, 2, 4, 8... }
    PC := (PC + 1) and WORD_MASK;            { incrementa PC }

    ind_ti := indTabInstrPorCod[instReg];

    operandReg := 0;
    if tabInstrucoes[ind_ti].params <> NADA then
        case modoEnder of
            DIRETO:
              begin
                   operandReg := pegaMemoria (PC, 16);
                   PC := (PC + 2) and WORD_MASK;
              end;
            INDIRETO:
              begin
                   operandReg := pegaMemoria (pegaMemoria (PC, 16), 16);
                   PC := (PC + 2) and WORD_MASK;
              end;
            IMEDIATO:
                begin
                     operandReg := pegaMemoria (PC, 8);
                     PC := (PC + 1) and WORD_MASK;
                end;
            IMEDIATO_16:
                 begin
                     operandReg := pegaMemoria (PC, 16);
                     PC := (PC + 2) and WORD_MASK;
                 end;
        end;

    ////// AGREGAR TESTE DE VALIDADE DE MODOS DE ENDEREÇAMENTO e INSTRUÇÃO INVÁLIDA

    case instReg of
        _NOP :  ;

        _LDA :  begin
                    if (modoEnder=DIRETO) or (modoEnder=INDIRETO) then
                        operandReg := pegaMemoria (operandReg, 8);
                    ACC := operandReg;
                    atualizaNZ;
                end;
        _STA :  memoria [operandReg] := ACC;

        _LDS :  begin
                    if (modoEnder=DIRETO) or (modoEnder=INDIRETO) then
                        operandReg := pegaMemoria (operandReg, 16);
                    SP := operandReg;
                end;
        _STS :  begin
                    memoria [operandReg]   := SP and BYTE_MASK;
                    memoria [operandReg+1] := (SP shr 8) and BYTE_MASK;
                end;

        _ADD :  begin
                    if (modoEnder=DIRETO) or (modoEnder=INDIRETO) then
                        operandReg := pegaMemoria (operandReg, 8);
                    ACC_carry := ACC + operandReg;
                    ACC := extraiACC_NZC (ACC_carry);
                end;
        _ADC : begin
                    if (modoEnder=DIRETO) or (modoEnder=INDIRETO) then
                        operandReg := pegaMemoria (operandReg, 8);
                    ACC_carry := ACC + operandReg + ord(ALU_C);
                    ACC := extraiACC_NZC (ACC_carry);
               end;
        _SUB :  begin
                    if (modoEnder=DIRETO) or (modoEnder=INDIRETO) then
                        operandReg := pegaMemoria (operandReg, 8);
                    ACC_carry := ACC - operandReg;
                    ACC := extraiACC_NZC (ACC_carry);
                end;
        _SBC :   begin
                    if (modoEnder=DIRETO) or (modoEnder=INDIRETO) then
                        operandReg := pegaMemoria (operandReg, 8);
                    ACC_carry := (ACC - operandReg) - ord(ALU_C);
                    ACC := extraiACC_NZC (ACC_carry);
                end;
        _OR  :  begin
                    if (modoEnder=DIRETO) or (modoEnder=INDIRETO) then
                        operandReg := pegaMemoria (operandReg, 8);
                    ACC := (ACC or operandReg) and BYTE_MASK;
                    atualizaNZ;
                    ALU_C := false;
                end;
        _XOR :  begin
                    if (modoEnder=DIRETO) or (modoEnder=INDIRETO) then
                        operandReg := pegaMemoria (operandReg, 8);
                    ACC := (ACC xor operandReg) and BYTE_MASK;
                    atualizaNZ;
                    ALU_C := false;
                end;
        _AND :  begin
                    if (modoEnder=DIRETO) or (modoEnder=INDIRETO) then
                        operandReg := pegaMemoria (operandReg, 8);
                    ACC := (ACC and operandReg) and BYTE_MASK;
                    atualizaNZ;
                    ALU_C := false;
                end;
        _NOT :  begin
                    ACC := ACC xor BYTE_MASK;
                    atualizaNZ;
                    ALU_C := false;
                end;
        _SHL :  begin
                    ACC_carry := ACC shl 1;
                    ACC := extraiACC_NZC (ACC_carry);
                end;
        _SHR : begin
                    ALU_C := (ACC and 1) <> 0;
                    ACC := ACC shr 1;
                    atualizaNZ;
                end;
        _SRA : begin
                    ALU_C := (ACC and 1) <> 0;
                    ACC := (ACC and $80) + ACC shr 1;
                    atualizaNZ;
                end;

        _JMP :  PC := operandReg;
        _JN  :  if ALU_N then PC := operandReg;
        _JP  :  if (not ALU_N) and (not ALU_Z) then PC := operandReg ;
        _JZ  :  if ALU_Z then PC := operandReg;
        _JNZ :  if not ALU_Z then PC := operandReg;
        _JC  :  if ALU_C then PC := operandReg;
        _JNC :  if not ALU_C then PC := operandReg;

        _IN  :   case operandReg of
                        0: begin
                                ACC := keyReg;
                                keyStatusReg := 0;
                           end;
                        1: ACC := keyStatusReg;
                        2: begin
                                ACC := kbdReg;
                                kbdStatusReg := 0;
                           end;
                        3: ACC := kbdStatusReg;
                  end;
        _OUT  :   case operandReg of
                        0: displayReg := ACC;
                        1: keyStatusReg := ACC and 1;
                        2: begin
                               BannerReg := BannerReg + chr(ACC);
                               while length (BannerReg) > 16 do
                                   delete (BannerReg, 1, 1);
                           end;
                        3: BannerReg := '';
                  end;

        _JSR: begin
                     SP := SP - 1;
                     memoria [SP] := (PC shr 8) and BYTE_MASK;
                     SP := SP - 1;
                     memoria [SP] := PC and BYTE_MASK;
                     PC := operandReg;
                end;
        _RET: begin
                     PC := (memoria[SP] or (memoria[SP+1] shl 8)) and WORD_MASK;
                     SP := SP + 2;
                end;

        _PUSH: begin
                     SP := SP - 1;
                     memoria [SP] := ACC;
                end;
        _POP: begin
                    ACC := memoria [SP];
                    SP := SP +1 ;
                    atualizaNZ;
                end;

        _TRAP:   execTrap (ACC, operandReg);

        _HLT  :   begin
                        running := false;
                        PC := (PC - 1) and WORD_MASK;
                  end;

    end;
end;

end.




