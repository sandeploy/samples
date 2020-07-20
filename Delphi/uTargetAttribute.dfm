object fTargetAttribute: TfTargetAttribute
  Left = 916
  Top = 152
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Target Attribute'
  ClientHeight = 448
  ClientWidth = 567
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 567
    Height = 448
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object PageControl: TPageControl
      Left = 8
      Top = 8
      Width = 545
      Height = 385
      ActivePage = TabSheet2
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'LUNs'
        object Label7: TLabel
          Left = 16
          Top = 16
          Width = 60
          Height = 30
          AutoSize = False
          Caption = 'Available Volumes:'
          WordWrap = True
        end
        object Label8: TLabel
          Left = 16
          Top = 192
          Width = 60
          Height = 30
          AutoSize = False
          Caption = 'Selected Volumes:'
          WordWrap = True
        end
        object Label3: TLabel
          Left = 16
          Top = 336
          Width = 473
          Height = 13
          Caption = 
            'Note, you need to re-active target (offline/online or restart se' +
            'rvice) to take effect after changed LUN.'
        end
        object lbAvailVols: TListBox
          Left = 72
          Top = 16
          Width = 449
          Height = 129
          ImeName = 'Microsoft IME 2010'
          ItemHeight = 13
          TabOrder = 0
        end
        object lbSelVols: TListBox
          Left = 72
          Top = 192
          Width = 449
          Height = 129
          ImeName = 'Microsoft IME 2010'
          ItemHeight = 13
          TabOrder = 1
        end
        object BitBtn5: TBitBtn
          Left = 69
          Top = 156
          Width = 75
          Height = 25
          Caption = 'Add'
          TabOrder = 2
          OnClick = BitBtn5Click
        end
        object BitBtn6: TBitBtn
          Left = 149
          Top = 156
          Width = 75
          Height = 25
          Caption = 'Remove'
          TabOrder = 3
          OnClick = BitBtn6Click
        end
        object BitBtn7: TBitBtn
          Left = 365
          Top = 156
          Width = 75
          Height = 25
          Caption = 'Add All'
          TabOrder = 4
          OnClick = BitBtn7Click
        end
        object BitBtn8: TBitBtn
          Left = 445
          Top = 156
          Width = 75
          Height = 25
          Caption = 'Remove All'
          TabOrder = 5
          OnClick = BitBtn8Click
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Security'
        ImageIndex = 1
        object Label5: TLabel
          Left = 16
          Top = 16
          Width = 78
          Height = 13
          Caption = 'Available Group:'
        end
        object Label6: TLabel
          Left = 312
          Top = 16
          Width = 152
          Height = 13
          Caption = 'Selected Administrator'#39's Groups:'
        end
        object lbAvailGroups: TListBox
          Left = 16
          Top = 40
          Width = 201
          Height = 249
          ImeName = 'Microsoft IME 2010'
          ItemHeight = 13
          TabOrder = 0
        end
        object lbSelGroups: TListBox
          Left = 312
          Top = 40
          Width = 201
          Height = 249
          ImeName = 'Microsoft IME 2010'
          ItemHeight = 13
          TabOrder = 1
        end
        object BitBtn1: TBitBtn
          Left = 224
          Top = 40
          Width = 75
          Height = 25
          Caption = '>'
          TabOrder = 2
          OnClick = BitBtn1Click
        end
        object BitBtn2: TBitBtn
          Left = 224
          Top = 72
          Width = 75
          Height = 25
          Caption = '<'
          TabOrder = 3
          OnClick = BitBtn2Click
        end
        object BitBtn3: TBitBtn
          Left = 224
          Top = 232
          Width = 75
          Height = 25
          Caption = '>>'
          TabOrder = 4
          OnClick = BitBtn3Click
        end
        object BitBtn4: TBitBtn
          Left = 224
          Top = 264
          Width = 75
          Height = 25
          Caption = '<<'
          TabOrder = 5
          OnClick = BitBtn4Click
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Write-Back'
        ImageIndex = 2
        object Label25: TLabel
          Left = 16
          Top = 16
          Width = 62
          Height = 13
          Caption = 'TargetName:'
        end
        object edTargetName: TEdit
          Left = 16
          Top = 40
          Width = 369
          Height = 21
          TabOrder = 0
        end
      end
    end
    object bConfirm: TBitBtn
      Left = 317
      Top = 404
      Width = 75
      Height = 25
      Caption = 'Confirm'
      TabOrder = 1
      OnClick = bConfirmClick
    end
    object bCancel: TBitBtn
      Left = 397
      Top = 404
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 2
    end
    object bApply: TBitBtn
      Left = 477
      Top = 404
      Width = 75
      Height = 25
      Caption = 'Apply'
      TabOrder = 3
      OnClick = bApplyClick
    end
  end
end
