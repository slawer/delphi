inherited cTransfer1: TcTransfer1
  Left = 444
  Top = 166
  Width = 639
  Height = 500
  Caption = 'ACtransfer1'
  Constraints.MinHeight = 500
  Constraints.MinWidth = 639
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 631
    Height = 49
    Align = alTop
    TabOrder = 0
    DesignSize = (
      631
      49)
    object BitBtn1: TBitBtn
      Left = 16
      Top = 8
      Width = 137
      Height = 33
      Caption = #1055#1077#1088#1077#1085#1077#1089#1090#1080' '#1076#1072#1085#1085#1099#1077'!'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 491
      Top = 8
      Width = 129
      Height = 33
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1086#1082#1085#1086
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 631
    Height = 417
    Align = alClient
    TabOrder = 1
    OnResize = Panel2Resize
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 629
      Height = 415
      ActivePage = TabSheet2
      Align = alClient
      TabIndex = 2
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = #1047#1072#1087#1088#1086#1089
        OnShow = TabSheet1Show
        object Panel6: TPanel
          Left = 0
          Top = 0
          Width = 621
          Height = 387
          Align = alClient
          TabOrder = 0
          object Panel3: TPanel
            Left = 1
            Top = 1
            Width = 223
            Height = 385
            Align = alLeft
            TabOrder = 0
            DesignSize = (
              223
              385)
            object Panel4: TPanel
              Left = 1
              Top = 34
              Width = 221
              Height = 83
              Align = alTop
              TabOrder = 0
              object StringGrid1: TStringGrid
                Left = 1
                Top = 1
                Width = 219
                Height = 81
                Align = alClient
                ColCount = 3
                RowCount = 3
                Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
                ScrollBars = ssNone
                TabOrder = 0
              end
            end
            object Panel10: TPanel
              Left = 1
              Top = 1
              Width = 221
              Height = 33
              Align = alTop
              Caption = #1048#1085#1090#1077#1088#1074#1072#1083' '#1079#1072#1087#1088#1086#1089#1072
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              TabOrder = 1
            end
            object BitBtn9: TBitBtn
              Left = 112
              Top = 317
              Width = 97
              Height = 25
              Anchors = [akRight, akBottom]
              Caption = #1055#1086#1084#1077#1090#1080#1090#1100' '#1074#1089#1105' :>'
              TabOrder = 2
              OnClick = BitBtn9Click
            end
            object BitBtn10: TBitBtn
              Left = 112
              Top = 349
              Width = 97
              Height = 25
              Anchors = [akRight, akBottom]
              Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1074#1089#1105' :>'
              TabOrder = 3
              OnClick = BitBtn10Click
            end
            object Panel9: TPanel
              Left = 1
              Top = 117
              Width = 221
              Height = 140
              Align = alTop
              TabOrder = 4
              object Label9: TLabel
                Left = 8
                Top = 8
                Width = 196
                Height = 13
                Caption = #1048#1084#1103' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093' '#1076#1083#1103' '#1087#1077#1088#1077#1085#1086#1089#1072':'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Edit10: TEdit
                Left = 8
                Top = 32
                Width = 201
                Height = 21
                TabOrder = 0
              end
              object BitBtn11: TBitBtn
                Left = 40
                Top = 64
                Width = 145
                Height = 25
                Caption = #1048#1084#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
                TabOrder = 1
                OnClick = BitBtn11Click
              end
              object CheckBox5: TCheckBox
                Left = 8
                Top = 104
                Width = 201
                Height = 25
                Caption = '('#1072#1074#1090#1086') '#1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1076#1086#1087'. '#1089#1087#1080#1089#1086#1082' '#1041#1044
                TabOrder = 2
              end
            end
          end
          object Panel16: TPanel
            Left = 224
            Top = 1
            Width = 396
            Height = 385
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            object Panel18: TPanel
              Left = 0
              Top = 0
              Width = 396
              Height = 385
              Align = alClient
              TabOrder = 0
              object Panel19: TPanel
                Left = 1
                Top = 1
                Width = 394
                Height = 25
                Align = alTop
                Caption = #1058#1072#1073#1083#1080#1094#1072' '#1089#1086#1093#1088#1072#1085#1105#1085#1085#1099#1093' '#1080#1085#1090#1077#1088#1074#1072#1083#1086#1074
                TabOrder = 0
              end
              object CheckListBox1: TCheckListBox
                Tag = 1
                Left = 1
                Top = 26
                Width = 394
                Height = 358
                OnClickCheck = CheckListBox1ClickCheck
                Align = alClient
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'Courier New'
                Font.Style = []
                ItemHeight = 16
                ParentFont = False
                TabOrder = 1
              end
            end
          end
        end
      end
      object TabSheet4: TTabSheet
        Caption = #1055#1091#1090#1100' '#1082' '#1076#1072#1085#1085#1099#1084' '#1040#1050
        ImageIndex = 3
        OnShow = TabSheet4Show
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 621
          Height = 387
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object Panel8: TPanel
            Left = 0
            Top = 0
            Width = 621
            Height = 113
            Align = alTop
            TabOrder = 0
            DesignSize = (
              621
              113)
            object RadioButton1: TRadioButton
              Left = 8
              Top = 16
              Width = 153
              Height = 25
              Caption = #1052#1077#1089#1090#1086#1087#1086#1083#1086#1078#1077#1085#1080#1077' '#1074' '#1089#1077#1090#1080
              TabOrder = 0
              OnClick = RadioButton1Click
            end
            object RadioButton2: TRadioButton
              Left = 8
              Top = 48
              Width = 161
              Height = 25
              Caption = #1052#1077#1089#1090#1086#1087#1086#1083#1086#1078#1077#1085#1080#1077' '#1074' '#1087#1072#1087#1082#1077':'
              Checked = True
              TabOrder = 1
              TabStop = True
              OnClick = RadioButton2Click
            end
            object Edit1: TEdit
              Left = 8
              Top = 80
              Width = 607
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 2
            end
            object BitBtn5: TBitBtn
              Left = 200
              Top = 16
              Width = 129
              Height = 57
              Caption = #1055#1086#1080#1089#1082' '#1092#1072#1081#1083#1072
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
              OnClick = BitBtn5Click
            end
            object BitBtn3: TBitBtn
              Left = 368
              Top = 16
              Width = 217
              Height = 57
              Caption = #1057#1086#1077#1076#1080#1085#1080#1090#1100#1089#1103' '#1089' '#1092#1072#1081#1083#1086#1084
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              OnClick = BitBtn3Click
            end
          end
          object Panel12: TPanel
            Left = 0
            Top = 113
            Width = 621
            Height = 274
            Align = alClient
            TabOrder = 1
            object Panel13: TPanel
              Left = 1
              Top = 1
              Width = 280
              Height = 272
              Align = alLeft
              TabOrder = 0
              DesignSize = (
                280
                272)
              object Label6: TLabel
                Left = 8
                Top = 132
                Width = 200
                Height = 13
                Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1089#1086#1093#1088#1072#1085#1103#1077#1084#1099#1093'  '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074':'
              end
              object Label5: TLabel
                Left = 78
                Top = 108
                Width = 130
                Height = 13
                Caption = #1057#1084#1077#1097#1077#1085#1080#1077' '#1073#1083#1086#1082#1072' '#1076#1072#1085#1085#1099#1093':'
              end
              object Label4: TLabel
                Left = 37
                Top = 84
                Width = 171
                Height = 13
                Caption = #1057#1084#1077#1097#1077#1085#1080#1077' '#1073#1083#1086#1082#1072' '#1084#1077#1090#1086#1082' '#1074#1088#1077#1084#1077#1085#1080':'
              end
              object Label3: TLabel
                Left = 14
                Top = 60
                Width = 194
                Height = 13
                Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1073#1083#1086#1082#1086#1074' '#1074' '#1086#1073#1083#1072#1089#1090#1080' '#1076#1072#1085#1085#1099#1093':'
              end
              object Label2: TLabel
                Left = 62
                Top = 36
                Width = 146
                Height = 13
                Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1084#1077#1090#1086#1082' '#1074#1088#1077#1084#1077#1085#1080' :'
              end
              object Label1: TLabel
                Left = 133
                Top = 12
                Width = 75
                Height = 13
                Caption = #1056#1072#1079#1084#1077#1088' '#1073#1083#1086#1082#1072':'
              end
              object Label7: TLabel
                Left = 36
                Top = 156
                Width = 172
                Height = 13
                Caption = #1055#1077#1088#1080#1086#1076' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1084#1077#1090#1086#1082' ('#1084#1089#1077#1082'):'
              end
              object Label8: TLabel
                Left = 30
                Top = 180
                Width = 178
                Height = 13
                Caption = #1055#1077#1088#1080#1086#1076' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1076#1072#1085#1085#1099#1093' ('#1084#1089#1077#1082'):'
              end
              object Edit7: TEdit
                Tag = 1
                Left = 212
                Top = 128
                Width = 61
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                ReadOnly = True
                TabOrder = 5
              end
              object Edit6: TEdit
                Tag = 1
                Left = 212
                Top = 104
                Width = 61
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                ReadOnly = True
                TabOrder = 4
              end
              object Edit5: TEdit
                Tag = 1
                Left = 212
                Top = 80
                Width = 61
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                ReadOnly = True
                TabOrder = 3
              end
              object Edit4: TEdit
                Tag = 1
                Left = 212
                Top = 56
                Width = 61
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                BiDiMode = bdLeftToRight
                ParentBiDiMode = False
                ReadOnly = True
                TabOrder = 2
              end
              object Edit3: TEdit
                Tag = 1
                Left = 212
                Top = 32
                Width = 61
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                ReadOnly = True
                TabOrder = 1
              end
              object Edit2: TEdit
                Tag = 1
                Left = 212
                Top = 8
                Width = 61
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                ReadOnly = True
                TabOrder = 0
              end
              object Edit8: TEdit
                Tag = 1
                Left = 212
                Top = 152
                Width = 61
                Height = 21
                TabOrder = 6
              end
              object Edit9: TEdit
                Tag = 1
                Left = 212
                Top = 176
                Width = 61
                Height = 21
                TabOrder = 7
              end
            end
            object Panel14: TPanel
              Left = 281
              Top = 1
              Width = 339
              Height = 272
              Align = alClient
              TabOrder = 1
              object Panel15: TPanel
                Left = 1
                Top = 1
                Width = 337
                Height = 25
                Align = alTop
                Caption = #1058#1072#1073#1083#1080#1094#1072' '#1089#1086#1093#1088#1072#1085#1105#1085#1085#1099#1093' '#1080#1085#1090#1077#1088#1074#1072#1083#1086#1074
                TabOrder = 0
              end
              object StringGrid3: TStringGrid
                Tag = 1
                Left = 1
                Top = 26
                Width = 337
                Height = 245
                Align = alClient
                DefaultColWidth = 43
                RowCount = 2
                ScrollBars = ssVertical
                TabOrder = 1
                RowHeights = (
                  24
                  24)
              end
            end
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = #1058#1072#1073#1083#1080#1094#1072' '#1089#1086#1086#1090#1074#1077#1090#1089#1090#1074#1080#1103
        ImageIndex = 1
        OnShow = TabSheet2Show
        object Panel7: TPanel
          Left = 0
          Top = 0
          Width = 621
          Height = 387
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object Panel20: TPanel
            Left = 368
            Top = 0
            Width = 253
            Height = 387
            Align = alRight
            TabOrder = 0
            object Shape1: TShape
              Left = 8
              Top = 120
              Width = 229
              Height = 7
              Brush.Color = clAqua
              Shape = stEllipse
            end
            object Shape2: TShape
              Left = 8
              Top = 208
              Width = 229
              Height = 7
              Brush.Color = clAqua
              Shape = stEllipse
            end
            object CheckBox1: TCheckBox
              Left = 8
              Top = 16
              Width = 233
              Height = 25
              Caption = #1057#1082#1088#1099#1090#1100' '#1087#1072#1089#1089#1080#1074#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
              TabOrder = 0
              OnClick = CheckBox1Click
            end
            object CheckBox2: TCheckBox
              Left = 8
              Top = 48
              Width = 233
              Height = 25
              Caption = #1057#1082#1088#1099#1090#1100' '#1085#1077' '#1089#1086#1093#1088#1072#1085#1103#1077#1084#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
              TabOrder = 1
              OnClick = CheckBox2Click
            end
            object BitBtn4: TBitBtn
              Left = 32
              Top = 88
              Width = 185
              Height = 25
              Caption = #1056#1072#1079#1088#1077#1096#1080#1090#1100' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
              TabOrder = 2
              OnClick = BitBtn4Click
            end
            object BitBtn6: TBitBtn
              Left = 32
              Top = 224
              Width = 185
              Height = 25
              Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
              TabOrder = 4
              OnClick = BitBtn6Click
            end
            object BitBtn7: TBitBtn
              Left = 32
              Top = 264
              Width = 185
              Height = 25
              Caption = #1054#1090#1084#1077#1085#1080#1090#1100
              TabOrder = 5
              OnClick = BitBtn7Click
            end
            object BitBtn8: TBitBtn
              Left = 56
              Top = 136
              Width = 140
              Height = 25
              Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1090#1088#1086#1082#1091
              TabOrder = 3
              OnClick = BitBtn8Click
            end
          end
          object Panel21: TPanel
            Left = 0
            Top = 0
            Width = 368
            Height = 387
            Align = alClient
            TabOrder = 1
            object StringGrid5: TStringGrid
              Tag = 1
              Left = 1
              Top = 1
              Width = 366
              Height = 385
              Align = alClient
              ColCount = 3
              FixedCols = 2
              RowCount = 2
              TabOrder = 0
            end
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
        ImageIndex = 3
        object CheckBox3: TCheckBox
          Left = 16
          Top = 8
          Width = 265
          Height = 25
          Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1087#1088#1086#1090#1086#1082#1086#1083' '#1087#1077#1088#1077#1085#1086#1089#1072' '#1076#1072#1085#1085#1099#1093' '#1074' '#1041#1044
          TabOrder = 0
        end
        object CheckBox4: TCheckBox
          Left = 16
          Top = 40
          Width = 297
          Height = 25
          Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1087#1088#1086#1090#1086#1082#1086#1083' '#1088#1072#1079#1073#1086#1088#1072' '#1080#1085#1090#1077#1088#1074#1072#1083#1086#1074' '#1074#1088#1077#1084#1105#1085
          TabOrder = 1
        end
      end
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'sd'
    Filter = #1044#1072#1085#1085#1099#1077'|*.sd|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*.*'
    Left = 448
    Top = 56
  end
  object ADOConnection1: TADOConnection
    Left = 384
    Top = 8
  end
end
