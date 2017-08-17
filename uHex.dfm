object formHex: TformHex
  Left = 287
  Top = 204
  Width = 393
  Height = 171
  Caption = 'Convers'#227'o entre bases'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object l_resposta: TLabel
    Left = 8
    Top = 48
    Width = 24
    Height = 13
    Caption = '0000'
  end
  object Edit1: TEdit
    Left = 8
    Top = 16
    Width = 97
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object Button1: TButton
    Left = 8
    Top = 80
    Width = 97
    Height = 25
    Caption = 'Converter'
    TabOrder = 1
    OnClick = Button1Click
  end
  object GroupBox1: TGroupBox
    Left = 112
    Top = 8
    Width = 113
    Height = 105
    Caption = 'De'
    TabOrder = 2
    object de_binario: TRadioButton
      Left = 16
      Top = 24
      Width = 57
      Height = 17
      Caption = 'Bin'#225'rio'
      TabOrder = 0
    end
    object de_decimal: TRadioButton
      Left = 16
      Top = 48
      Width = 65
      Height = 17
      Caption = 'Decimal'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object de_hexa: TRadioButton
      Left = 16
      Top = 72
      Width = 89
      Height = 17
      Caption = 'Hexadecimal'
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 240
    Top = 8
    Width = 113
    Height = 105
    Caption = 'Para'
    TabOrder = 3
    object para_binario: TRadioButton
      Left = 16
      Top = 24
      Width = 57
      Height = 17
      Caption = 'Bin'#225'rio'
      TabOrder = 0
    end
    object para_decimal: TRadioButton
      Left = 16
      Top = 48
      Width = 65
      Height = 17
      Caption = 'Decimal'
      TabOrder = 1
    end
    object para_hexa: TRadioButton
      Left = 16
      Top = 72
      Width = 89
      Height = 17
      Caption = 'Hexadecimal'
      Checked = True
      TabOrder = 2
      TabStop = True
    end
  end
end
