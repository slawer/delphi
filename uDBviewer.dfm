object cDBviewer: TcDBviewer
  Left = 493
  Top = 201
  Width = 565
  Height = 340
  Caption = 'DBviewer'
  Color = clBtnFace
  Constraints.MinHeight = 340
  Constraints.MinWidth = 565
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefaultPosOnly
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 179
    Width = 557
    Height = 107
    Align = alClient
    TabOrder = 0
    object Memo1: TMemo
      Left = 1
      Top = 1
      Width = 555
      Height = 105
      Align = alClient
      Lines.Strings = (
        #1055#1088#1086#1090#1086#1082#1086#1083' '#1088#1072#1073#1086#1090#1099' '#1087#1088#1086#1075#1088#1072#1084#1084#1099)
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 557
    Height = 179
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      557
      179)
    object Label1: TLabel
      Left = 18
      Top = 24
      Width = 85
      Height = 13
      Caption = #1052#1077#1089#1090#1086#1088#1086#1078#1076#1077#1085#1080#1077':'
    end
    object Label2: TLabel
      Left = 77
      Top = 56
      Width = 26
      Height = 13
      Caption = #1050#1091#1089#1090':'
    end
    object Label3: TLabel
      Left = 49
      Top = 88
      Width = 54
      Height = 13
      Caption = #1057#1082#1074#1072#1078#1080#1085#1072':'
    end
    object Label4: TLabel
      Left = 57
      Top = 120
      Width = 46
      Height = 13
      Caption = #1047#1072#1076#1072#1085#1080#1077':'
    end
    object Label5: TLabel
      Left = 62
      Top = 152
      Width = 41
      Height = 13
      Caption = #1052#1072#1089#1090#1077#1088':'
    end
    object Edit1: TEdit
      Left = 120
      Top = 16
      Width = 415
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 120
      Top = 48
      Width = 415
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
    object Edit3: TEdit
      Left = 120
      Top = 80
      Width = 415
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
    end
    object Edit4: TEdit
      Left = 120
      Top = 112
      Width = 415
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
    end
    object Edit5: TEdit
      Left = 120
      Top = 144
      Width = 415
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 4
    end
  end
  object MainMenu1: TMainMenu
    Left = 208
    Top = 208
    object N1: TMenuItem
      Caption = '&'#1060#1072#1081#1083
      object N9: TMenuItem
        Action = Action8
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object N6: TMenuItem
        Action = Action4
      end
      object N15: TMenuItem
        Action = Action11
      end
      object N7: TMenuItem
        Action = Action6
      end
      object N17: TMenuItem
        Caption = '-'
      end
      object XLS1: TMenuItem
        Action = Action12
      end
      object LASS1: TMenuItem
        Action = Action15
      end
      object N19: TMenuItem
        Action = Action16
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Action = Action1
        Caption = #1042#1099#1093#1086#1076
      end
    end
    object N2: TMenuItem
      Caption = '&'#1053#1072#1089#1090#1088#1086#1081#1082#1080
      object N5: TMenuItem
        Action = Action2
      end
      object N18: TMenuItem
        Action = Action13
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object N8: TMenuItem
        Action = Action14
      end
      object N10: TMenuItem
        Action = Action3
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object N13: TMenuItem
        Action = Action9
      end
    end
    object N3: TMenuItem
      Action = Action5
    end
    object N14: TMenuItem
      Action = Action10
    end
  end
  object ActionList1: TActionList
    Left = 168
    Top = 208
    object Action1: TAction
      Caption = 'Exit'
      OnExecute = Action1Execute
    end
    object Action2: TAction
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      OnExecute = Action2Execute
    end
    object Action3: TAction
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1041#1044
      OnExecute = Action3Execute
    end
    object Action5: TAction
      Caption = '&'#1063#1090#1077#1085#1080#1077' '#1076#1072#1085#1085#1099#1093' '#1080#1079' '#1041#1044
      OnExecute = Action5Execute
    end
    object Action7: TAction
      Caption = #1047#1072#1087#1088#1086#1089#1080#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074
      OnExecute = Action7Execute
    end
    object Action14: TAction
      Caption = #1053#1072#1089#1090#1088#1086#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1057#1043#1058
      OnExecute = Action14Execute
    end
    object Action4: TAction
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080' '#1087#1077#1095#1072#1090#1100' '#1087#1086#1089#1083#1077#1076#1085#1080#1093' '#1075#1088#1072#1092#1080#1082#1086#1074
      OnExecute = Action4Execute
    end
    object Action6: TAction
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1077#1089#1100' '#1087#1088#1086#1090#1086#1082#1086#1083
      OnExecute = Action6Execute
    end
    object Action8: TAction
      Caption = #1055#1077#1088#1077#1088#1080#1089#1086#1074#1072#1090#1100' '#1075#1088#1072#1092#1080#1082#1080
      OnExecute = Action8Execute
    end
    object Action9: TAction
      Caption = #1053#1072#1089#1090#1088#1086#1080#1090#1100' '#1089#1074#1103#1079#1100' '#1089' '#1041#1044
      OnExecute = Action9Execute
    end
    object Action10: TAction
      Caption = '&'#1045#1078#1077#1076#1085#1077#1074#1085#1099#1081' '#1086#1090#1095#1105#1090
      OnExecute = Action10Execute
    end
    object Action11: TAction
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080' '#1087#1077#1095#1072#1090#1100' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1086#1090#1095#1105#1090#1072
      OnExecute = Action11Execute
    end
    object Action12: TAction
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1074' XLS'
      OnExecute = Action12Execute
    end
    object Action13: TAction
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1091#1089#1083#1086#1074#1080#1103' '#1087#1086#1080#1089#1082#1072
      OnExecute = Action13Execute
    end
    object Action15: TAction
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1074' LASS '#1092#1086#1088#1084#1072#1090
      OnExecute = Action15Execute
    end
    object Action16: TAction
      Caption = #1055#1077#1088#1077#1085#1086#1089' '#1076#1072#1085#1085#1099#1093' '#1080#1079' '#1082#1086#1085#1090#1088#1086#1083#1083#1077#1088#1072
      OnExecute = Action16Execute
    end
    object Action17: TAction
      Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1041#1044' '#1074' '#1076#1086#1087' '#1089#1087#1080#1089#1086#1082
      OnExecute = Action17Execute
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = #1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1103' (*.cfg)|*.cfg|'#1058#1077#1082#1089#1090' (*.txt)|*.txt|'#1042#1089#1077' (*.*)|*.*'
    Left = 88
    Top = 208
  end
  object XMLDocument1: TXMLDocument
    Left = 128
    Top = 208
    DOMVendorDesc = 'MSXML'
  end
  object ADOConnection1: TADOConnection
    Left = 264
    Top = 208
  end
end
