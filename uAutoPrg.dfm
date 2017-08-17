object formAutoMonta: TformAutoMonta
  Left = 424
  Top = 160
  Width = 440
  Height = 510
  Caption = 'Cria'#231#227'o tutorada de programas'
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 184
    Top = 16
    Width = 51
    Height = 13
    Caption = 'Descri'#231#227'o:'
  end
  object l_descricao: TLabel
    Left = 192
    Top = 40
    Width = 209
    Height = 121
    AutoSize = False
    WordWrap = True
  end
  object l_operando: TLabel
    Left = 336
    Top = 176
    Width = 47
    Height = 13
    Caption = 'Operando'
  end
  object TLabel
    Left = 192
    Top = 360
    Width = 123
    Height = 13
    Caption = 'Coment'#225'rios do comando:'
  end
  object l_instr: TLabel
    Left = 371
    Top = 8
    Width = 37
    Height = 20
    Alignment = taRightJustify
    Caption = 'NOP'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object l_rotulo: TLabel
    Left = 184
    Top = 176
    Width = 31
    Height = 13
    Caption = 'R'#243'tulo'
  end
  object b_nop: TButton
    Left = 16
    Top = 16
    Width = 75
    Height = 25
    Caption = 'NOP'
    TabOrder = 0
    OnClick = b_nopClick
  end
  object b_sta: TButton
    Left = 16
    Top = 79
    Width = 75
    Height = 24
    Caption = 'STA'
    TabOrder = 2
    OnClick = b_staClick
  end
  object b_lda: TButton
    Left = 16
    Top = 103
    Width = 75
    Height = 24
    Caption = 'LDA'
    TabOrder = 3
    OnClick = b_ldaClick
  end
  object b_add: TButton
    Left = 16
    Top = 143
    Width = 75
    Height = 24
    Caption = 'ADD'
    TabOrder = 4
    OnClick = b_addClick
  end
  object b_trap: TButton
    Left = 96
    Top = 64
    Width = 75
    Height = 24
    Caption = 'TRAP'
    TabOrder = 17
    OnClick = b_trapClick
  end
  object b_jn: TButton
    Left = 96
    Top = 120
    Width = 75
    Height = 24
    Caption = 'JN'
    TabOrder = 19
    OnClick = b_jnClick
  end
  object b_jz: TButton
    Left = 96
    Top = 144
    Width = 75
    Height = 24
    Caption = 'JZ'
    TabOrder = 20
    OnClick = b_jzClick
  end
  object b_in: TButton
    Left = 96
    Top = 16
    Width = 75
    Height = 24
    Caption = 'IN'
    TabOrder = 15
    OnClick = b_inClick
  end
  object b_out: TButton
    Left = 96
    Top = 40
    Width = 75
    Height = 24
    Caption = 'OUT'
    TabOrder = 16
    OnClick = b_outClick
  end
  object b_jnz: TButton
    Left = 96
    Top = 168
    Width = 75
    Height = 24
    Caption = 'JNZ'
    TabOrder = 21
    OnClick = b_jnzClick
  end
  object b_hlt: TButton
    Left = 16
    Top = 41
    Width = 75
    Height = 24
    Caption = 'HLT'
    TabOrder = 1
    OnClick = b_hltClick
  end
  object e_operando: TEdit
    Left = 336
    Top = 192
    Width = 73
    Height = 21
    TabOrder = 41
  end
  object b_incluir: TButton
    Left = 216
    Top = 416
    Width = 161
    Height = 41
    Caption = 'Incluir no programa fonte'
    TabOrder = 43
    OnClick = b_incluirClick
  end
  object b_org: TButton
    Left = 216
    Top = 248
    Width = 75
    Height = 24
    Caption = 'ORG'
    TabOrder = 30
    OnClick = b_orgClick
  end
  object b_equ: TButton
    Left = 216
    Top = 273
    Width = 75
    Height = 24
    Caption = 'EQU'
    TabOrder = 31
    OnClick = b_equClick
  end
  object b_end: TButton
    Left = 216
    Top = 298
    Width = 75
    Height = 24
    Caption = 'END'
    TabOrder = 32
    OnClick = b_endClick
  end
  object b_ds: TButton
    Left = 296
    Top = 248
    Width = 75
    Height = 24
    Caption = 'DS'
    TabOrder = 34
    OnClick = b_dsClick
  end
  object b_db: TButton
    Left = 296
    Top = 273
    Width = 75
    Height = 24
    Caption = 'DB'
    TabOrder = 35
    OnClick = b_dbClick
  end
  object e_comentario: TEdit
    Left = 192
    Top = 376
    Width = 217
    Height = 21
    TabOrder = 42
  end
  object b_coment: TButton
    Left = 296
    Top = 323
    Width = 75
    Height = 24
    Caption = 'Coment'#225'rios'
    TabOrder = 37
    OnClick = b_comentClick
  end
  object b_rotulo: TButton
    Left = 216
    Top = 323
    Width = 75
    Height = 24
    Caption = 'R'#243'tulo'
    TabOrder = 33
    OnClick = b_rotuloClick
  end
  object c_indireto: TCheckBox
    Left = 264
    Top = 208
    Width = 65
    Height = 17
    Caption = 'Indireto'
    TabOrder = 40
    OnClick = c_indiretoClick
  end
  object e_rotulo: TEdit
    Left = 184
    Top = 192
    Width = 57
    Height = 21
    TabOrder = 38
  end
  object b_or: TButton
    Left = 16
    Top = 300
    Width = 75
    Height = 24
    Caption = 'OR'
    TabOrder = 10
    OnClick = b_orClick
  end
  object b_and: TButton
    Left = 16
    Top = 276
    Width = 75
    Height = 24
    Caption = 'AND'
    TabOrder = 9
    OnClick = b_andClick
  end
  object b_not: TButton
    Left = 16
    Top = 252
    Width = 75
    Height = 24
    Caption = 'NOT'
    TabOrder = 8
    OnClick = b_notClick
  end
  object b_sts: TButton
    Left = 96
    Top = 253
    Width = 75
    Height = 24
    Caption = 'STS'
    TabOrder = 24
    OnClick = b_stsClick
  end
  object b_lds: TButton
    Left = 96
    Top = 277
    Width = 75
    Height = 24
    Caption = 'LDS'
    TabOrder = 25
    OnClick = b_ldsClick
  end
  object b_push: TButton
    Left = 96
    Top = 363
    Width = 75
    Height = 24
    Caption = 'PUSH'
    TabOrder = 28
    OnClick = b_pushClick
  end
  object b_pop: TButton
    Left = 96
    Top = 387
    Width = 75
    Height = 24
    Caption = 'POP'
    TabOrder = 29
    OnClick = b_popClick
  end
  object b_adc: TButton
    Left = 16
    Top = 167
    Width = 75
    Height = 24
    Caption = 'ADC'
    TabOrder = 5
    OnClick = b_adcClick
  end
  object b_sbc: TButton
    Left = 16
    Top = 215
    Width = 75
    Height = 24
    Caption = 'SBC'
    TabOrder = 7
    OnClick = b_sbcClick
  end
  object b_sub: TButton
    Left = 16
    Top = 191
    Width = 75
    Height = 24
    Caption = 'SUB'
    TabOrder = 6
    OnClick = b_subClick
  end
  object b_xor: TButton
    Left = 16
    Top = 324
    Width = 75
    Height = 24
    Caption = 'XOR'
    TabOrder = 11
    OnClick = b_xorClick
  end
  object b_shr: TButton
    Left = 16
    Top = 385
    Width = 75
    Height = 24
    Caption = 'SHR'
    TabOrder = 13
    OnClick = b_shrClick
  end
  object b_shl: TButton
    Left = 16
    Top = 361
    Width = 75
    Height = 24
    Caption = 'SHL'
    TabOrder = 12
    OnClick = b_shlClick
  end
  object b_sra: TButton
    Left = 16
    Top = 409
    Width = 75
    Height = 24
    Caption = 'SRA'
    TabOrder = 14
    OnClick = b_sraClick
  end
  object b_jc: TButton
    Left = 96
    Top = 192
    Width = 75
    Height = 24
    Caption = 'JC'
    TabOrder = 22
    OnClick = b_jcClick
  end
  object b_jnc: TButton
    Left = 96
    Top = 216
    Width = 75
    Height = 24
    Caption = 'JNC'
    TabOrder = 23
    OnClick = b_jncClick
  end
  object b_jmp: TButton
    Left = 96
    Top = 96
    Width = 75
    Height = 24
    Caption = 'JMP'
    TabOrder = 18
    OnClick = b_jmpClick
  end
  object b_jsr: TButton
    Left = 96
    Top = 301
    Width = 75
    Height = 24
    Caption = 'JSR'
    TabOrder = 26
    OnClick = b_jsrClick
  end
  object b_ret: TButton
    Left = 96
    Top = 325
    Width = 75
    Height = 24
    Caption = 'RET'
    TabOrder = 27
    OnClick = b_retClick
  end
  object b_dw: TButton
    Left = 296
    Top = 298
    Width = 75
    Height = 24
    Caption = 'DW'
    TabOrder = 36
    OnClick = b_dbClick
  end
  object c_imediato: TCheckBox
    Left = 264
    Top = 184
    Width = 65
    Height = 17
    Caption = 'Imediato'
    TabOrder = 39
    OnClick = c_imediatoClick
  end
end
