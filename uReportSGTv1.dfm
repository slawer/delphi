object cReportSGTv1: TcReportSGTv1
  Left = 379
  Top = 189
  Width = 565
  Height = 389
  Caption = 'DEPReportSGTv1'
  Color = clBtnFace
  Constraints.MinHeight = 387
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
    Top = 0
    Width = 557
    Height = 335
    Align = alClient
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 230
      Width = 555
      Height = 104
      Align = alClient
      TabOrder = 0
      object Memo1: TMemo
        Left = 1
        Top = 1
        Width = 553
        Height = 102
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 555
      Height = 229
      Align = alTop
      TabOrder = 1
      object Panel3: TPanel
        Left = 1
        Top = 1
        Width = 304
        Height = 227
        Align = alClient
        TabOrder = 0
        DesignSize = (
          304
          227)
        object Label1: TLabel
          Left = 12
          Top = 13
          Width = 54
          Height = 13
          Caption = #1057#1082#1074#1072#1078#1080#1085#1072':'
        end
        object Label2: TLabel
          Left = 40
          Top = 41
          Width = 26
          Height = 13
          Caption = #1050#1091#1089#1090':'
        end
        object Label3: TLabel
          Left = 15
          Top = 69
          Width = 51
          Height = 13
          Caption = #1047#1072#1082#1072#1079#1095#1080#1082':'
        end
        object Label4: TLabel
          Left = 8
          Top = 97
          Width = 58
          Height = 13
          Caption = #1055#1086#1076#1088#1103#1076#1095#1080#1082':'
        end
        object Label11: TLabel
          Left = 25
          Top = 125
          Width = 41
          Height = 13
          Caption = #1052#1072#1089#1090#1077#1088':'
        end
        object Label12: TLabel
          Left = 8
          Top = 152
          Width = 111
          Height = 13
          Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1073#1091#1088#1077#1085#1080#1103':'
        end
        object Label13: TLabel
          Left = 12
          Top = 168
          Width = 32
          Height = 13
          Caption = #1063#1080#1089#1083#1086
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsUnderline]
          ParentFont = False
        end
        object Label14: TLabel
          Left = 59
          Top = 168
          Width = 33
          Height = 13
          Caption = #1052#1077#1089#1103#1094
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsUnderline]
          ParentFont = False
        end
        object Label15: TLabel
          Left = 113
          Top = 168
          Width = 18
          Height = 13
          Caption = #1043#1086#1076
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsUnderline]
          ParentFont = False
        end
        object Edit1: TEdit
          Left = 12
          Top = 189
          Width = 35
          Height = 28
          AutoSize = False
          BevelKind = bkFlat
          TabOrder = 5
        end
        object Edit2: TEdit
          Left = 59
          Top = 189
          Width = 35
          Height = 28
          AutoSize = False
          BevelKind = bkFlat
          TabOrder = 6
        end
        object Edit3: TEdit
          Left = 104
          Top = 189
          Width = 49
          Height = 28
          AutoSize = False
          BevelKind = bkFlat
          TabOrder = 7
        end
        object BitBtn2: TBitBtn
          Left = 168
          Top = 168
          Width = 121
          Height = 49
          Caption = '... '#1076#1072#1090#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          OnClick = BitBtn2Click
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
            003337777777777777F330FFFFFFFFFFF03337F3333FFF3337F330FFFF000FFF
            F03337F33377733337F330FFFFF0FFFFF03337F33337F33337F330FFFF00FFFF
            F03337F33377F33337F330FFFFF0FFFFF03337F33337333337F330FFFFFFFFFF
            F03337FFF3F3F3F3F7F33000F0F0F0F0F0333777F7F7F7F7F7F330F0F000F070
            F03337F7F777F777F7F330F0F0F0F070F03337F7F7373777F7F330F0FF0FF0F0
            F03337F733733737F7F330FFFFFFFF00003337F33333337777F330FFFFFFFF0F
            F03337FFFFFFFF7F373330999999990F033337777777777F733330FFFFFFFF00
            333337FFFFFFFF77333330000000000333333777777777733333}
          NumGlyphs = 2
        end
        object Edit4: TEdit
          Left = 80
          Top = 8
          Width = 214
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
        end
        object Edit9: TEdit
          Left = 80
          Top = 36
          Width = 214
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
        end
        object Edit10: TEdit
          Left = 80
          Top = 64
          Width = 214
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
        end
        object Edit11: TEdit
          Left = 80
          Top = 92
          Width = 214
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 3
        end
        object Edit12: TEdit
          Left = 80
          Top = 120
          Width = 214
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 4
        end
      end
      object Panel5: TPanel
        Left = 305
        Top = 1
        Width = 249
        Height = 227
        Align = alRight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Label5: TLabel
          Left = 11
          Top = 47
          Width = 65
          Height = 13
          Caption = #1044#1072#1090#1072' '#1086#1090#1095#1105#1090#1072':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 36
          Top = 72
          Width = 32
          Height = 13
          Caption = #1063#1080#1089#1083#1086
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsUnderline]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 83
          Top = 72
          Width = 33
          Height = 13
          Caption = #1052#1077#1089#1103#1094
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsUnderline]
          ParentFont = False
        end
        object Label8: TLabel
          Left = 137
          Top = 72
          Width = 18
          Height = 13
          Caption = #1043#1086#1076
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsUnderline]
          ParentFont = False
        end
        object Label9: TLabel
          Left = 64
          Top = 138
          Width = 68
          Height = 13
          Caption = #1053#1072#1095#1072#1083#1086' '#1089#1091#1090#1086#1082
        end
        object Label10: TLabel
          Left = 184
          Top = 138
          Width = 35
          Height = 13
          Caption = '('#1095#1072#1089#1086#1074')'
        end
        object Edit5: TEdit
          Left = 36
          Top = 93
          Width = 35
          Height = 28
          AutoSize = False
          BevelKind = bkFlat
          TabOrder = 0
        end
        object Edit6: TEdit
          Left = 83
          Top = 93
          Width = 35
          Height = 28
          AutoSize = False
          BevelKind = bkFlat
          TabOrder = 1
        end
        object Edit7: TEdit
          Left = 128
          Top = 93
          Width = 49
          Height = 28
          AutoSize = False
          BevelKind = bkFlat
          TabOrder = 2
        end
        object Edit8: TEdit
          Left = 144
          Top = 128
          Width = 33
          Height = 28
          AutoSize = False
          BevelKind = bkFlat
          TabOrder = 3
          Text = '00'
        end
        object BitBtn1: TBitBtn
          Left = 85
          Top = 16
          Width = 157
          Height = 49
          Caption = '... '#1042#1099#1073#1088#1072#1090#1100' '#1076#1072#1090#1091
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnClick = BitBtn1Click
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
            003337777777777777F330FFFFFFFFFFF03337F3333FFF3337F330FFFF000FFF
            F03337F33377733337F330FFFFF0FFFFF03337F33337F33337F330FFFF00FFFF
            F03337F33377F33337F330FFFFF0FFFFF03337F33337333337F330FFFFFFFFFF
            F03337FFF3F3F3F3F7F33000F0F0F0F0F0333777F7F7F7F7F7F330F0F000F070
            F03337F7F777F777F7F330F0F0F0F070F03337F7F7373777F7F330F0FF0FF0F0
            F03337F733733737F7F330FFFFFFFF00003337F33333337777F330FFFFFFFF0F
            F03337FFFFFFFF7F373330999999990F033337777777777F733330FFFFFFFF00
            333337FFFFFFFF77333330000000000333333777777777733333}
          NumGlyphs = 2
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 248
    Top = 248
    object N1: TMenuItem
      Caption = '<'#1060#1072#1081#1083'>'
      object N6: TMenuItem
        Action = Action4
      end
      object N17: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Action = Action1
        Caption = #1042#1099#1093#1086#1076
      end
    end
    object N2: TMenuItem
      Caption = '<'#1057#1077#1088#1074#1080#1089'>'
      object N5: TMenuItem
        Action = Action2
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
    end
    object N3: TMenuItem
      Action = Action5
    end
  end
  object ActionList1: TActionList
    Left = 200
    Top = 256
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
      Caption = '<'#1057#1086#1079#1076#1072#1090#1100' '#1089#1091#1090#1086#1095#1085#1099#1081' '#1086#1090#1095#1105#1090'>'
      OnExecute = Action5Execute
    end
    object Action7: TAction
      Caption = #1047#1072#1087#1088#1086#1089#1080#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074
      OnExecute = Action7Execute
    end
    object Action14: TAction
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1057#1043#1058
      OnExecute = Action14Execute
    end
    object Action4: TAction
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1087#1086#1089#1083#1077#1076#1085#1080#1081' '#1088#1072#1087#1086#1088#1090
      OnExecute = Action4Execute
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = #1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1103' (*.cfg)|*.cfg|'#1058#1077#1082#1089#1090' (*.txt)|*.txt|'#1042#1089#1077' (*.*)|*.*'
    Left = 32
    Top = 272
  end
  object PrintDialog1: TPrintDialog
    Left = 88
    Top = 272
  end
  object XMLDocument1: TXMLDocument
    Left = 152
    Top = 264
    DOMVendorDesc = 'MSXML'
  end
  object ADOConnection1: TADOConnection
    Left = 320
    Top = 256
  end
end
