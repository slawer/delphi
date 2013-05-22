object OreolClientDB4: TOreolClientDB4
  Left = 404
  Top = 143
  Width = 612
  Height = 564
  Caption = 'Oreol'#1057'lientDB4'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefaultPosOnly
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 604
    Height = 41
    Align = alTop
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 18
      Top = 8
      Width = 157
      Height = 25
      Action = Action5
      Caption = #1055#1088#1080#1089#1090#1091#1087#1080#1090#1100' '#1082' '#1088#1072#1073#1086#1090#1077
      TabOrder = 0
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
        333333333333337FF3333333333333903333333333333377FF33333333333399
        03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
        99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
        99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
        03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
        33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
        33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
        3333777777333333333333333333333333333333333333333333}
      NumGlyphs = 2
    end
    object BitBtn2: TBitBtn
      Left = 191
      Top = 8
      Width = 157
      Height = 25
      Action = Action6
      Caption = #1057#1082#1088#1099#1090#1100' '#1074' '#1087#1072#1085#1077#1083#1080' '#1079#1072#1076#1072#1095
      TabOrder = 1
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300000000
        0EEE333377777777777733330FF00FBFB0EE33337F37733F377733330F0BFB0B
        FB0E33337F73FF73337733330FF000BFBFB033337F377733333733330FFF0BFB
        FBF033337FFF733F333733300000BF0FBFB03FF77777F3733F37000FBFB0F0FB
        0BF077733FF7F7FF7337E0FB00000000BF0077F377777777F377E0BFBFBFBFB0
        F0F077F3333FFFF7F737E0FBFB0000000FF077F3337777777337E0BFBFBFBFB0
        FFF077F3333FFFF73FF7E0FBFB00000F000077FF337777737777E00FBFBFB0FF
        0FF07773FFFFF7337F37003000000FFF0F037737777773337F7333330FFFFFFF
        003333337FFFFFFF773333330000000003333333777777777333}
      NumGlyphs = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 604
    Height = 477
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 602
      Height = 475
      ActivePage = TabSheet1
      Align = alClient
      TabIndex = 0
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = #1055#1088#1086#1090#1086#1082#1086#1083
        object Memo1: TMemo
          Left = 0
          Top = 0
          Width = 594
          Height = 447
          Align = alClient
          Color = clSilver
          Lines.Strings = (
            #1055#1088#1086#1090#1086#1082#1086#1083' '#1088#1072#1073#1086#1090#1099
            '')
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object TabSheet2: TTabSheet
        Caption = #1054#1073#1097#1080#1077' '#1085#1072#1089#1090#1088#1086#1081#1082#1080
        ImageIndex = 1
        object Label4: TLabel
          Left = 16
          Top = 304
          Width = 52
          Height = 13
          Caption = #1055#1088#1086#1090#1086#1082#1086#1083':'
        end
        object Panel3: TPanel
          Left = 8
          Top = 166
          Width = 177
          Height = 119
          BevelWidth = 3
          TabOrder = 0
          object Label2: TLabel
            Left = 16
            Top = 8
            Width = 153
            Height = 13
            Caption = #1055#1086#1082#1072#1079' '#1086#1073#1097#1080#1093' '#1089#1086#1086#1073#1097#1077#1085#1080#1081':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
          end
          object CheckBox1: TCheckBox
            Left = 21
            Top = 27
            Width = 123
            Height = 25
            Caption = #1042#1099#1074#1086#1076' '#1074' '#1086#1082#1085#1086
            TabOrder = 0
          end
          object CheckBox5: TCheckBox
            Left = 21
            Top = 53
            Width = 123
            Height = 25
            Caption = #1042' '#1092#1072#1081#1083' '#1087#1088#1086#1090#1086#1082#1086#1083#1072
            TabOrder = 1
          end
        end
        object Panel4: TPanel
          Left = 184
          Top = 166
          Width = 177
          Height = 119
          BevelWidth = 3
          TabOrder = 1
          object Label3: TLabel
            Left = 16
            Top = 8
            Width = 131
            Height = 13
            Caption = #1044#1080#1072#1075#1085#1086#1089#1090#1080#1082#1072' '#1086#1096#1080#1073#1086#1082':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
          end
          object CheckBox4: TCheckBox
            Left = 21
            Top = 27
            Width = 123
            Height = 25
            Caption = #1042#1099#1074#1086#1076' '#1074' '#1086#1082#1085#1086
            TabOrder = 0
          end
          object CheckBox6: TCheckBox
            Left = 21
            Top = 56
            Width = 121
            Height = 17
            Caption = #1042' '#1092#1072#1081#1083' '#1087#1088#1086#1090#1086#1082#1086#1083#1072
            Checked = True
            Enabled = False
            State = cbChecked
            TabOrder = 1
          end
        end
        object Edit2: TEdit
          Left = 85
          Top = 296
          Width = 498
          Height = 21
          TabOrder = 2
        end
        object BitBtn4: TBitBtn
          Left = 120
          Top = 328
          Width = 145
          Height = 25
          Action = Action7
          Caption = #1055#1091#1090#1100' '#1082' '#1087#1088#1086#1090#1086#1082#1086#1083#1091
          TabOrder = 3
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
            333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
            0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
            07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
            07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
            0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
            33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
            B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
            3BB33773333773333773B333333B3333333B7333333733333337}
          NumGlyphs = 2
        end
        object Panel5: TPanel
          Left = 8
          Top = 13
          Width = 353
          Height = 145
          BevelWidth = 3
          TabOrder = 4
          object Label13: TLabel
            Left = 16
            Top = 8
            Width = 119
            Height = 13
            Caption = #1047#1072#1087#1091#1089#1082' '#1087#1088#1086#1075#1088#1072#1084#1084#1099':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
          end
          object RadioButton1: TRadioButton
            Left = 21
            Top = 27
            Width = 211
            Height = 17
            Caption = #1047#1072#1087#1091#1089#1082' '#1074' '#1076#1080#1072#1083#1086#1075#1077' '#1089' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1084
            Checked = True
            TabOrder = 0
            TabStop = True
          end
          object RadioButton2: TRadioButton
            Left = 21
            Top = 51
            Width = 211
            Height = 17
            Caption = #1047#1072#1087#1091#1089#1082' '#1074' '#1089#1082#1088#1099#1090#1086#1081' '#1092#1086#1088#1084#1077
            TabOrder = 1
          end
          object CheckBox2: TCheckBox
            Left = 19
            Top = 77
            Width = 211
            Height = 17
            Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080' '#1087#1088#1080#1089#1090#1091#1087#1080#1090#1100' '#1082' '#1088#1072#1073#1086#1090#1077
            TabOrder = 2
          end
          object CheckBox3: TCheckBox
            Left = 19
            Top = 104
            Width = 211
            Height = 17
            Caption = #1056#1072#1079#1088#1077#1096#1080#1090#1100' "'#1041#1099#1089#1090#1088#1086#1077'" '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1077
            TabOrder = 3
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1057#1077#1090#1080
        ImageIndex = 2
        object Label1: TLabel
          Left = 13
          Top = 15
          Width = 123
          Height = 13
          Caption = #1053#1086#1084#1077#1088' '#1087#1086#1088#1090#1072' '#1076#1083#1103' '#1089#1074#1103#1079#1080':'
        end
        object Edit1: TEdit
          Left = 171
          Top = 12
          Width = 73
          Height = 21
          TabOrder = 0
          Text = '50'
        end
        object BitBtn3: TBitBtn
          Left = 48
          Top = 48
          Width = 169
          Height = 25
          Action = Action4
          Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#8470' '#1087#1086#1088#1090#1072
          TabOrder = 1
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000333300
            0000377777F3337777770FFFF099990FFFF07FFFF7FFFF7FFFF7000000999900
            00007777777777777777307703399330770337FF7F37F337FF7F300003399330
            000337777337F337777333333339933333333FFFFFF7F33FFFFF000000399300
            0000777777F7F37777770FFFF099990FFFF07FFFF7F7FF7FFFF7000000999900
            00007777777777777777307703399330770337FF7F37F337FF7F300003399330
            0003377773F7FFF77773333330000003333333333777777F3333333330FFFF03
            3333333337FFFF7F333333333000000333333333377777733333333333077033
            33333333337FF7F3333333333300003333333333337777333333}
          NumGlyphs = 2
        end
      end
      object TabSheet4: TTabSheet
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' MS SQL2000'
        ImageIndex = 3
        object Panel6: TPanel
          Left = 8
          Top = 8
          Width = 577
          Height = 177
          BevelWidth = 3
          TabOrder = 0
          object Label8: TLabel
            Left = 33
            Top = 84
            Width = 99
            Height = 13
            Caption = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label9: TLabel
            Left = 17
            Top = 116
            Width = 115
            Height = 13
            Caption = #1055#1072#1088#1086#1083#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label11: TLabel
            Left = 16
            Top = 8
            Width = 376
            Height = 13
            Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1087#1086#1089#1086#1073#1072' '#1072#1091#1090#1077#1085#1090#1080#1092#1080#1082#1072#1094#1080#1080' '#1074' '#1087#1088#1086#1094#1077#1089#1089#1077' '#1089#1086#1079#1076#1072#1085#1080#1103' '#1041#1044':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
          end
          object Label5: TLabel
            Left = 69
            Top = 148
            Width = 63
            Height = 13
            Caption = 'SQL '#1089#1077#1088#1074#1077#1088':'
          end
          object RadioButton5: TRadioButton
            Left = 21
            Top = 32
            Width = 217
            Height = 17
            Caption = #1055#1086' '#1091#1095#1105#1090#1085#1086#1081' '#1079#1072#1087#1080#1089#1080' Windows'
            Checked = True
            TabOrder = 0
            TabStop = True
            OnClick = RadioButton5Click
          end
          object RadioButton6: TRadioButton
            Left = 21
            Top = 56
            Width = 228
            Height = 17
            Caption = #1059#1082#1072#1079#1072#1090#1100' '#1080#1084#1103', '#1087#1072#1088#1086#1083#1100' '#1076#1083#1103' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103':'
            TabOrder = 1
            OnClick = RadioButton6Click
          end
          object Edit3: TEdit
            Left = 144
            Top = 76
            Width = 121
            Height = 21
            Enabled = False
            TabOrder = 2
          end
          object Edit5: TEdit
            Left = 144
            Top = 108
            Width = 121
            Height = 21
            Enabled = False
            PasswordChar = '*'
            TabOrder = 3
          end
          object BitBtn5: TBitBtn
            Left = 288
            Top = 88
            Width = 153
            Height = 33
            Action = Action9
            Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1077
            TabOrder = 5
          end
          object Edit4: TEdit
            Left = 144
            Top = 140
            Width = 121
            Height = 21
            TabOrder = 4
          end
          object CheckBox7: TCheckBox
            Left = 288
            Top = 142
            Width = 273
            Height = 17
            Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1089#1077#1088#1074#1077#1088' '#1080#1079' '#1082#1086#1084#1072#1085#1076#1099' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
            TabOrder = 6
          end
        end
        object Panel7: TPanel
          Left = 8
          Top = 192
          Width = 577
          Height = 137
          BevelWidth = 3
          TabOrder = 1
          object Label12: TLabel
            Left = 16
            Top = 8
            Width = 310
            Height = 13
            Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1084#1077#1089#1090#1086#1087#1086#1083#1086#1078#1077#1085#1080#1103' '#1041#1044' '#1080' '#1088#1072#1079#1084#1077#1088#1072' '#1092#1072#1081#1083#1086#1074':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
          end
          object Label6: TLabel
            Left = 52
            Top = 57
            Width = 58
            Height = 13
            Caption = #1048#1084#1103' '#1087#1072#1087#1082#1080':'
          end
          object Label7: TLabel
            Left = 20
            Top = 110
            Width = 143
            Height = 13
            Caption = #1057#1090#1072#1088#1090#1086#1074#1099#1081' '#1088#1072#1079#1084#1077#1088' '#1041#1044' ('#1052#1041'):'
          end
          object RadioButton3: TRadioButton
            Left = 21
            Top = 32
            Width = 351
            Height = 17
            Caption = #1060#1072#1081#1083#1099' '#1089' '#1041#1044' '#1088#1072#1089#1087#1086#1083#1086#1078#1077#1085#1099' '#1074' '#1091#1082#1072#1079#1072#1085#1085#1086#1081' '#1085#1080#1078#1077' '#1087#1072#1087#1082#1077' '#1085#1072' '#1089#1077#1088#1074#1077#1088#1077
            Checked = True
            TabOrder = 0
            TabStop = True
            OnClick = RadioButton3Click
          end
          object RadioButton4: TRadioButton
            Left = 21
            Top = 78
            Width = 257
            Height = 17
            Caption = #1060#1072#1081#1083#1099' '#1089' '#1041#1044' '#1088#1072#1089#1087#1086#1083#1086#1078#1077#1085#1099' '#1074' '#1087#1072#1087#1082#1077' '#1087#1088#1086#1077#1082#1090#1072
            TabOrder = 2
            OnClick = RadioButton4Click
          end
          object Edit6: TEdit
            Left = 118
            Top = 49
            Width = 443
            Height = 21
            TabOrder = 1
          end
          object Edit7: TEdit
            Left = 176
            Top = 103
            Width = 99
            Height = 21
            TabOrder = 3
            Text = '10'
          end
        end
        object Panel8: TPanel
          Left = 8
          Top = 336
          Width = 577
          Height = 97
          BevelWidth = 3
          TabOrder = 2
          object Label10: TLabel
            Left = 16
            Top = 8
            Width = 194
            Height = 13
            Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1085#1086#1074#1086#1075#1086' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
          end
          object Label14: TLabel
            Left = 32
            Top = 40
            Width = 137
            Height = 13
            Caption = #1048#1084#1103' '#1085#1086#1074#1086#1075#1086' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103':'
          end
          object Label15: TLabel
            Left = 16
            Top = 72
            Width = 153
            Height = 13
            Caption = #1055#1072#1088#1086#1083#1100' '#1085#1086#1074#1086#1075#1086' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103':'
          end
          object Edit8: TEdit
            Left = 184
            Top = 32
            Width = 121
            Height = 21
            TabOrder = 0
          end
          object Edit9: TEdit
            Left = 184
            Top = 64
            Width = 121
            Height = 21
            PasswordChar = '*'
            TabOrder = 1
          end
          object BitBtn6: TBitBtn
            Left = 328
            Top = 48
            Width = 153
            Height = 33
            Action = Action10
            Caption = #1057#1086#1079#1076#1072#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
            TabOrder = 2
          end
        end
      end
    end
  end
  object ADOConnection1: TADOConnection
    CursorLocation = clUseServer
    LoginPrompt = False
    Left = 456
    Top = 8
  end
  object ADOQuery1: TADOQuery
    AutoCalcFields = False
    CacheSize = 10000
    Connection = ADOConnection1
    CursorLocation = clUseServer
    CursorType = ctOpenForwardOnly
    MarshalOptions = moMarshalModifiedOnly
    EnableBCD = False
    ParamCheck = False
    Parameters = <>
    Left = 356
    Top = 8
  end
  object ActionList1: TActionList
    Left = 424
    Top = 8
    object Action1: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1087#1088#1086#1090#1086#1082#1086#1083
      OnExecute = Action1Execute
    end
    object Action2: TAction
      Caption = #1057#1087#1080#1089#1086#1082' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1081
      OnExecute = Action2Execute
    end
    object Action3: TAction
      Caption = #1042#1099#1093#1086#1076
      OnExecute = Action3Execute
    end
    object Action4: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#8470' '#1087#1086#1088#1090#1072
      OnExecute = Action4Execute
    end
    object Action5: TAction
      Caption = #1055#1088#1080#1089#1090#1091#1087#1080#1090#1100' '#1082' '#1088#1072#1073#1086#1090#1077
      OnExecute = Action5Execute
    end
    object Action6: TAction
      Caption = #1057#1082#1088#1099#1090#1100' '#1074' '#1087#1072#1085#1077#1083#1080' '#1079#1072#1076#1072#1095
      OnExecute = Action6Execute
    end
    object Action7: TAction
      Caption = #1055#1091#1090#1100' '#1082' '#1087#1088#1086#1090#1086#1082#1086#1083#1091
      OnExecute = Action7Execute
    end
    object Action8: TAction
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1087#1088#1086#1090#1086#1082#1086#1083
      OnExecute = Action8Execute
    end
    object Action9: TAction
      Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1077
      OnExecute = Action9Execute
    end
    object Action10: TAction
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      OnExecute = Action10Execute
    end
  end
  object MainMenu1: TMainMenu
    Left = 392
    Top = 8
    object N1: TMenuItem
      Caption = #1057#1077#1088#1074#1080#1089
      object N3: TMenuItem
        Action = Action1
      end
      object N4: TMenuItem
        Action = Action2
      end
      object N5: TMenuItem
        Action = Action4
      end
      object N6: TMenuItem
        Action = Action5
      end
      object N7: TMenuItem
        Action = Action6
      end
    end
    object N2: TMenuItem
      Action = Action3
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer1Timer
    Left = 488
    Top = 8
  end
  object SQLConnection1: TSQLConnection
    LoginPrompt = False
    Left = 520
    Top = 8
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'txt'
    FileName = #1087#1088#1086#1090#1086#1082#1086#1083
    Filter = #1058#1077#1082#1089#1090#1099'|*.txt|'#1042#1089#1077'|*.*'
    Left = 552
    Top = 8
  end
end
