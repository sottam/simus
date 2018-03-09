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

unit uAssemb;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
    classes, sysUtils, uHex, uvars, dialogs,ResString, DefaultTranslator;

var
    listagem: TStringList;
    numErros: integer;

procedure compila (nome: string);

function pegaValor (s: string; mask: integer;
                    var erro: boolean): integer;

implementation

uses uSimus;

const
    PSEUDO = -1;

type
    TInfoSimbolo = class
        linha: integer;
        ender: integer;
    end;

var
    tabSimbolos: TStringList;

    lc: integer;    {location counter}
    nomeArq: string;
    passo: integer;

procedure mostraErro (s: string);
begin
    listagem.add (S________Erro + s);
    numErros := numErros + 1;
end;

procedure mostraAviso (s: string);
begin
    listagem.add (S________Atencao + s);
end;

procedure inicAssembler;
begin
    tabSimbolos := TStringList.create;
    tabSimbolos.sorted := true;
    numErros := 0;

    ndebugDados := 0;
    setLength (debugDados, ndebugDados);
end;

function simplifCadeia (token: string): string;
var i: integer;
begin
    i := 1;
    while i <= length(token) do
        begin
            if token[i] = '\' then
                begin
                    delete (token, i, 1);
                    case token[i] of
                        '0': token[i] := #$00;
                        't': token[i] := #$09;
                        'n': token[i] := #$0a;
                        'f': token[i] := #$0c;
                        'r': token[i] := #$0d;
                        '\': ;
                    else
                        token[i] := '.';
                    end;
                end;
            i := i + 1;
        end;
    result := token;
end;

function pegaToken (var s: string): string;
var
    token: string;
    iniciador: char;
