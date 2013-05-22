inherited EditParam: TEditParam
  Left = 298
  Top = 242
  Width = 594
  Height = 417
  Caption = 'EditParam'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 401
    Top = 0
    Width = 185
    Height = 385
    Align = alRight
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 24
      Top = 24
      Width = 137
      Height = 33
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 24
      Top = 72
      Width = 137
      Height = 33
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 401
    Height = 385
    Align = alClient
    TabOrder = 1
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 399
      Height = 383
      ActivePage = TabSheet1
      Align = alClient
      TabIndex = 0
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = #1042#1099#1073#1086#1088' '#1087#1072#1088#1072#1084#1077#1090#1088#1072
        object RadioGroup1: TRadioGroup
          Left = 0
          Top = 0
          Width = 391
          Height = 158
          Align = alTop
          Caption = #1057#1087#1080#1089#1086#1082' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1075#1088#1072#1092#1080#1082#1072
          TabOrder = 0
          OnClick = RadioGroup1Click
        end
        object Panel5: TPanel
          Left = 0
          Top = 158
          Width = 391
          Height = 105
          Align = alTop
          BevelWidth = 3
          TabOrder = 1
          object Label1: TLabel
            Left = 16
            Top = 24
            Width = 126
            Height = 13
            Caption = #1042#1077#1083#1080#1095#1080#1085#1072' '#1090#1072#1081#1084#1072#1091#1090#1072' ('#1057#1077#1082')'
          end
          object Label2: TLabel
            Left = 16
            Top = 64
            Width = 157
            Height = 13
            Caption = #1064#1072#1075' '#1079#1072#1087#1086#1083#1085#1077#1085#1080#1103' '#1075#1088#1072#1092#1080#1082#1072' ('#1057#1077#1082')'
          end
          object Edit1: TEdit
            Left = 200
            Top = 16
            Width = 49
            Height = 21
            TabOrder = 0
            Text = '3'
          end
          object Edit2: TEdit
            Left = 200
            Top = 56
            Width = 49
            Height = 21
            TabOrder = 1
            Text = '1'
          end
        end
        object Panel11: TPanel
          Left = 0
          Top = 263
          Width = 391
          Height = 90
          Align = alTop
          BevelWidth = 3
          TabOrder = 2
          object Label17: TLabel
            Left = 40
            Top = 54
            Width = 153
            Height = 13
            Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1079#1072#1096#1091#1084#1083#1077#1085#1080#1103' (%)'
          end
          object Edit5: TEdit
            Left = 208
            Top = 48
            Width = 41
            Height = 21
            TabOrder = 1
            Text = '1.5'
          end
          object CheckBox1: TCheckBox
            Left = 32
            Top = 16
            Width = 249
            Height = 17
            Caption = #1042#1085#1077#1089#1077#1085#1085#1080#1077' '#1074' '#1076#1072#1085#1085#1099#1077' '#1096#1091#1084#1072' (% '#1086#1090' '#1079#1085#1072#1095#1077#1085#1080#1103')'
            TabOrder = 0
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1088#1072#1079#1088#1099#1074
        ImageIndex = 1
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 391
          Height = 59
          Align = alTop
          BevelWidth = 3
          TabOrder = 0
          object RadioButton1: TRadioButton
            Left = 16
            Top = 16
            Width = 313
            Height = 25
            Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' "'#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080'" '#1079#1085#1072#1095#1077#1085#1080#1103' '#1085#1072' '#1075#1088#1072#1085#1080#1094#1072#1093
            Checked = True
            TabOrder = 0
            TabStop = True
          end
        end
        object Panel4: TPanel
          Left = 0
          Top = 59
          Width = 391
          Height = 80
          Align = alTop
          BevelWidth = 3
          TabOrder = 1
          object Label5: TLabel
            Left = 8
            Top = 8
            Width = 121
            Height = 13
            Caption = #1052#1077#1090#1086#1076' '#1074#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1103':'
          end
          object RadioButton3: TRadioButton
            Left = 16
            Top = 32
            Width = 225
            Height = 25
            Caption = #1051#1080#1085#1077#1081#1085#1072#1103' '#1072#1087#1087#1088#1086#1082#1089#1080#1084#1072#1094#1080#1103' '#1076#1072#1085#1085#1099#1093
            Checked = True
            TabOrder = 0
            TabStop = True
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = #1056#1077#1089#1090#1072#1074#1088#1072#1094#1080#1103' '#1087#1083#1086#1090#1085#1086#1089#1090#1080
        ImageIndex = 2
        object Panel6: TPanel
          Left = 0
          Top = 0
          Width = 391
          Height = 153
          Align = alTop
          BevelWidth = 3
          TabOrder = 0
          object Label7: TLabel
            Left = 8
            Top = 96
            Width = 209
            Height = 13
            Caption = #1047#1085#1072#1095#1077#1085#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1072' '#1074' '#1085#1072#1095#1072#1083#1077' '#1080#1085#1090#1077#1088#1074#1072#1083#1072
          end
          object Label8: TLabel
            Left = 8
            Top = 128
            Width = 204
            Height = 13
            Caption = #1047#1085#1072#1095#1077#1085#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1072' '#1074' '#1082#1086#1085#1094#1077' '#1080#1085#1090#1077#1088#1074#1072#1083#1072
          end
          object RadioButton4: TRadioButton
            Left = 16
            Top = 16
            Width = 353
            Height = 25
            Caption = #1056#1077#1089#1090#1072#1074#1088#1080#1088#1086#1074#1080#1090#1100' '#1089' "'#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080#1084#1080'" '#1079#1085#1072#1095#1077#1085#1080#1103#1084#1080' '#1085#1072' '#1075#1088#1072#1085#1080#1094#1072#1093
            Checked = True
            TabOrder = 0
            TabStop = True
            OnClick = RadioButton4Click
          end
          object RadioButton5: TRadioButton
            Left = 16
            Top = 56
            Width = 337
            Height = 25
            Caption = #1056#1077#1089#1090#1072#1074#1088#1080#1088#1086#1074#1080#1090#1100' '#1089' '#1091#1095#1105#1090#1086#1084' '#1079#1072#1076#1072#1085#1085#1099#1093' '#1079#1085#1072#1095#1077#1085#1080#1081' '#1085#1072' '#1075#1088#1072#1085#1080#1094#1072#1093':'
            TabOrder = 1
            OnClick = RadioButton5Click
          end
          object Edit6: TEdit
            Left = 232
            Top = 88
            Width = 129
            Height = 21
            TabOrder = 2
            Text = '0'
          end
          object Edit7: TEdit
            Left = 232
            Top = 120
            Width = 129
            Height = 21
            TabOrder = 3
            Text = '0'
          end
        end
        object Panel7: TPanel
          Left = 0
          Top = 153
          Width = 391
          Height = 80
          Align = alTop
          BevelWidth = 3
          TabOrder = 1
          object Label9: TLabel
            Left = 8
            Top = 8
            Width = 121
            Height = 13
            Caption = #1052#1077#1090#1086#1076' '#1074#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1103':'
          end
          object RadioButton6: TRadioButton
            Left = 16
            Top = 32
            Width = 225
            Height = 25
            Caption = #1051#1080#1085#1077#1081#1085#1072#1103' '#1072#1087#1087#1088#1086#1082#1089#1080#1084#1072#1094#1080#1103' '#1076#1072#1085#1085#1099#1093
            Checked = True
            TabOrder = 0
            TabStop = True
          end
        end
      end
      object TabSheet4: TTabSheet
        Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1103
        ImageIndex = 3
        object Panel8: TPanel
          Left = 0
          Top = 0
          Width = 391
          Height = 355
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          DesignSize = (
            391
            355)
          object RadioButton7: TRadioButton
            Left = 16
            Top = 16
            Width = 153
            Height = 25
            Caption = #1053#1086#1088#1084#1072#1083#1080#1079#1072#1094#1080#1103' '#1086#1073#1098#1105#1084#1072
            Checked = True
            TabOrder = 0
            TabStop = True
          end
          object RadioButton8: TRadioButton
            Left = 16
            Top = 48
            Width = 225
            Height = 25
            Caption = #1057#1076#1074#1080#1075' '#1080' '#1084#1072#1089#1096#1090#1072#1073#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1072
            TabOrder = 1
          end
          object Panel9: TPanel
            Left = 0
            Top = 83
            Width = 391
            Height = 94
            Anchors = [akLeft, akTop, akRight]
            BevelWidth = 3
            TabOrder = 2
            object Label11: TLabel
              Left = 24
              Top = 23
              Width = 91
              Height = 13
              Caption = #1057#1076#1074#1080#1075' '#1087#1072#1088#1072#1084#1077#1090#1088#1072':'
            end
            object Label6: TLabel
              Left = 24
              Top = 56
              Width = 119
              Height = 13
              Caption = #1052#1085#1086#1078#1080#1090#1077#1083#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1072':'
            end
            object Edit9: TEdit
              Left = 160
              Top = 16
              Width = 97
              Height = 21
              TabOrder = 0
            end
            object Edit10: TEdit
              Left = 160
              Top = 48
              Width = 97
              Height = 21
              TabOrder = 1
            end
          end
          object RadioButton9: TRadioButton
            Left = 16
            Top = 192
            Width = 249
            Height = 25
            Anchors = [akLeft, akTop, akRight]
            Caption = #1042#1085#1077#1089#1077#1085#1085#1080#1077' '#1074' '#1076#1072#1085#1085#1099#1077' '#1096#1091#1084#1072' (% '#1086#1090' '#1079#1085#1072#1095#1077#1085#1080#1103')'
            TabOrder = 3
          end
        end
      end
    end
  end
end
