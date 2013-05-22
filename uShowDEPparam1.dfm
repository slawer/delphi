object cShowDEPparam1: TcShowDEPparam1
  Left = 245
  Top = 133
  Width = 450
  Height = 150
  Caption = 'cShowDEPparam1'
  Color = clBtnFace
  Constraints.MinHeight = 150
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 442
    Height = 116
    Align = alClient
    TabOrder = 0
    OnResize = Panel1Resize
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 249
      Height = 114
      Align = alClient
      Caption = 'Panel2'
      TabOrder = 0
      object StringGrid1: TStringGrid
        Tag = 1
        Left = 1
        Top = 1
        Width = 247
        Height = 112
        Align = alClient
        ColCount = 3
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
        TabOrder = 0
      end
    end
    object Panel3: TPanel
      Left = 250
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
    end
  end
end
