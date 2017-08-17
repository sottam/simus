object FormConsole: TFormConsole
  Left = 757
  Top = 244
  Width = 508
  Height = 237
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Console'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  Menu = MainMenu1
  OldCreateOrder = False
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object texto: TLabel
    Left = 16
    Top = 8
    Width = 3
    Height = 13
  end
  object MainMenu1: TMainMenu
    Left = 168
    Top = 64
    object Limpar1: TMenuItem
      Caption = 'Limpar'
      OnClick = Limpar1Click
    end
    object Esconder1: TMenuItem
      Caption = 'Esconder'
      OnClick = Esconder1Click
    end
  end
end
