object OreolNWTune1: TOreolNWTune1
  Left = 248
  Top = 103
  Width = 532
  Height = 148
  ActiveControl = Edit1
  Caption = 'OreolNWTune1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefaultPosOnly
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 328
    Height = 114
    Align = alClient
    TabOrder = 0
    object Label2: TLabel
      Left = 16
      Top = 32
      Width = 61
      Height = 13
      Caption = #1050#1086#1084#1087#1100#1102#1090#1077#1088':'
    end
    object Label3: TLabel
      Left = 16
      Top = 64
      Width = 28
      Height = 13
      Caption = #1055#1086#1088#1090':'
    end
    object Edit1: TEdit
      Left = 88
      Top = 24
      Width = 217
      Height = 21
      TabOrder = 0
      Text = '127.0.0.1'
    end
    object Edit2: TEdit
      Left = 88
      Top = 56
      Width = 217
      Height = 21
      TabOrder = 1
      Text = '56000'
    end
  end
  object Panel2: TPanel
    Left = 328
    Top = 0
    Width = 196
    Height = 114
    Align = alRight
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 24
      Top = 16
      Width = 145
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080' '#1079#1072#1082#1088#1099#1090#1100
      Default = True
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 24
      Top = 56
      Width = 145
      Height = 25
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1080' '#1079#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
end
