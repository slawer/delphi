inherited cShowREPparam2: TcShowREPparam2
  Left = 350
  Top = 166
  Width = 545
  Height = 205
  Caption = 'cShowREPparam2'
  Constraints.MinHeight = 205
  Constraints.MinWidth = 545
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 360
    Height = 171
    Align = alClient
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 358
      Height = 169
      ActivePage = TabSheet2
      Align = alClient
      TabIndex = 0
      TabOrder = 0
      object TabSheet2: TTabSheet
        Caption = #1055#1091#1090#1080' '#1082' '#1088#1077#1089#1091#1088#1089#1072#1084
        ImageIndex = 1
        DesignSize = (
          350
          141)
        object Label7: TLabel
          Left = 128
          Top = 16
          Width = 114
          Height = 13
          Anchors = [akTop, akRight]
          Caption = #1055#1091#1090#1100' '#1082' '#1086#1087#1080#1089#1072#1085#1080#1103#1084' '#1041#1044':'
        end
        object Label9: TLabel
          Left = 162
          Top = 88
          Width = 80
          Height = 13
          Anchors = [akTop, akRight]
          Caption = #1055#1091#1090#1100' '#1082' '#1086#1090#1095#1105#1090#1072#1084':'
        end
        object Edit7: TEdit
          Tag = 1
          Left = 8
          Top = 40
          Width = 329
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
        end
        object BitBtn3: TBitBtn
          Left = 264
          Top = 8
          Width = 73
          Height = 25
          Anchors = [akTop, akRight]
          Caption = #1053#1072#1081#1090#1080' ...'
          TabOrder = 2
          OnClick = BitBtn3Click
        end
        object BitBtn5: TBitBtn
          Left = 264
          Top = 80
          Width = 73
          Height = 25
          Anchors = [akTop, akRight]
          Caption = #1053#1072#1081#1090#1080' ...'
          TabOrder = 3
          OnClick = BitBtn5Click
        end
        object Edit9: TEdit
          Tag = 1
          Left = 8
          Top = 112
          Width = 329
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 360
    Top = 0
    Width = 177
    Height = 171
    Align = alRight
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 16
      Top = 16
      Width = 145
      Height = 25
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 32
      Top = 64
      Width = 113
      Height = 25
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 408
    Top = 128
  end
end
