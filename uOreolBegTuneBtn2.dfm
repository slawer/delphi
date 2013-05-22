object OreolBegTuneBtn2: TOreolBegTuneBtn2
  Left = 264
  Top = 189
  Width = 520
  Height = 187
  Caption = 'OreolBegTuneBtnBtn2'
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
    Width = 320
    Height = 153
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 48
      Width = 141
      Height = 13
      Caption = #1055#1086#1080#1089#1082' '#1092#1072#1081#1083#1072' '#1089' '#1086#1087#1080#1089#1072#1085#1080#1103#1084#1080
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 16
      Width = 153
      Height = 25
      Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080#1081' '#1079#1072#1087#1091#1089#1082
      TabOrder = 0
    end
    object BitBtn3: TBitBtn
      Left = 200
      Top = 40
      Width = 49
      Height = 25
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtn3Click
    end
    object Edit1: TEdit
      Left = 16
      Top = 80
      Width = 281
      Height = 21
      TabOrder = 2
    end
    object CheckBox2: TCheckBox
      Left = 16
      Top = 120
      Width = 234
      Height = 25
      Caption = #1042#1099#1087#1086#1083#1085#1103#1090#1100' '#1074#1089#1077' '#1082#1086#1084#1072#1085#1076#1099' '#1041#1045#1047' '#1074#1086#1087#1088#1086#1089#1086#1074
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 320
    Top = 0
    Width = 192
    Height = 153
    Align = alRight
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 24
      Top = 24
      Width = 145
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080' '#1079#1072#1082#1088#1099#1090#1100
      Default = True
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 24
      Top = 64
      Width = 145
      Height = 25
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1080' '#1079#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
end
