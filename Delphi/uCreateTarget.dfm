object fCreateTarget: TfCreateTarget
  Left = 384
  Top = 187
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'fCreateTarget'
  ClientHeight = 527
  ClientWidth = 608
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Default'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel5: TPanel
    Left = 0
    Top = 479
    Width = 608
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object bBack: TBitBtn
      Left = 341
      Top = 12
      Width = 75
      Height = 25
      Caption = '< Back'
      TabOrder = 0
      OnClick = bBackClick
    end
    object bNext: TBitBtn
      Left = 421
      Top = 12
      Width = 75
      Height = 25
      Caption = 'Next >'
      TabOrder = 1
      OnClick = bNextClick
    end
    object bCancel: TBitBtn
      Left = 517
      Top = 12
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 2
      OnClick = bCancelClick
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 478
    Width = 608
    Height = 1
    Align = alBottom
    BevelOuter = bvNone
    Color = clSilver
    TabOrder = 1
  end
  object Notebook: TNotebook
    Left = 0
    Top = 0
    Width = 608
    Height = 478
    Align = alClient
    PageIndex = 1
    TabOrder = 2
    object TPage
      Left = 0
      Top = 0
      Caption = '1. Select LUN'
      object Panel1: TPanel
        Left = 0
        Top = 57
        Width = 608
        Height = 344
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label7: TLabel
          Left = 32
          Top = 24
          Width = 60
          Height = 30
          AutoSize = False
          Caption = 'Available Volumes:'
          WordWrap = True
        end
        object Label8: TLabel
          Left = 32
          Top = 200
          Width = 60
          Height = 30
          AutoSize = False
          Caption = 'Selected Volumes:'
          WordWrap = True
        end
        object lbAvailVol: TListBox
          Left = 88
          Top = 24
          Width = 449
          Height = 129
          ImeName = 'Microsoft IME 2010'
          ItemHeight = 14
          TabOrder = 0
        end
        object lbSelVols: TListBox
          Left = 88
          Top = 200
          Width = 449
          Height = 129
          ImeName = 'Microsoft IME 2010'
          ItemHeight = 14
          TabOrder = 1
        end
        object BitBtn5: TBitBtn
          Left = 85
          Top = 164
          Width = 75
          Height = 25
          Caption = 'Add'
          TabOrder = 2
          OnClick = BitBtn5Click
        end
        object BitBtn6: TBitBtn
          Left = 165
          Top = 164
          Width = 75
          Height = 25
          Caption = 'Remove'
          TabOrder = 3
          OnClick = BitBtn6Click
        end
        object BitBtn7: TBitBtn
          Left = 381
          Top = 164
          Width = 75
          Height = 25
          Caption = 'Add All'
          TabOrder = 4
          OnClick = BitBtn7Click
        end
        object BitBtn8: TBitBtn
          Left = 461
          Top = 164
          Width = 75
          Height = 25
          Caption = 'Remove All'
          TabOrder = 5
          OnClick = BitBtn8Click
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 608
        Height = 56
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 1
        object Label1: TLabel
          Left = 24
          Top = 8
          Width = 66
          Height = 13
          Caption = 'Select LUN'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 48
          Top = 24
          Width = 239
          Height = 13
          Caption = 'Please choose at least one LUN n the following list'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = []
          ParentFont = False
        end
        object Image1: TImage
          Left = 548
          Top = 0
          Width = 60
          Height = 56
          Align = alRight
          Center = True
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 56
        Width = 608
        Height = 1
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        TabOrder = 2
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = '2. Set iSCSI Target Authorization'
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 608
        Height = 56
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object Label3: TLabel
          Left = 24
          Top = 8
          Width = 174
          Height = 13
          Caption = 'Set iSCSI Target Authorization'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 48
          Top = 24
          Width = 152
          Height = 13
          Caption = 'Please at least one CHAP group'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = []
          ParentFont = False
        end
        object Image2: TImage
          Left = 548
          Top = 0
          Width = 60
          Height = 56
          Align = alRight
          Center = True
        end
      end
      object Panel13: TPanel
        Left = 0
        Top = 56
        Width = 608
        Height = 1
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        TabOrder = 1
      end
      object Panel17: TPanel
        Left = 0
        Top = 57
        Width = 608
        Height = 328
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object Label5: TLabel
          Left = 32
          Top = 24
          Width = 78
          Height = 13
          Caption = 'Available Group:'
        end
        object Label6: TLabel
          Left = 328
          Top = 24
          Width = 152
          Height = 13
          Caption = 'Selected Administrator'#39's Groups:'
        end
        object lbAvailGroups: TListBox
          Left = 32
          Top = 48
          Width = 201
          Height = 249
          ImeName = 'Microsoft IME 2010'
          ItemHeight = 13
          TabOrder = 0
        end
        object lbSelGroups: TListBox
          Left = 328
          Top = 48
          Width = 201
          Height = 249
          ImeName = 'Microsoft IME 2010'
          ItemHeight = 13
          TabOrder = 1
        end
        object BitBtn1: TBitBtn
          Left = 240
          Top = 48
          Width = 75
          Height = 25
          Caption = '>'
          TabOrder = 2
          OnClick = BitBtn1Click
        end
        object BitBtn2: TBitBtn
          Left = 240
          Top = 80
          Width = 75
          Height = 25
          Caption = '<'
          TabOrder = 3
          OnClick = BitBtn2Click
        end
        object BitBtn3: TBitBtn
          Left = 240
          Top = 240
          Width = 75
          Height = 25
          Caption = '>>'
          TabOrder = 4
          OnClick = BitBtn3Click
        end
        object BitBtn4: TBitBtn
          Left = 240
          Top = 272
          Width = 75
          Height = 25
          Caption = '<<'
          TabOrder = 5
          OnClick = BitBtn4Click
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = '3. Finish'
      object Panel20: TPanel
        Left = 0
        Top = 0
        Width = 608
        Height = 56
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object Label18: TLabel
          Left = 24
          Top = 8
          Width = 34
          Height = 13
          Caption = 'Finish'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label19: TLabel
          Left = 48
          Top = 24
          Width = 223
          Height = 13
          Caption = 'Enter target name to finish iSCSI target creating'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = []
          ParentFont = False
        end
        object Image6: TImage
          Left = 548
          Top = 0
          Width = 60
          Height = 56
          Align = alRight
          Center = True
        end
      end
      object Panel21: TPanel
        Left = 0
        Top = 56
        Width = 608
        Height = 1
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        TabOrder = 1
      end
      object Panel22: TPanel
        Left = 0
        Top = 57
        Width = 608
        Height = 224
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object Label25: TLabel
          Left = 32
          Top = 24
          Width = 62
          Height = 13
          Caption = 'TargetName:'
        end
        object edTargetName: TEdit
          Left = 32
          Top = 48
          Width = 369
          Height = 21
          ImeName = 'Microsoft IME 2010'
          TabOrder = 0
        end
      end
    end
  end
end
