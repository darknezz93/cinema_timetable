object Form5: TForm5
  Left = 0
  Top = 0
  Caption = 'Edycja'
  ClientHeight = 223
  ClientWidth = 325
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 37
    Top = 23
    Width = 41
    Height = 16
    Caption = 'Tytu'#322':'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 32
    Top = 69
    Width = 61
    Height = 16
    Caption = 'Godzina:'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 37
    Top = 112
    Width = 36
    Height = 16
    Caption = 'Sala:'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 32
    Top = 154
    Width = 67
    Height = 16
    Caption = 'Premiera:'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 112
    Top = 24
    Width = 205
    Height = 21
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 112
    Top = 70
    Width = 205
    Height = 21
    TabOrder = 1
  end
  object Edit3: TEdit
    Left = 112
    Top = 113
    Width = 205
    Height = 21
    TabOrder = 2
  end
  object Edit4: TEdit
    Left = 112
    Top = 155
    Width = 205
    Height = 21
    TabOrder = 3
  end
  object Button1: TButton
    Left = 96
    Top = 182
    Width = 137
    Height = 33
    Caption = 'Zatwierd'#378' zmiany'
    TabOrder = 4
    OnClick = Button1Click
  end
end
