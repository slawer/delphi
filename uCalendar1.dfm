object cCalendar1: TcCalendar1
  Left = 462
  Top = 293
  BorderStyle = bsSingle
  Caption = #1050#1072#1083#1077#1085#1076#1072#1088#1100
  ClientHeight = 245
  ClientWidth = 340
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 340
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 147
      Top = 18
      Width = 74
      Height = 13
      Caption = #1042#1099#1073#1088#1072#1085#1072' '#1076#1072#1090#1072':'
    end
    object BitBtn3: TBitBtn
      Left = 16
      Top = 8
      Width = 105
      Height = 25
      Caption = #1057#1077#1075#1086#1076#1085#1103' !'
      TabOrder = 0
      OnClick = BitBtn3Click
    end
    object Edit1: TEdit
      Left = 232
      Top = 8
      Width = 89
      Height = 27
      AutoSize = False
      BevelKind = bkFlat
      ReadOnly = True
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 204
    Width = 340
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 32
      Top = 8
      Width = 113
      Height = 25
      Caption = #1055#1088#1080#1085#1103#1090#1100' '#1074#1099#1073#1086#1088
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 208
      Top = 8
      Width = 97
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 41
    Width = 340
    Height = 163
    Align = alClient
    TabOrder = 2
    object MonthCalendar1: TMonthCalendar
      Left = 0
      Top = 0
      Width = 337
      Height = 161
      Date = 40463.6975193056
      TabOrder = 0
      OnClick = MonthCalendar1Click
    end
  end
end
