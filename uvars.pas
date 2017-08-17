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

unit uvars;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

type
    int6  = byte;
    int8  = byte;
    int9  = word;
    int16 = word;

const               { códigos das instruções }
    _NOP  = 0;
    _STA  = 4;
    _STS  = 5;
    _LDA  = 8;
    _LDS  = 9;
    _ADD  = 12;
    _ADC  = 13;
    _SUB  = 14;
    _SBC  = 15;
    _OR   = 16;
    _XOR  = 17;
    _AND  = 20;
    _NOT  = 24;
    _SHL =  28;
    _SHR =  29;
    _SRA =  30;
    _JMP  = 32;
    _JN   = 36;
    _JP   = 37;
    _JZ   = 40;
    _JNZ  = 41;
    _JC   = 44;
    _JNC  = 45;
    _IN   = 48;
    _OUT  = 49;
    _JSR  = 52;
    _RET  = 54;
    _PUSH = 56;
    _POP  = 57;
    _TRAP = 60;
    _HLT  = 63;

    _ORG  = 100;
    _END  = 101;
    _DS   = 102;
    _DB   = 103;
    _DW   = 104;
    _STR  = 105;
    _EQU  = 106;
    _LDI  = 107;

    VAZIA = 254;
    INVALIDA = 255;

const
    NADA = 0;               // tipos de parâmetros
    DIRETO = 1;
    INDIRETO = 2;
    IMEDIATO  = 4;
    IMEDIATO_16 = 8;
    VALOR = 16;
    LISTA = 32;
    CADEIA = 64;

type
    TTabInstrucoes = record
        mnemo: string[4];
        codInstr: integer;
        params: integer;
    end;

const
    NUMINSTR = 31;
    NUMPSEUDOS = 8;

    tabInstrucoes: array [1..NUMINSTR + NUMPSEUDOS] of TTabInstrucoes =
      ( (mnemo:'NOP';  codInstr:_NOP;  params:NADA),
        (mnemo:'STA';  codInstr:_STA;  params:DIRETO+INDIRETO),
        (mnemo:'STS';  codInstr:_STS;  params:DIRETO+INDIRETO),
        (mnemo:'LDA';  codInstr:_LDA;  params:DIRETO+INDIRETO+IMEDIATO),
        (mnemo:'LDS';  codInstr:_LDS;  params:DIRETO+INDIRETO+IMEDIATO_16),
        (mnemo:'ADD';  codInstr:_ADD;  params:DIRETO+INDIRETO+IMEDIATO),
        (mnemo:'ADC';  codInstr:_ADC;  params:DIRETO+INDIRETO+IMEDIATO),
        (mnemo:'SUB';  codInstr:_SUB;  params:DIRETO+INDIRETO+IMEDIATO),
        (mnemo:'SBC';  codInstr:_SBC;  params:DIRETO+INDIRETO+IMEDIATO),
        (mnemo:'OR';   codInstr:_OR;   params:DIRETO+INDIRETO+IMEDIATO),
        (mnemo:'XOR';  codInstr:_XOR;  params:DIRETO+INDIRETO+IMEDIATO),
        (mnemo:'AND';  codInstr:_AND;  params:DIRETO+INDIRETO+IMEDIATO),
        (mnemo:'NOT';  codInstr:_NOT;  params:NADA),
        (mnemo:'SHL';  codInstr:_SHL;  params:NADA),
        (mnemo:'SHR';  codInstr:_SHR;  params:NADA),
        (mnemo:'SRA';  codInstr:_SRA;  params:NADA),
        (mnemo:'JMP';  codInstr:_JMP;  params:DIRETO+INDIRETO),
        (mnemo:'JN';   codInstr:_JN;   params:DIRETO+INDIRETO),
        (mnemo:'JP';   codInstr:_JP;   params:DIRETO+INDIRETO),
        (mnemo:'JZ';   codInstr:_JZ;   params:DIRETO+INDIRETO),
        (mnemo:'JNZ';  codInstr:_JNZ;  params:DIRETO+INDIRETO),
        (mnemo:'JC';   codInstr:_JC;   params:DIRETO+INDIRETO),
        (mnemo:'JNC';  codInstr:_JNC;  params:DIRETO+INDIRETO),
        (mnemo:'IN';   codInstr:_IN;   params:IMEDIATO),  // transforma direto em imediato
        (mnemo:'OUT';  codInstr:_OUT;  params:IMEDIATO),  // transforma direto em imediato
        (mnemo:'JSR';  codInstr:_JSR;  params:DIRETO+INDIRETO),
        (mnemo:'RET';  codInstr:_RET;  params:NADA),
        (mnemo:'PUSH'; codInstr:_PUSH; params:NADA),
        (mnemo:'POP';  codInstr:_POP;  params:NADA),
        (mnemo:'TRAP'; codInstr:_TRAP; params:DIRETO+INDIRETO),
        (mnemo:'HLT';  codInstr:_HLT;  params:NADA),


        (mnemo:'ORG';  codInstr:_ORG;  params:VALOR),
        (mnemo:'END';  codInstr:_END;  params:VALOR),
        (mnemo:'DS';   codInstr:_DS;   params:VALOR),
        (mnemo:'DB';   codInstr:_DB;   params:VALOR+LISTA),
        (mnemo:'DW';   codInstr:_DW;   params:VALOR+LISTA),
        (mnemo:'STR';  codInstr:_STR;  params:CADEIA),
        (mnemo:'EQU';  codInstr:_EQU;  params:VALOR),
        (mnemo:'LDI';  codInstr:_LDI;  params:VALOR)     // compatibilidade com códigos antigos

      );

const
    BYTE_MASK = $ff;
    WORD_MASK = $ffff;
    CARRY_MASK = $0100;

    MAX_MEM = $FFFF;

var
    ACC: int8;
    PC:  int16;
    SP:  int16;

    ALU_N: boolean;
    ALU_Z: boolean;
    ALU_C: boolean;

    instReg: int6;
    operandReg: int16;
    modoEnder: int6;
    modoImediato: boolean;
    ACC_carry: int9;

    displayReg: int8;      // endereço 0 de saída
    keyReg: int8;          // endereço 0 de entrada
    keyStatusReg: int8;    // endereço 1 de entrada
    kbdReg: int8;          // endereço 2 de entrada
    kbdStatusReg: int8;    // endereço 3 de entrada
    bannerReg: string;     // endereço 2 de saída   (endereço 3 = limpa banner)

    PC_original: int16;    // cópia do PC quando reset

    memoria: array [0..WORD_MASK] of int8;

    running: boolean;      // indica que está executando

    indTabInstrPorCod: array [0..120] of integer;

type
    TDebugDados = record
         ender: integer;
         nposd: integer;
         tipo: char;
         nome: string;
    end;

var
    ndebugDados: integer;
    debugDados: array of TDebugDados;

implementation

var i: integer;
begin
    for i := 0 to 120 do
        indTabInstrPorCod[i] := -1;
    for i := 1 to NUMINSTR+NUMPSEUDOS do
        indTabInstrPorCod[tabInstrucoes[i].codInstr] := i;
end.
