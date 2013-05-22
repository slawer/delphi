object cShowImage: TcShowImage
  Left = 289
  Top = 38
  Width = 722
  Height = 635
  Caption = 'cShowImage'
  Color = clBtnFace
  Constraints.MinHeight = 635
  Constraints.MinWidth = 600
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefaultPosOnly
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 516
    Height = 601
    Align = alClient
    TabOrder = 0
    OnResize = Panel1Resize
    object Image1: TImage
      Left = 1
      Top = 1
      Width = 514
      Height = 599
      Align = alClient
      OnMouseDown = Image1MouseDown
      OnMouseMove = Image1MouseMove
      OnMouseUp = Image1MouseUp
    end
  end
  object Panel2: TPanel
    Left = 529
    Top = 0
    Width = 185
    Height = 601
    Align = alRight
    TabOrder = 1
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 183
      Height = 80
      Align = alTop
      BevelWidth = 2
      TabOrder = 0
      object Label1: TLabel
        Left = 48
        Top = 8
        Width = 122
        Height = 13
        Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1075#1088#1072#1092#1080#1082#1072#1084#1080
      end
      object BitBtn2: TBitBtn
        Left = 10
        Top = 6
        Width = 25
        Height = 25
        TabOrder = 0
        OnClick = BitBtn2Click
        OnKeyDown = BitBtn2KeyDown
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
          3333333333777F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333309033333333333FF7F7FFFF333333000090000
          3333333777737777F333333099999990333333373F3333373333333309999903
          333333337F33337F33333333099999033333333373F333733333333330999033
          3333333337F337F3333333333099903333333333373F37333333333333090333
          33333333337F7F33333333333309033333333333337373333333333333303333
          333333333337F333333333333330333333333333333733333333}
        NumGlyphs = 2
      end
      object BitBtn3: TBitBtn
        Left = 10
        Top = 46
        Width = 25
        Height = 25
        TabOrder = 1
        OnClick = BitBtn3Click
        OnKeyDown = BitBtn3KeyDown
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
          333333333337F33333333333333033333333333333373F333333333333090333
          33333333337F7F33333333333309033333333333337373F33333333330999033
          3333333337F337F33333333330999033333333333733373F3333333309999903
          333333337F33337F33333333099999033333333373333373F333333099999990
          33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
          33333333337F7F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333300033333333333337773333333}
        NumGlyphs = 2
      end
      object CheckBox1: TCheckBox
        Left = 43
        Top = 27
        Width = 126
        Height = 25
        Caption = #1041#1086#1083#1100#1096#1086#1081' '#1096#1072#1075' '#1089#1076#1074#1080#1075#1072' '#1086#1082#1085#1072
        TabOrder = 2
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 81
      Width = 183
      Height = 192
      Align = alTop
      BevelWidth = 2
      TabOrder = 1
      object Label11: TLabel
        Left = 5
        Top = 168
        Width = 36
        Height = 13
        Caption = #1042#1088#1077#1084#1103':'
      end
      object Edit10: TEdit
        Left = 48
        Top = 160
        Width = 128
        Height = 21
        TabOrder = 0
      end
      object StringGrid1: TStringGrid
        Left = 2
        Top = 2
        Width = 179
        Height = 155
        Align = alTop
        ColCount = 2
        RowCount = 6
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        ColWidths = (
          64
          106)
      end
    end
    object Panel5: TPanel
      Left = 1
      Top = 273
      Width = 183
      Height = 265
      Align = alClient
      TabOrder = 2
      object BitBtn9: TBitBtn
        Left = 8
        Top = 4
        Width = 169
        Height = 25
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1080#1085#1090#1077#1088#1074#1072#1083
        TabOrder = 0
        OnClick = BitBtn9Click
      end
      object BitBtn5: TBitBtn
        Left = 8
        Top = 33
        Width = 169
        Height = 25
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1055#1072#1088#1072#1084#1077#1090#1088
        TabOrder = 1
        OnClick = BitBtn5Click
      end
      object BitBtn7: TBitBtn
        Left = 8
        Top = 62
        Width = 169
        Height = 25
        Caption = #1055#1077#1088#1077#1088#1080#1089#1086#1074#1072#1090#1100' '#1075#1088#1072#1092#1080#1082#1080
        TabOrder = 2
        OnClick = BitBtn7Click
      end
      object BitBtn6: TBitBtn
        Left = 8
        Top = 92
        Width = 169
        Height = 25
        Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1080#1089#1087#1088#1072#1074#1083#1077#1085#1080#1103
        TabOrder = 3
        OnClick = BitBtn6Click
      end
      object BitBtn4: TBitBtn
        Left = 8
        Top = 128
        Width = 169
        Height = 37
        Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' XLS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnClick = BitBtn4Click
      end
      object BitBtn10: TBitBtn
        Left = 8
        Top = 171
        Width = 169
        Height = 37
        Caption = #1055#1077#1095#1072#1090#1100' '#1043#1088#1072#1092#1080#1082#1086#1074
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        OnClick = BitBtn10Click
      end
      object BitBtn11: TBitBtn
        Left = 32
        Top = 214
        Width = 121
        Height = 37
        Caption = #1055#1077#1095#1072#1090#1100' '#1101#1082#1088#1072#1085#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
        OnClick = BitBtn11Click
      end
    end
    object Panel6: TPanel
      Left = 1
      Top = 538
      Width = 183
      Height = 62
      Align = alBottom
      TabOrder = 3
      object BitBtn1: TBitBtn
        Left = 16
        Top = 11
        Width = 63
        Height = 41
        TabOrder = 0
        OnClick = BitBtn1Click
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          33033333333333333F7F3333333333333000333333333333F777333333333333
          000333333333333F777333333333333000333333333333F77733333333333300
          033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
          33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
          3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
          33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
          333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
          333333773FF77333333333370007333333333333777333333333}
        NumGlyphs = 2
      end
      object BitBtn8: TBitBtn
        Left = 104
        Top = 11
        Width = 63
        Height = 41
        TabOrder = 1
        OnClick = BitBtn8Click
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          33033333333333333F7F3333333333333000333333333333F777333333333333
          000333333333333F777333333333333000333333333333F77733333333333300
          033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
          333333773337777333333078F8F87033333337F3333337F33333778F8F8F8773
          333337333333373F333307F8F8F8F70333337F33FFFFF37F3333078999998703
          33337F377777337F333307F8F8F8F703333373F3333333733333778F8F8F8773
          333337F3333337F333333078F8F870333333373FF333F7333333330777770333
          333333773FF77333333333370007333333333333777333333333}
        NumGlyphs = 2
      end
    end
  end
  object ScrollBar1: TScrollBar
    Left = 516
    Top = 0
    Width = 13
    Height = 601
    Align = alRight
    Kind = sbVertical
    PageSize = 0
    TabOrder = 2
    OnChange = ScrollBar1Change
  end
  object PrintDialog1: TPrintDialog
    MinPage = 1
    MaxPage = 10
    Options = [poPageNums, poSelection]
    Left = 544
    Top = 120
  end
end
