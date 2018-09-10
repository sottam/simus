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
//    Este arquivo é parte do programa MainMenu SimuS.
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

unit uSimus;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  shellApi, Windows,
{$ELSE}
  LCLIntf, LCLType,
{$ENDIF}
  SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, Buttons, uSimula, ExtCtrls, ComCtrls, SynEdit,
  SynHighlighterPas, SynHighlighterAny, SynCompletion, Types, LCLTranslator,
  DefaultTranslator, ResString, utrap;

type

  { TformPrincipal }

  TformPrincipal = class(TForm)
    chave0: TLabel;
    chave1: TLabel;
    BreakPointBtn: TSpeedButton;
    DisplayTitulo: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    AbrirExemplo: TMenuItem;
    EditorEPainelDeControle: TPanel;
    l_Valor: TLabel;
    MainMenu: TMainMenu;
    Arquivo1: TMenuItem;
    Abrir1: TMenuItem;
    MolduraBanner: TBevel;
    MolduraChaves: TShape;
    MolduraCtrlExec: TBevel;
    MolduraVisor: TBevel;
    Pronto: TLabel;
    Salvar1: TMenuItem;
    SalvarComo1: TMenuItem;
    Sair1: TMenuItem;
    N1: TMenuItem;
    Compilar1: TMenuItem;
    Assistente1: TMenuItem;
    b_executar: TButton;
    b_passoAPasso: TButton;
    b_parar: TButton;
    l_display: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    l_teclado: TLabel;
    b_entrar: TButton;
    ledOff_dado: TSpeedButton;
    LedOn_dado: TSpeedButton;
    b_reset: TButton;
    ledOn_exec: TSpeedButton;
    ledOff_exec: TSpeedButton;
    l_executando: TLabel;
    Highlighter: TSynAnySyn;
    SynAutoComplete: TSynAutoComplete;
    SynCompletion: TSynCompletion;
    SynEditor: TSynEdit;
    Edicao: TTabSheet;
    TimerDeExecucao: TTimer;
    AbrirLingMquina1: TMenuItem;
    SalvarLingMquina1: TMenuItem;
    Sobreoprograma1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Novo1: TMenuItem;
    OpenDialog2: TOpenDialog;
    SaveDialog2: TSaveDialog;
    b_zera: TButton;
    ch128on: TSpeedButton;
    ch64on: TSpeedButton;
    ch32on: TSpeedButton;
    ch16on: TSpeedButton;
    ch8on: TSpeedButton;
    ch4on: TSpeedButton;
    ch2on: TSpeedButton;
    ch1on: TSpeedButton;
    ch128off: TSpeedButton;
    ch64off: TSpeedButton;
    ch32off: TSpeedButton;
    ch16off: TSpeedButton;
    ch8off: TSpeedButton;
    ch4off: TSpeedButton;
    ch2off: TSpeedButton;
    ch1off: TSpeedButton;
    Shape1: TShape;
    Label1: TLabel;
    cb_rapido: TCheckBox;
    Zerarmemria1: TMenuItem;
    Editar1: TMenuItem;
    Copiar1: TMenuItem;
    cOlar1: TMenuItem;
    Recortar1: TMenuItem;
    Desfazer1: TMenuItem;
    BarButton: TPanel;
    OpenBtn: TSpeedButton;
    SaveBtn: TSpeedButton;
    CutBtn: TSpeedButton;
    CopyBtn: TSpeedButton;
    PasteBtn: TSpeedButton;
    ExitBtn: TSpeedButton;
    TutorBtn: TSpeedButton;
    NewBnt: TSpeedButton;
    Ajuda2: TMenuItem;
    Bevel1: TBevel;
    RegistradoresEMemoria: TPanel;
    AlteraMemoria: TPanel;
    l_endereco: TLabel;
    l_novoValor: TLabel;
    e_ender: TEdit;
    b_recua: TButton;
    b_avanca: TButton;
    e_valor: TEdit;
    PainelRegs: TPanel;
    l_instr: TLabel;
    l_instrucao: TLabel;
    l_operInstrucao: TLabel;
    l_registrador: TLabel;
    l_PC: TLabel;
    l_ACC: TLabel;
    l_Z: TLabel;
    l_N: TLabel;
    MolduraInstrAtual: TBevel;
    b_PC: TButton;
    b_ACC: TButton;
    b_Z: TButton;
    b_N: TButton;
    dumpMem: TListBox;
    l_banner: TLabel;
    b_C: TButton;
    b_SP: TButton;
    l_SP: TLabel;
    l_C: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Codigo: TPageControl;
    Compilacao: TTabSheet;
    lb_instrucoes: TListBox;
    Execucao: TTabSheet;
    m_listagem: TMemo;
    Console1: TMenuItem;
    cb_hexa: TCheckBox;
    ProgramaoTutorada1: TMenuItem;
    Conversordebases1: TMenuItem;
    PainelControle: TPanel;
    lb_dados: TListBox;
    Splitter: TSplitter;
    teclado1: TButton;
    teclado2: TButton;
    teclado3: TButton;
    teclado6: TButton;
    teclado5: TButton;
    teclado4: TButton;
    teclado7: TButton;
    teclado8: TButton;
    teclado9: TButton;
    tecladoAsterico: TButton;
    teclado0: TButton;
    tecladoHashTag: TButton;
    MolduraKeypad: TBevel;
    CompileBtn: TSpeedButton;

    procedure AbrirExemploClick(Sender: TObject);
    procedure BreakPointBtnClick(Sender: TObject);
    procedure b_pararClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure lb_instrucoesDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure lb_instrucoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lb_instrucoesSelectionChange(Sender: TObject; User: boolean);
    procedure TimerDeExecucaoTimer(Sender: TObject);
    procedure b_executarClick(Sender: TObject);
    procedure b_resetClick(Sender: TObject);
    procedure e_enderExit(Sender: TObject);
    procedure b_PCClick(Sender: TObject);
    procedure b_ACCClick(Sender: TObject);
    procedure b_recuaClick(Sender: TObject);
    procedure b_avancaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure e_valorKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure e_valorExit(Sender: TObject);
    procedure b_passoAPassoClick(Sender: TObject);
    procedure b_entrarClick(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure Sobreoprograma1Click(Sender: TObject);
    procedure Assistente1Click(Sender: TObject);
    procedure Abrir1Click(Sender: TObject);
    procedure SalvarComo1Click(Sender: TObject);
    procedure Novo1Click(Sender: TObject);
    procedure NovoArquivo;
    procedure Salvar1Click(Sender: TObject);
    procedure SalvarLingMquina1Click(Sender: TObject);
    procedure AbrirLingMquina1Click(Sender: TObject);
    procedure Compilar1Click(Sender: TObject);
    procedure b_zeraClick(Sender: TObject);
    procedure b_ZClick(Sender: TObject);
    procedure b_NClick(Sender: TObject);
    procedure b_CClick(Sender: TObject);
    procedure click_desliga(Sender: TObject);
    procedure click_liga(Sender: TObject);
    procedure cb_rapidoClick(Sender: TObject);
    procedure Zerarmemria1Click(Sender: TObject);
    procedure CutBtnClick(Sender: TObject);
    procedure CopyBtnClick(Sender: TObject);
    procedure PasteBtnClick(Sender: TObject);
    procedure Desfazer1Click(Sender: TObject);
    procedure Ajuda2Click(Sender: TObject);
    procedure limpaEditor;
    procedure atualizaListagem;
    procedure preparaDebug;
    procedure atualizaDebug (pc: integer);
    procedure editorKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Console1Click(Sender: TObject);
    procedure cb_hexaClick(Sender: TObject);
    procedure Conversordebases1Click(Sender: TObject);
    procedure dumpMemClick(Sender: TObject);
    procedure b_tecladoClick(Sender: TObject);

  private
    { Private declarations }
    function VerificaBreakpoint() : boolean;
  public
    { Public declarations }
    procedure atualizaInterface;
    procedure mostraAlterado (alteraDump: boolean);
    procedure geraDump (ender: integer);
    function geraLinhaDump (ender: integer): string;
    procedure atualizaDump;
    procedure atualizaLeds;
    procedure atualizaDados (zerando: boolean);
    //procedure NovoArquivo;
  end;

var
  formPrincipal: TformPrincipal;
  enderAlterado: integer;
  nomeArq: string;
  execucaoRapida: boolean;

  BreakpointList    : TStringList;
  ExecutingLine     : integer;
  controlKeyPressed : boolean;

implementation

uses uHex, uvars, uAbout, uAutoPrg, uAssemb, uconsole;

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

procedure TformPrincipal.atualizaInterface;
var instr, ender, dado: integer;
    ind_ti: integer;
    modoEnder: integer;
begin
    l_display.caption := intToHex (displayReg, 2);
    l_teclado.caption := intToHex (keyReg, 2);
    atualizaLeds;
    l_display.caption := intToHex (displayReg, 2);

    instr := (memoria[PC] shr 2) and $3f;
    ind_ti := indTabInstrPorCod[instr];

    if ind_ti < 0 then   // instrução inválida
        begin
            l_instrucao.caption := '???';
            l_operInstrucao.Caption := ''
        end
    else
       begin
            l_instrucao.caption := tabInstrucoes[ind_ti].mnemo;
            if not modoEnderValido (ind_ti, memoria[PC] and 2) then
                l_operInstrucao.Caption := '???'
            else
            if tabInstrucoes[ind_ti].params = 0 then
                l_operInstrucao.Caption := ''
            else
            if tabInstrucoes[ind_ti].params = VALOR then
                begin
                    ender := pegaMemoria (PC+1, 8);
                    l_operInstrucao.Caption := intToHex (ender, 2);
                end
            else
                begin
                    modoEnder := memoria[PC] and 3;
                    case modoEnder of
                        0: begin   {direto}
                               ender := pegaMemoria (PC+1, 16);
                               l_operInstrucao.Caption := intToHex (ender, 4);
                           end;
                        1: begin   {indireto}
                               ender := pegaMemoria (PC+1, 16);
                               l_operInstrucao.Caption := '@' + intToHex (ender, 4);
                           end;
                        2: begin   {imediato - 8 bits}
                               dado := pegaMemoria (PC+1, 8);
                               l_operInstrucao.Caption := '#' + intToHex (dado, 2);
                           end;
                        3: begin   {imediato - 16 bits}
                               dado := pegaMemoria (PC+1, 16);
                               l_operInstrucao.Caption := '#' + intToHex (dado, 4);
                           end;
                    end;
                end;
        end;

    l_PC.caption := intToHex (PC, 4);
    l_ACC.caption := intToHex (ACC, 2);
    l_SP.caption := intToHex (SP, 4);

    if ALU_N then l_N.Caption := '1' else l_N.Caption := '0';
    if ALU_Z then l_Z.Caption := '1' else l_Z.Caption := '0';
    if ALU_C then l_C.Caption := '1' else l_C.Caption := '0';

    l_banner.Caption := bannerReg;

    mostraAlterado (false);
    atualizaDump;
    atualizaDados (false);
    atualizaDebug (PC);
end;

procedure TformPrincipal.b_PCClick(Sender: TObject);
var s: string;
begin
    running := false;
    atualizaLeds;
    s := intToHex (PC, 4);
    l_PC.caption := s;
    if inputQuery (SInforme, SNovoValorDoPC, s) then
        PC := hexToInt (s) and $ffff;
    atualizaInterface;
end;

procedure TformPrincipal.b_ACCClick(Sender: TObject);
var s: string;
begin
    running := false;
    atualizaLeds;
    s := intToHex (ACC, 2);
    l_ACC.caption := s;
    if inputQuery (SInforme, SNovoValorDoAcc, s) then
        ACC := hexToInt (s) and $ff;
    atualizaInterface;
end;

function TformPrincipal.geraLinhaDump (ender: integer): string;
var
   s: string;
   i: integer;
begin
    s := intToHex (ender, 4) + ': ';
    if cb_hexa.checked then
        begin
            for i := 0 to 7 do
                begin
                    s := s + intToHex (memoria[ender+i], 2);
                    if odd(i) then s := s + ' ';
                end;
        end
    else
        begin
            for i := 0 to 7 do
                begin
                    if memoria[ender+i] >= $20 then
                        s := s + ' ' + chr(memoria[ender+i])
                    else
                        case memoria[ender+i] of
                            $00: s := s + '\0';
                            $09: s := s + '\t';
                            $0a: s := s + '\n';
                            $0c: s := s + '\f';
                            $0d: s := s + '\r';
                        else
                            s := s + ' .';
                        end;
                end;
        end;

    result := s;
end;

procedure TformPrincipal.geraDump (ender: integer);
begin
    ender := ender and $FFF8;
    dumpMem.items [ender div 8] := geraLinhaDump (ender);
end;

procedure TformPrincipal.atualizaDump;
var
    i, ini, fim: integer;
begin
    ini := dumpMem.TopIndex;
    fim := ini + dumpMem.ClientHeight div dumpmem.ItemHeight - 1;
    for i := ini to fim do
        dumpMem.Items[i] := geraLinhaDump(i*8);
end;

procedure TformPrincipal.mostraAlterado (alteraDump: boolean);
begin
    e_ender.text := intToHex (enderAlterado, 4);
    e_valor.text := intToHex (memoria [enderAlterado], 2);
    e_valor.SelectAll;
    if alteraDump then
        begin
            geraDump (enderAlterado);
            dumpMem.Selected [enderAlterado div 8] := true;
        end;
end;

procedure TformPrincipal.e_enderExit(Sender: TObject);
begin
    enderAlterado := hexToInt (e_ender.text) and $FFFF;
    mostraAlterado (true);
end;

procedure TformPrincipal.e_valorExit(Sender: TObject);
begin
    memoria [enderAlterado] := hexToInt (e_valor.text) and $FF;
    mostraAlterado (true);
end;

procedure TformPrincipal.b_recuaClick(Sender: TObject);
begin
    enderAlterado := (enderAlterado - 1) and $FFFF;
    mostraAlterado (true);
end;

procedure TformPrincipal.b_avancaClick(Sender: TObject);
begin
    enderAlterado := (enderAlterado + 1) and $FFFF;
    mostraAlterado (true);
end;

procedure TformPrincipal.e_valorKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if key = VK_RETURN then
        begin
            e_valorExit (Sender);
            b_avancaClick (Sender);
        end;
end;

procedure TformPrincipal.FormActivate(Sender: TObject);
begin
    atualizaInterface;
    atualizaDump;
end;

procedure TformPrincipal.FormCreate(Sender: TObject);
var i: integer;
begin
    inicMaquina (true);

    execucaoRapida := cb_rapido.Checked;
    limpaEditor;

    dumpMem.Items.Clear;
    for i := 0 to 65535 div 8 do
        dumpMem.Items.add (geraLinhaDump(i*8));

    atualizaDump;

    BreakpointList:= TStringList.Create;
    BreakpointList.Duplicates:= dupIgnore;
    BreakpointList.Sorted:= true;

    Codigo.ActivePage:=Edicao;
end;

procedure TformPrincipal.b_passoAPassoClick(Sender: TObject);
begin
    Codigo.ActivePage := Execucao;
    running := false;

    executaInstrucao;
    atualizaInterface;
end;

procedure TformPrincipal.atualizaLeds;
begin
    if running then
        begin
            ledOn_exec.Visible := true;
            ledOff_exec.Visible := false;
        end
    else
        begin
            ledOn_exec.Visible := false;
            ledOff_exec.Visible := true;
        end;

    if keyStatusReg <> 0 then
        begin
            ledOn_dado.Visible := true;
            ledOff_dado.Visible := false;
        end
    else
        begin
            ledOn_dado.Visible := false;
            ledOff_dado.Visible := true;
        end;
end;

procedure TformPrincipal.b_entrarClick(Sender: TObject);
begin
    keyStatusReg := 1;
    atualizaLeds;
end;

procedure TformPrincipal.Sair1Click(Sender: TObject);
begin
  Close;
end;

procedure TformPrincipal.Sobreoprograma1Click(Sender: TObject);
begin
    aboutBox.visible := true;
end;

procedure TformPrincipal.Assistente1Click(Sender: TObject);
begin
    formAutoMonta.visible := true;
end;

procedure TformPrincipal.AbrirExemploClick(Sender: TObject);
begin
     b_pararClick(Sender);

    if SynEditor.Modified <> false then
        if MessageDlg(STudoFoiSalvo,
              mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;
    OpenDialog1.InitialDir:= ExtractFilePath(Application.ExeName) + DirectorySeparator + 'Exemplos';
    if openDialog1.Execute then
        begin
            nomeArq := openDialog1.FileName;
            try
                SynEditor.Lines.LoadFromFile(nomeArq);
                caption := nomeArq + S_SimuladorDoProcSapiens8;
                m_listagem.Clear;
                lb_instrucoes.Clear;

                ndebugDados := 0;
                setLength (debugDados, ndebugDados);
                lb_dados.Clear;
            except
                showMessage (SErroAoCarregarArquivo);
            end;

        end;
end;

procedure TformPrincipal.BreakPointBtnClick(Sender: TObject);
var
  idx, isBreakpoint : integer;
begin
  if Codigo.ActivePage <> Execucao then Exit;

  idx := lb_instrucoes.ItemIndex;

  isBreakpoint :=  BreakpointList.IndexOf( IntToStr(idx));

  if isBreakpoint = -1 then
     BreakpointList.Add(IntToStr(idx))
  else
     BreakpointList.Delete(isBreakPoint);
  lb_instrucoes.Repaint;

end;

procedure TformPrincipal.Abrir1Click(Sender: TObject);
begin
    b_pararClick(Sender);

    if SynEditor.Modified <> false then
        if MessageDlg(STudoFoiSalvo,
              mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;

    if openDialog1.Execute then
        begin
            nomeArq := openDialog1.FileName;
            try
                SynEditor.Lines.LoadFromFile(nomeArq);
                caption := nomeArq + S_SimuladorDoProcSapiens8;
                m_listagem.Clear;
                lb_instrucoes.Clear;

                ndebugDados := 0;
                setLength (debugDados, ndebugDados);
                lb_dados.Clear;
            except
                showMessage (SErroAoCarregarArquivo);
            end;

        end;
end;

procedure TformPrincipal.SalvarComo1Click(Sender: TObject);
begin
    if nomeArq <> '' then
        SaveDialog1.FileName := nomeArq;

    if SaveDialog1.execute then
        begin
            nomeArq := SaveDialog1.FileName;
            if nomeArq <> '' then
                begin
                    SynEditor.Lines.SaveToFile(nomeArq);
                    caption := nomeArq + S_SimuladorDoProcSapiens8;
                end;
        end;
end;

procedure TformPrincipal.limpaEditor;
begin
    SynEditor.clear;
    SynEditor.lines.add (';---------------------------------------------------');
    SynEditor.lines.add (SPrograma);
    SynEditor.lines.add (SAutor);
    SynEditor.lines.add (SData);
    SynEditor.lines.add (';---------------------------------------------------');
    SynEditor.Lines.Add('');
    SynEditor.SelStart := SynEditor.GetTextLen;
end;

procedure TformPrincipal.NovoArquivo;
begin
  nomeArq := '';
  caption := SSimuladorDoProcSapiens8;
  limpaEditor;
  m_listagem.Clear;
  lb_instrucoes.Clear;

  ndebugDados := 0;
  setLength (debugDados, ndebugDados);
  lb_dados.Clear;
end;

procedure TformPrincipal.Novo1Click(Sender: TObject);
begin
    b_pararClick(Sender);

    if SynEditor.Modified <> false then
        if MessageDlg(STudoFoiSalvo, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
            begin
              NovoArquivo;
            end
        else
            begin
              if nomeArq <> '' then
                 SaveDialog1.FileName := nomeArq;

              if SaveDialog1.execute then
                  begin
                    nomeArq := SaveDialog1.FileName;
                    if nomeArq <> '' then
                       begin
                         SynEditor.Lines.SaveToFile(nomeArq);
                         caption := nomeArq + S_SimuladorDoProcSapiens8;
                       end;
                    NovoArquivo;
                  end
              else
                begin
                  exit;
                end;
            end;
end;

procedure TformPrincipal.Salvar1Click(Sender: TObject);
begin
    if nomeArq <> '' then
        SynEditor.Lines.SaveToFile(nomeArq)
    else
        salvarComo1Click (sender);
end;

procedure TformPrincipal.SalvarLingMquina1Click(Sender: TObject);
var i, ultEnderValido: integer;
    arq: textFile;
begin
    if saveDialog2.execute then
        begin
            if saveDialog2.filename = '' then exit;

            assignFile (arq, saveDialog2.filename);
            try
                rewrite (arq);
                ultEnderValido := 0;
                for i := $FFFF downto 1 do
                    if memoria[i] <> 0 then
                        begin
                            ultEnderValido := i;
                            break;
                        end;

                for i := 0 to ultEnderValido do
                    begin
                        write (arq, intToHex (memoria[i], 2));
                        if (i mod 8) = 7 then writeln (arq);
                    end;
                writeln (arq);
            finally
                closefile (arq);
            end;
        end;
end;

procedure TformPrincipal.AbrirLingMquina1Click(Sender: TObject);
var
    arq: textFile;
    x, s: string;
    ender: integer;
begin
    b_pararClick(Sender);

    if openDialog2.execute then
        begin
            assignFile (arq, openDialog2.filename);
            try
                reset (arq);
                ender := 0;
                while not eof (arq) do
                    begin
                        readln (arq, s);
                        trim (s);
                        while s <> '' do
                            begin
                                x := copy (s, 1, 2);
                                delete (s, 1, 2);
                                memoria [ender] := hexToInt (x);
                                ender := ender + 1;
                            end;
                    end;
            finally
                closefile (arq);
            end;
        end;

    atualizaInterface;
end;

procedure TformPrincipal.preparaDebug;
var i: integer;
    l, lu: string;
begin
    lb_instrucoes.clear;

    for i := 0 to listagem.Count-1 do
            begin
                l := trim (listagem[i]);
                if copy (l, 1, 8)  = SListagem then break; //cuidado com a traducao desse SListagem

                if copy (l, 5, 99) = '' then continue;
                if not (l[1] in ['0'..'9']) then continue;
                if copy (l, 6, 10) = '          ' then continue;

                lu := uppercase (l);
                if (pos (' DB ', lu) <> 0) or
                   (pos (':DB ', lu) <> 0) or
                   (pos (' DS ', lu) <> 0) or
                   (pos (':DS ', lu) <> 0) or
                   (pos (' STR ', lu) <> 0) or
                   (pos (':STR ', lu) <> 0) then  continue;

                lb_instrucoes.Items.add(listagem[i]);
            end;
end;

procedure TformPrincipal.atualizaDebug (PC: integer);
var
    spc, l: string;
    i: integer;
begin
    //modified to support breakpoint in fastmode
    if cb_rapido.Checked = true then
    begin
      spc := intToHex (PC, 4);
      for i := 0 to lb_instrucoes.Count-1 do
      begin
        l := lb_instrucoes.Items[i];
        if copy (l, 8, 4) = spc then
        begin
          ExecutingLine := i;
          exit;
        end;
      end;
      lb_instrucoes.ItemIndex := -1;
    end

    else

    begin
      spc := intToHex (PC, 4);
      for i := 0 to lb_instrucoes.Count-1 do
      begin
        l := lb_instrucoes.Items[i];
        if copy (l, 8, 4) = spc then
        begin
          lb_instrucoes.ItemIndex := i;
          ExecutingLine :=i;
          exit;
        end;
      end;
    end;
end;

procedure TformPrincipal.atualizaDados (zerando: boolean);
var n, m: integer;
    s: string;
    b, b2: byte;
    w: integer;
begin
    if not zerando then   { para compatibilidade com Lazarus em Linux}
        while lb_dados.Items.Count < ndebugDados do
            lb_dados.Items.add (' ');

    for n := 0 to ndebugDados-1 do
        with debugDados[n] do
        begin
            s := intToHex (ender, 4) + ' ' +
                 copy (nome+ '         ', 1, 10) + ' ';

            case tipo of
                'S': begin
                         s := s + '"';
                         for m := 0 to nposd-1 do
                             begin
                                 b := memoria[ender+m and WORD_MASK];
                                 case ord(b) of
                                      $00: s := s + '\0';
                                      $09: s := s + '\t';
                                      $0a: s := s + '\n';
                                      $0c: s := s + '\f';
                                      $0d: s := s + '\r';
                                else
                                      s := s + chr(b);
                                end;
                             end;
                         s := s + '"';
                     end;

                'B': begin
                         for m := 0 to nposd-1 do
                             begin
                                 b := memoria[ender+m and WORD_MASK];
                                 s := s + intToHex(b,2)+'['+intToStr(b)+']'+ ' ';
                             end;
                     end;

                'W': begin
                         for m := 0 to nposd-1 do
                             begin
                                 b  := memoria[(ender+m*2) and WORD_MASK];
                                 b2 := memoria[(ender+m*2+1) and WORD_MASK];
                                 w := b or (b2 shl 8);
                                 s := s + intToHex(w,4)+'['+intToStr(w)+']'+ ' ';
                             end;
                     end;
            end;

            if zerando then
                lb_dados.Items.Add (s)
            else
                lb_dados.Items[n] := s;
        end;
end;

procedure TformPrincipal.atualizaListagem;
var i: integer;
begin
    m_listagem.Clear;
    for i := 0 to listagem.count-1 do
         m_listagem.Lines.add (listagem[i]);
    Codigo.ActivePage := Compilacao;
end;

procedure TformPrincipal.Compilar1Click(Sender: TObject);
begin
    b_resetClick(Sender);
    zeraMemoria;
    lb_dados.Clear;

    compila (nomeArq);

    atualizaListagem;
    preparaDebug;
    atualizaInterface;
end;

procedure TformPrincipal.b_zeraClick(Sender: TObject);
begin
    keyStatusReg := 0;
    atualizaInterface;
end;

procedure TformPrincipal.b_ZClick(Sender: TObject);
var s: string;
begin
    running := false;
    atualizaLeds;
    s := boolToStr (ALU_Z);
    if s[1] = '-' then delete (s, 1, 1);
    l_Z.caption := s;
    if inputQuery (SInforme, SNovoValorDoFlagZ, s) then
        ALU_Z := s = '1';
    atualizaInterface;
end;

procedure TformPrincipal.b_NClick(Sender: TObject);
var s: string;
begin
    running := false;
    atualizaLeds;
    s := boolToStr (ALU_N);
    if s[1] = '-' then delete (s, 1, 1);
    l_N.caption := s;
    if inputQuery (SInforme, SNovoValorDoFlagN, s) then
        ALU_N := s = '1';
    atualizaInterface;
end;

procedure TformPrincipal.b_CClick(Sender: TObject);
var s: string;
begin
    running := false;
    atualizaLeds;
    s := boolToStr (ALU_C);
    if s[1] = '-' then delete (s, 1, 1);
    l_C.caption := s;
    if inputQuery (SInforme, SNovoValorDoFlagC, s) then
        ALU_C := s = '1';
    atualizaInterface;
end;

procedure TformPrincipal.click_desliga(Sender: TObject);
var b: integer;
begin
    b := (sender as TSpeedButton).tag;
    keyReg := keyReg and (not b);
    l_teclado.caption := intToHex (keyReg, 2);
    case b of
        128:  ch128off.Visible := true;
        64:   ch64off.Visible  := true;
        32:   ch32off.Visible  := true;
        16:   ch16off.Visible  := true;
        8:    ch8off.Visible   := true;
        4:    ch4off.Visible   := true;
        2:    ch2off.Visible   := true;
        1:    ch1off.Visible   := true;
    end;

    case b of
        128:  ch128on.Visible := false;
        64:   ch64on.Visible  := false;
        32:   ch32on.Visible  := false;
        16:   ch16on.Visible  := false;
        8:    ch8on.Visible   := false;
        4:    ch4on.Visible   := false;
        2:    ch2on.Visible   := false;
        1:    ch1on.Visible   := false;
    end;
end;

procedure TformPrincipal.click_liga(Sender: TObject);
var b: integer;
begin
    b := (sender as TSpeedButton).tag;
    keyReg := keyReg or b;
    l_teclado.caption := intToHex (keyReg, 2);
    case b of
        128:  ch128off.Visible := false;
        64:   ch64off.Visible  := false;
        32:   ch32off.Visible  := false;
        16:   ch16off.Visible  := false;
        8:    ch8off.Visible   := false;
        4:    ch4off.Visible   := false;
        2:    ch2off.Visible   := false;
        1:    ch1off.Visible   := false;
    end;

    case b of
        128:  ch128on.Visible := true;
        64:   ch64on.Visible  := true;
        32:   ch32on.Visible  := true;
        16:   ch16on.Visible  := true;
        8:    ch8on.Visible   := true;
        4:    ch4on.Visible   := true;
        2:    ch2on.Visible   := true;
        1:    ch1on.Visible   := true;
    end;
end;

procedure TformPrincipal.cb_rapidoClick(Sender: TObject);
begin
    execucaoRapida := (Sender as TCheckBox).checked;
    if execucaoRapida = true then
        TimerDeExecucao.Interval:=10
    else
        TimerDeExecucao.Interval:=100;
end;

procedure TformPrincipal.Zerarmemria1Click(Sender: TObject);
begin
   zeraMemoria;
   atualizaInterface;
   dumpmem.Selected[0] := true;
end;

procedure TformPrincipal.CutBtnClick(Sender: TObject);
begin
    SynEditor.CutToClipboard;
end;

procedure TformPrincipal.CopyBtnClick(Sender: TObject);
begin
    SynEditor.CopyToClipboard;
end;

procedure TformPrincipal.PasteBtnClick(Sender: TObject);
begin
    SynEditor.PasteFromClipboard;
end;

procedure TformPrincipal.Desfazer1Click(Sender: TObject);
begin
    SynEditor.Undo;

end;

procedure TformPrincipal.Ajuda2Click(Sender: TObject);
begin
{$IFnDEF FPC}
    shellExecute (handle, 'OPEN', 'simus.chm', NIL, '.', SW_SHOW);
{$ELSE}
    OpenDocument('simus.chm'); { *Converted from ShellExecute* }
{$ENDIF}
end;

procedure TformPrincipal.editorKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_F5 then
        Compilar1Click(Sender)
    else
    if Key = VK_F7 then
        b_passoAPassoClick(Sender)
    else
    if Key = VK_F9 then
        b_executarClick(Sender)
    else
    if Key = VK_CONTROL then
        controlKeyPressed:= false;
end;

procedure TformPrincipal.Console1Click(Sender: TObject);
begin
    formConsole.visible := not formConsole.visible;    
end;

procedure TformPrincipal.cb_hexaClick(Sender: TObject);
begin
    atualizaDados(false);
    atualizaDump;
end;

procedure TformPrincipal.Conversordebases1Click(Sender: TObject);
begin
   formHex.Visible := true;
end;

procedure TformPrincipal.dumpMemClick(Sender: TObject);
begin
    enderAlterado := dumpMem.ItemIndex * 8;
    mostraAlterado (true);
end;

procedure TformPrincipal.b_tecladoClick(Sender: TObject);
begin
    kbdStatusReg := 1;
    kbdReg := ord((Sender as TButton).caption[1]);
end;

{----------------------------------------------------------------------}
{                     controle de execução                             }
{----------------------------------------------------------------------}

procedure TformPrincipal.b_resetClick(Sender: TObject);
var salva: string;
begin
    running := false;
    salva := l_teclado.caption;   // não pode mudar o valor das chaves
    inicMaquina (false);
    keyReg := hexToInt (salva);
    kbdReg := 0;
    kbdStatusReg := 0;
    bannerReg := S___Sapiens8;

    PC := PC_Original;
    atualizaInterface;
    dumpMem.TopIndex := 0;
    dumpMem.ItemIndex := 0;

end;

procedure TformPrincipal.b_executarClick(Sender: TObject);
begin
    running := true;
    //verificaa se está em breakpoint, se estiver, executa a proxima instrucao
    if VerificaBreakpoint() = true then
    begin
        executaInstrucao;
    end;
    Codigo.ActivePage:=Execucao;
    atualizaInterface;
    TimerDeExecucao.enabled := true;
    if execucaoRapida then lb_instrucoes.ItemIndex:= -1;
    lb_instrucoes.Repaint;
end;

procedure TformPrincipal.b_pararClick(Sender: TObject);
begin
    running := false;
    atualizaInterface;
end;

procedure TformPrincipal.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if SynEditor.Modified <> false then
        if MessageDlg(SDesejaSalvarAntesDeSair, mtConfirmation, [mbYes, mbNo], 0) = mrNo then
            begin
              exit;
            end
        else
            begin
              if nomeArq <> '' then
                 SaveDialog1.FileName := nomeArq;


              if SaveDialog1.execute then
                  begin
                    nomeArq := SaveDialog1.FileName;
                    if nomeArq <> '' then
                       begin
                         SynEditor.Lines.SaveToFile(nomeArq);
                         caption := nomeArq + S_SimuladorDoProcSapiens8;
                       end;
                  end
              else
                 begin
                   canClose := false;
                 end;
            end;
end;

procedure TformPrincipal.lb_instrucoesDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var
   aColor: TColor;             //Background color
begin
   aColor:=$FFFFFF;

   if BreakpointList.IndexOf(IntToStr(Index)) < 0
     then  aColor:=$FFFFFF
     else  aColor := $0000FF;

    if odSelected in State then
       begin
         if aColor = $0000FF then
         aColor := $FF00FF
      else
         aColor:=$FF0000;  //If item is selected, then blue as background color
       end;

    lb_instrucoes.Canvas.Brush.Color:=aColor;  //Set background color
    lb_instrucoes.Canvas.FillRect(ARect);      //Draw a filled rectangle
    lb_instrucoes.Canvas.TextRect(ARect, 2, ARect.Top, lb_instrucoes.Items[Index]);  //Draw Itemtext

end;

procedure TformPrincipal.lb_instrucoesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_CONTROL then
    controlKeyPressed:= true;

end;

procedure TformPrincipal.lb_instrucoesSelectionChange(Sender: TObject;
  User: boolean);
var
  idx : integer;
  isBreakPoint : integer;
begin
  if(controlKeyPressed = false) then exit;
  idx := 0;
  if User = true then
    begin
      idx := lb_instrucoes.ItemIndex;

      isBreakpoint :=  BreakpointList.IndexOf( IntToStr(idx));

      if  isBreakpoint = -1 then
         BreakpointList.Add(IntToStr(idx))
      else
         BreakpointList.Delete(isBreakPoint);
      lb_instrucoes.Repaint;
    end;
end;

procedure TformPrincipal.TimerDeExecucaoTimer(Sender: TObject);
begin
  Application.ProcessMessages;
  if running then
  begin
    if VerificaBreakpoint() = true then
    begin
      running:= false;
      TimerDeExecucao.Enabled:= false;
      exit;
    end;
    executaInstrucao;
    atualizaInterface;
  end
  else
      TimerDeExecucao.enabled := false;
end;

function TformPrincipal.VerificaBreakpoint() : boolean;
var idx, isBreakpoint : integer;
begin
    isBreakpoint :=  BreakpointList.IndexOf( IntToStr(ExecutingLine));

    if isBreakpoint > -1 then
       begin
         lb_instrucoes.ItemIndex := ExecutingLine;
         VerificaBreakpoint:= true
       end
    else
       VerificaBreakpoint:= false;
end;

end.