begin
    token := '';
    if s = '' then
        begin
            result := token;
            exit;
        end;

    if upcase (s[1]) in ['A'..'Z', '_'] then
        begin
            repeat
                 token := token + s[1];
                 delete (s, 1, 1);
            until (s = '') or (not (upcase (s[1]) in ['A'..'Z', '_', '0'..'9']));
        end
    else
    if s[1] in ['0'..'9', '-'] then
        begin
            if s[1] = '-' then
                 begin
                     token := token + s[1];
                     delete (s, 1, 1);
                 end;
            repeat
                 token := token + s[1];
                 delete (s, 1, 1);
            until (s = '') or (not (upcase (s[1]) in ['0'..'9', 'A'..'F']));
            if upperCase(copy (s, 1, 1)) = 'H' then
                begin
                     token := token + s[1];
                     delete (s, 1, 1);
                end;
        end
    else
    if s[1] in ['"', ''''] then
        begin
            iniciador := s[1];
            token := '';
            repeat
                token := token + s[1];
                delete (s, 1, 1);
            until (s = '') or (s[1] = iniciador);
            if (s <> '') and (s[1] = iniciador) then
                begin
                    token := token + s[1];
                    delete (s, 1, 1);
                end;
        end
    else
        begin
            token := s[1];
            delete (s, 1, 1);
        end;

    s := trim (s);
    result := token;
end;

function compilaLinha (s: string;
                        var rotulo: string;
                        var instrucao: int8;
                        var operando: string;
                        var extra: string;
                        var tipoParam: integer;
                        var tamParam: integer): boolean;

var indTI: integer;
    proximo, token, desfaz: string;
    listaOp: string;
    achou: boolean;
    erro: boolean;


label checaOperando, veSeTerminou, fimDaLinha;

begin
    erro := false;

    rotulo := '';
    instrucao := VAZIA;
    operando := '';
    extra := '';
    tipoParam := NADA;
    tamParam := 0;

// verifica rótulo

    token := pegaToken (s);
    if (token = '') or (token[1] = ';') then goto fimDaLinha;

    if upcase(token[1]) in ['A'..'Z'] then
        begin
            desfaz := s;
            proximo := pegaToken(s);
            if upperCase(proximo) = 'EQU' then
                begin
                     rotulo := token;
                     token := proximo;
                end
            else
            if proximo = ':' then
                begin
                    rotulo := token;
                    token := pegaToken(s);
                    if (token = '') or (token[1] = ';') then goto fimDaLinha;
                end
            else
                if proximo <> '' then
                    s := desfaz;
        end;

// verifica instrução

    token := ansiUpperCase (token);

    achou := false;
    instrucao := INVALIDA;
    for indTI := 1 to NUMINSTR+NUMPSEUDOS do
       if tabInstrucoes[indTI].mnemo = token then
           begin
               instrucao := tabInstrucoes[indTI].codInstr;
               achou := true;
               break;
           end;

    if not achou then     // não é instrução nem pseudo, sai fora.
       begin
           erro := true;
           goto fimDaLinha;
       end;

// verifica operandos

    token := pegaToken(s);
    if (token = '') or (token[1] = ';') then goto fimDaLinha;

    if indTI <= NUMINSTR then
        begin
            tamParam := 1;
            tipoParam := DIRETO;

            if token = '#' then
                begin
                    if instrucao = _LDS then
                        tipoParam := IMEDIATO_16
                    else
                        tipoParam := IMEDIATO;
                    token := pegaToken(s);
                end
            else
            if token = '@' then
                begin
                    tipoParam := INDIRETO;
                    token := pegaToken(s);
                end;

            if instrucao in [_IN, _OUT] then
               if tipoParam = DIRETO then  // compatibilidade com códigos antigos
                    tipoParam := IMEDIATO;
        end
    else
        begin
            if instrucao = _STR then
                begin
                    token := simplifCadeia (token);
                    tamParam := length(token)-2;
                    tipoParam := CADEIA;

                    if (token = '') or
                       not ((token[1] in ['"', '''']) and (token[length(token)] = token[1])) then
                           begin
                               erro := true;
                               tamParam := 0;
                               if passo = 2 then
                                   begin
                                       mostraErro (SCadeiasComecamETerminamPorAspasOuPlics);
                                       goto fimDaLinha;
                                   end;
                           end
                end
            else
            if (instrucao = _DB) or (instrucao = _DW) then
                begin
                    listaOp := token;
                    tamParam := 1;
                    tipoParam := VALOR;

                    token := pegaToken(s);
                    if (token <> '') and (token <> ';') then
                        begin
                            tipoParam := LISTA;
                            while (token <> '') and (token[1] = ',') do
                                begin
                                    tamParam := tamParam+1;
                                    token := pegaToken(s);
                                    listaOp := listaOp + ',' + token;
                                    token := pegaToken(s);
                                end;
                        end;

                    if token = ';' then s := '';
                    token := listaOp;
                end
            else
            if instrucao = _LDI then
                begin
                   instrucao := _LDA;
                   tipoParam := IMEDIATO;
                end
            else
                begin
                   if (token[1] = '#') or (token[1] = '@') then
                       begin
                           erro := true;
                           if passo = 2 then
                               begin
                                   mostraErro (SPseudoInstrucaoNaoPermiteImediatoNemIndireto);
                                   goto fimDaLinha;
                               end;
                       end;

                   tamParam := 1;
                   tipoParam := VALOR;
                end;
        end;

    operando := token;

// vê se terminou

    token := pegaToken (s);
    if (token = '+') or (token = '-') then
        begin
             extra := token + pegaToken (s);
             token := pegaToken (s);
        end;

veSeTerminou:
    if (token <> '') and (token[1] <> ';') then
        begin
            erro := true;
            if passo = 2 then
                mostraErro (SComentarioOuParametroMalFormado);
        end;

fimDaLinha:
    compilaLinha := not erro;
end;

procedure fimAssembler;
var i: integer;
begin
    if numErros <> 0 then
        begin
            listagem.add ('');
            listagem.add (SNumeroDeErrosEncontrados + intToStr (numErros));
            showMessage  (SNumeroDeErrosEncontrados + intToStr (numErros));
        end;

    for i := 0 to tabSimbolos.count-1 do
        tabSimbolos.Objects[i].Free;
    tabSimbolos.Free;
end;

function pegaValor (s: string; mask: integer;
                    var erro: boolean): integer;
var i, valor: integer;
    nega: boolean;
begin
    pegaValor := 0;
    erro := true;
    nega := false;
    if s = '' then exit;

    if s[1] = '-' then
        begin
            nega := true;
            delete (s, 1, 1);
            if s = '' then exit;
        end;

    if not (upcase(s[1]) in ['0'..'9']) then exit;

    if upcase (s[length(s)]) = 'H' then
        begin
            delete (s, length(s), 1);
            for i := 2 to length (s)-1 do
                if not (upcase(s[i]) in ['0'..'9', 'A'..'F']) then exit;
            valor := hexToInt (s);
        end
    else
        begin
            for i := 2 to length (s) do
                if not (upcase(s[i]) in ['0'..'9']) then exit;
            valor := strToInt (s);
        end;

    if nega then
        begin
             pegaValor := (-valor) and mask;
             if (valor > ((mask div 2)+1)) then exit;   // nota: complemento a 2
        end
    else
        begin
            pegaValor := valor and mask;
            if valor > mask then exit;
        end;

    erro := false;
end;

function pegaValorOuSimbolo (operando, extra: string; mask: integer;
                             var erro: boolean): integer;
var
    i: integer;
    v: integer;
    op: char;

begin
    erro := false;
    if operando = '' then
        pegaValorOuSimbolo := 0
    else
        if tabSimbolos.Find(operando, i) then
            begin
                v := (tabSimbolos.Objects[i] as TInfoSimbolo).ender;
                if extra <> '' then
                    begin
                         op := extra[1];
                         delete (extra, 1, 1);
                         i := pegaValor (extra, mask, erro);
                         if op = '+' then
                              v := v + i
                         else
                              v := v - i;
                    end;
                result := v and mask;
            end
        else
            begin
                i := pegaValor (operando, mask, erro);
                if extra <> '' then erro := true;
                result := i and mask;
            end;
end;

procedure insereTabSimb (rotulo: string; linha, valor: integer);
var infoSimb: TInfoSimbolo;
    i: integer;
begin
    infoSimb := TInfoSimbolo.create;
    infoSimb.linha := linha;
    infoSimb.Ender := valor;

    if tabSimbolos.Find(rotulo, i) then
        mostraErro (rotulo + SRotuloDuplicado)
    else
       tabSimbolos.AddObject(rotulo, infoSimb);
end;

procedure passo1;
var l: integer;
    s: string;
    tipoParam, tamParam: integer;
    rotulo, operando, extra: string;
    instrucao: int8;
    erro: boolean;
    indTI: integer;
begin
    passo := 1;
    lc := 0;

    with formPrincipal do
        for l := 0 to SynEditor.Lines.Count-1 do
            begin
                s := SynEditor.lines[l];
                s := trim (s);
                if (s = '') or (s[1] = ';') then continue;

                compilaLinha (s, rotulo, instrucao, operando, extra, tipoParam, tamParam);

                if rotulo <> '' then
                    if instrucao = _EQU then
                        begin
                            insereTabSimb (rotulo, l, pegaValor(operando, $ffff, erro));
                            if erro then
                                mostraErro(SParametroDoEQUcomErro);
                            erro := false;
                        end
                    else
                        insereTabSimb (rotulo, l, lc);

                if instrucao = VAZIA then continue;

                indTI := indTabInstrPorCod[instrucao];

                if indTI <= NUMINSTR then
                begin
                        case tipoParam of
                            NADA:        lc := lc + 1;
                            DIRETO:      lc := lc + 3;
                            INDIRETO:    lc := lc + 3;
                            IMEDIATO:    lc := lc + 2;
                            IMEDIATO_16: lc := lc + 3;
                        end;
                end
                else
                begin
                     case instrucao of
                          _ORG:  lc := pegaValor (operando, $ffff, erro);
                          _DS:   lc := (lc + pegaValor (operando, $ffff, erro)) and WORD_MASK;
                          _DB:   lc := lc + tamParam;
                          _DW:   lc := lc + 2*tamParam;
                          _STR:  lc := lc + tamParam;
                          _END:  ;
                          _EQU:  ;
                          _LDI:  lc := lc + 2;

                     else
                         lc := lc + 1;  // erro
                     end;
                end;

            end;
end;

procedure compilaDB_DW (operando: string; lc: integer; mask: integer);
var umOper: string;
    v, p: integer;
    erro: boolean;
begin
    operando := operando + ',';
    repeat
        p := pos (',', operando);
        umOper := trim(copy (operando, 1, p-1));
        delete (operando, 1, p);
        umOper := trim(umOper);

        v := pegaValorOuSimbolo (umOper, '', mask, erro);
        if erro then
            begin
                mostraErro(SOperandoInvalido);
                exit;
            end;

        if mask = BYTE_MASK then
            begin
                memoria[lc] := v;
                lc := (lc + 1) and WORD_MASK;
            end
        else
            begin
                memoria[lc] := v and $ff;
                lc := (lc + 1) and WORD_MASK;
                memoria[lc] := v shr 8;
                lc := (lc + 1) and WORD_MASK;
            end;

    until operando = '';
end;

procedure registraDadosParaDebug
            (_ender, _nposd: integer; _tipo: char; _nome: string);
begin
    nDebugDados := nDebugDados + 1;
    setLength (debugDados, nDebugDados);
    with debugDados[ndebugDados-1] do
        begin
            ender  := _ender;
            nposd  := _nposd;
            tipo   := _tipo;
            nome   := _nome;
        end;
end;

procedure passo2;
var i, l: integer;
    s, numS, enderS, codS: string;
    rotulo, operando: string;
    extra: string;
    tipoParam, tamParam: integer;
    instrucao: int8;
    v: integer;
    erro: boolean;
    indTI: integer;
    lcInic: integer;

label fazListagem;

const
    tabModoOperando: array [0..16] of byte = (0, 0, 1, 0, 2, 0, 0, 0, 3,
                                                 0, 0, 0, 0, 0, 0, 0, 0);
begin
    passo := 2;
    lc := 0;

    listagem.add ('');
    nDebugDados := 0;
    setLength (debugDados, 0);

    with formPrincipal do
        for l := 0 to SynEditor.Lines.Count-1 do
            begin
                str (l+1:4, numS);
                enderS := '    ';
                codS   := '        ';

                s := trim (SynEditor.lines[l]);
                s := StringReplace(s, #9, '        ', [rfReplaceAll]);   // provisório

                if (s <> '') and (s[1] <> ';') then
                    begin
                        compilaLinha (s, rotulo, instrucao, operando, extra, tipoParam, tamParam);

                        if instrucao = VAZIA then // só rótulo
                            begin
                                enderS := intToHex (lc, 4);
                                goto fazListagem;
                            end;

                        if instrucao = 255 then
                            indTI := INVALIDA
                        else
                            indTI := indTabInstrPorCod[instrucao];

                        if indTI = INVALIDA then
                            mostraErro(SInstrucaoInvalida)
                        else
                        if instrucao <> _END then
                            begin
                                if tipoParam = NADA then
                                    begin
                                        if tabInstrucoes[indTI].params <> NADA then
                                             mostraErro(SEstaInstrucaoNaoPossuiParametros);
                                    end
                                else
                                if (tipoParam and tabInstrucoes[indTI].params) = 0 then
                                    mostraErro(SOTipoDeParametroEIncompativelComAInstrucao);
                            end;

                          if indTI <= NUMINSTR then
                            begin
                                enderS := intToHex (lc, 4);
                                memoria[lc] := instrucao shl 2 + tabModoOperando[tipoParam];
                                cods := intToHex (memoria[lc], 2);
                                lc := lc + 1;
                                erro := false;

                                case tipoParam of
                                    NADA:        ;
                                    DIRETO,
                                    INDIRETO:    begin
                                                    v := pegaValorOuSimbolo (operando, extra, WORD_MASK, erro);
                                                    memoria[lc]   := v and $FF;
                                                    memoria[lc+1] := (v shr 8) and $FF;
                                                    codS := codS + ' ' +
                                                            intToHex (memoria[lc], 2) + ' ' +
                                                            intToHex (memoria[lc+1], 2);
                                                    lc := lc + 2;
                                                 end;
                                    IMEDIATO:    begin
                                                    v := pegaValorouSimbolo (operando, extra, BYTE_MASK, erro);
                                                   memoria[lc]   := v and $FF;
                                                    codS := codS  + ' ' +
                                                            intToHex (memoria[lc], 2) ;
                                                    lc := lc + 1;
                                                 end;
                                    IMEDIATO_16: begin
                                                    v := pegaValorOuSimbolo (operando, extra, WORD_MASK, erro);
                                                    memoria[lc]   := v and $FF;
                                                    memoria[lc+1] := (v shr 8) and $FF;
                                                    codS := codS + ' ' +
                                                            intToHex (memoria[lc], 2) + ' ' +
                                                            intToHex (memoria[lc+1], 2);
                                                    lc := lc + 2;
                                                 end;
                                end;

                            if erro then
                                mostraErro(SOperandoMalFormado);

                            end
                        else
                            begin
                                lcInic := lc;
                                case instrucao of
                                    _ORG:  begin
                                               lc := pegaValor (operando, $ffff, erro);
                                               if erro then
                                                    mostraErro(SOrigemInvalida);
                                           end;

                                    _EQU:   ;

                                    _DS:    begin
                                                enderS := intToHex (lc, 4);
                                                v := pegaValor (operando, $ffff, erro);
                                                if erro then
                                                     begin
                                                         mostraErro(SOperandoInvalido);
                                                         v := 1;
                                                     end;
                                                registraDadosParaDebug (lc, v, 'B', rotulo);
                                                lc := (lc + v) and WORD_MASK;
                                           end;

                                    _DB:   begin
                                               compilaDB_DW (operando, lc, BYTE_MASK);

                                               enderS := intToHex (lc, 4);
                                               codS := '';
                                               for i := 1 to tamParam do
                                                   begin
                                                       v := memoria[lc];
                                                       codS := cods + intToHex (v, 2) + ' ';
                                                       lc := (lc + 1) and WORD_MASK;
                                                   end;
                                               registraDadosParaDebug (lcInic, tamParam, 'B', rotulo);
                                           end;

                                    _DW:   begin
                                               compilaDB_DW (operando, lc, WORD_MASK);

                                               enderS := intToHex (lc, 4);
                                               codS := '';
                                               for i := 1 to tamParam do
                                                   begin
                                                       v := memoria[lc] or
                                                           (memoria[(lc+1) and WORD_MASK] shl 8);
                                                       codS := cods + intToHex (v, 4) + ' ';
                                                       lc := (lc + 2) and WORD_MASK;
                                                   end;
                                               registraDadosParaDebug (lcInic, tamParam, 'W', rotulo);
                                           end;

                                    _STR:  begin
                                               enderS := intToHex (lc, 4);
                                               codS := '';
                                               for i := 2 to length(operando)-1 do
                                                   begin
                                                        v := ord(operando[i]);
                                                        memoria[lc] := v;
                                                        codS := cods + intToHex (v, 2) + ' ';
                                                        lc := (lc + 1) and WORD_MASK;
                                                   end;
                                               delete (codS, length(codS), 1);
                                               registraDadosParaDebug (lcInic, tamParam, 'S', rotulo);
                                           end;

                                    _END:  begin
                                                if operando = '' then
                                                    PC := 0
                                                else
                                                    PC := pegaValorOuSimbolo (operando, extra, WORD_MASK, erro);  /// falar se tiver erro
                                                PC_original := PC;
                                           end;
                                end;
                            end;

                    end;

fazListagem:
                if length(cods) > 10 then
                    begin
                        delete (cods, 10, 999);
                        cods := cods + '...';
                    end;
                s := copy (numS+ '          ', 1, 5);
                s := s + '  ' + copy (enderS + '      ', 1, 6);
                s := s + '  ' + copy (codS   + '          ', 1, 12);
                s := s + '  ' + SynEditor.lines[l];
                listagem.add (s);
            end;
end;

procedure listaTabSimbolos;
var i: integer;
    s1, s2, s3: string;
begin
    listagem.add (SSimbolo_________Linha__Endereco);

    for i := 0 to tabSimbolos.count-1 do
        begin
            s1 := tabSimbolos[i];
            s1 := s1 + '               ';
            while length (s1) > 15 do delete (s1, length(s1), 1);

            s2 := intToStr ((tabSimbolos.objects[i] as TInfoSimbolo).linha);
            s2 := '       ' + s2;
            while length (s2) > 6 do delete (s2, 1, 1);

            s3 := intToHex ((tabSimbolos.objects[i] as TInfoSimbolo).ender, 4);
            s3 := '       ' + s3;
            while length (s3) > 6 do delete (s3, 1, 1);

            listagem.add (s1+s2+s3);
        end;
end;

procedure compila (nome: string);
begin
    nomeArq := nome;

    with listagem do
        begin
            clear;
            add (SCompilacaoEmAssemblyDoTexto + nomeArq);
            add (S_Em + dateTimeToStr(date));

            inicAssembler;

            passo1;               {descobre endereços dos símbolos}
            passo2;               {gera código}

            if tabSimbolos.count  <> 0 then
                begin
                    add ('');
                    add (SListagem + S_DaTabelaDeSimbolos);
                    add ('');

                    listaTabSimbolos;
                end;

            fimAssembler;
        end;
end;

begin
    listagem := TStringList.Create;
end.

