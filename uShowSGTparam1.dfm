object cShowSGTparam1: TcShowSGTparam1
  Left = 297
  Top = 178
  Width = 550
  Height = 150
  Caption = 'cShowSGTparam1'
  Color = clBtnFace
  Constraints.MinHeight = 150
  Constraints.MinWidth = 550
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 542
    Height = 116
    Align = alClient
    TabOrder = 0
    OnResize = Panel1Resize
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 349
      Height = 114
      Align = alClient
      Caption = 'Panel2'
      TabOrder = 0
      object StringGrid1: TStringGrid
        Left = 1
        Top = 1
        Width = 347
        Height = 112
        Align = alClient
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
        TabOrder = 0
        OnClick = StringGrid1Click
      end
    end
    object Panel3: TPanel
      Left = 350
      Top = 1
      Width = 191
      Height = 114
      Align = alRight
      TabOrder = 1
      DesignSize = (
        191
        114)
      object BitBtn1: TBitBtn
        Left = 32
        Top = 68
        Width = 129
        Height = 25
        Anchors = [akLeft, akBottom]
        Cancel = True
        Caption = #1047#1072#1082#1088#1099#1090#1100
        TabOrder = 0
        OnClick = BitBtn1Click
      end
      object BitBtn2: TBitBtn
        Left = 16
        Top = 16
        Width = 161
        Height = 33
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1089#1090#1088#1086#1082#1091' '#8470
        TabOrder = 1
        OnClick = BitBtn2Click
      end
    end
  end
end
