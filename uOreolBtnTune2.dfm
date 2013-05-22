object OreolBtnTune2: TOreolBtnTune2
  Left = 277
  Top = 172
  Width = 504
  Height = 318
  Caption = 'OreolBtnTune2'
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
    Width = 300
    Height = 284
    Align = alClient
    TabOrder = 0
    object StringGrid1: TStringGrid
      Left = 1
      Top = 1
      Width = 298
      Height = 282
      Align = alClient
      ColCount = 3
      RowCount = 11
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goTabs, goAlwaysShowEditor, goThumbTracking]
      ScrollBars = ssVertical
      TabOrder = 0
      ColWidths = (
        64
        131
        71)
    end
  end
  object Panel2: TPanel
    Left = 300
    Top = 0
    Width = 196
    Height = 284
    Align = alRight
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 24
      Top = 16
      Width = 145
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080' '#1079#1072#1082#1088#1099#1090#1100
      Default = True
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 24
      Top = 56
      Width = 145
      Height = 25
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1080' '#1079#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
end
