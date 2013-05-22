inherited cDBviewer_TuneDB: TcDBviewer_TuneDB
  Left = 331
  Top = 305
  Width = 539
  Height = 299
  Caption = 'DBviewer_TuneDB'
  Constraints.MinHeight = 299
  Constraints.MinWidth = 539
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel14: TPanel
    Left = 0
    Top = 0
    Width = 346
    Height = 265
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      346
      265)
    object Label7: TLabel
      Left = 8
      Top = 9
      Width = 141
      Height = 13
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1057#1077#1088#1074#1077#1088#1072' '#1041#1044
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 16
      Top = 119
      Width = 122
      Height = 16
      Caption = #1040#1076#1088#1077#1089' '#1089#1077#1088#1074#1077#1088#1072' '#1041#1044':'
    end
    object Label9: TLabel
      Left = 16
      Top = 153
      Width = 169
      Height = 16
      Caption = #1055#1072#1088#1086#1083#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' SA:'
    end
    object Label38: TLabel
      Left = 16
      Top = 237
      Width = 251
      Height = 16
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086#1087#1099#1090#1086#1082' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103' '#1089' '#1041#1044':'
    end
    object Edit1: TEdit
      Left = 152
      Top = 112
      Width = 170
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object BitBtn10: TBitBtn
      Left = 72
      Top = 186
      Width = 204
      Height = 33
      Anchors = [akLeft, akTop, akRight]
      Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1076#1086#1089#1090#1091#1087#1072
      TabOrder = 2
      OnClick = BitBtn10Click
    end
    object Edit2: TEdit
      Left = 192
      Top = 146
      Width = 130
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
    object RadioButton1: TRadioButton
      Left = 24
      Top = 32
      Width = 265
      Height = 25
      Caption = #1040#1076#1088#1077#1089' '#1089#1077#1088#1074#1077#1088#1072' '#1041#1044' '#1080#1079' '#1085#1072#1089#1090#1088#1086#1077#1082' '#1057#1043#1058
      TabOrder = 3
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 24
      Top = 64
      Width = 265
      Height = 25
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1040#1076#1088#1077#1089' '#1089#1077#1088#1074#1077#1088#1072' '#1041#1044':'
      Checked = True
      TabOrder = 4
      TabStop = True
      OnClick = RadioButton2Click
    end
    object Edit3: TEdit
      Left = 288
      Top = 232
      Width = 34
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 5
      Text = '3'
    end
  end
  object Panel1: TPanel
    Left = 346
    Top = 0
    Width = 185
    Height = 265
    Align = alRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 13
      Top = 24
      Width = 160
      Height = 33
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1085#1072#1089#1090#1088#1086#1081#1082#1080
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 13
      Top = 80
      Width = 160
      Height = 33
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1085#1072#1089#1090#1088#1086#1081#1082#1080
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
end
