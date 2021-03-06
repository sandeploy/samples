object fVolumeAttribute: TfVolumeAttribute
  Left = 672
  Top = 187
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Disk Volume Attribute'
  ClientHeight = 382
  ClientWidth = 630
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 630
    Height = 382
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object PageControl: TPageControl
      Left = 8
      Top = 8
      Width = 585
      Height = 305
      ActivePage = TabSheet3
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'General'
        object GroupBox3: TGroupBox
          Left = 16
          Top = 16
          Width = 521
          Height = 209
          Caption = ' Description '
          TabOrder = 0
          object Label3: TLabel
            Left = 16
            Top = 128
            Width = 55
            Height = 13
            Caption = 'Hard Serial:'
          end
          object lbHddSn: TLabel
            Left = 88
            Top = 128
            Width = 3
            Height = 13
          end
          object General_Description: TMemo
            Left = 12
            Top = 24
            Width = 372
            Height = 88
            ImeName = 'Microsoft IME 2010'
            TabOrder = 0
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Cache'
        ImageIndex = 1
        object Cache_EnableHigh: TCheckBox
          Left = 16
          Top = 16
          Width = 213
          Height = 17
          Caption = 'Enable high speed cache on the volume'
          TabOrder = 0
        end
        object GroupBox2: TGroupBox
          Left = 16
          Top = 44
          Width = 401
          Height = 125
          Caption = ' Cache Parameters '
          TabOrder = 1
          object Label13: TLabel
            Left = 11
            Top = 28
            Width = 90
            Height = 13
            Caption = 'Cache size in MBs:'
          end
          object Label14: TLabel
            Left = 11
            Top = 60
            Width = 174
            Height = 13
            Caption = 'Cache block expiry period time in ms:'
          end
          object Cache_Size: TSpinEdit
            Left = 192
            Top = 24
            Width = 80
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 0
            Value = 512
          end
          object Cache_Time: TSpinEdit
            Left = 192
            Top = 56
            Width = 80
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 1
            Value = 5000
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Write-Back'
        ImageIndex = 2
        object WriteBack_EnableWriteback: TCheckBox
          Left = 16
          Top = 16
          Width = 213
          Height = 17
          Caption = 'Enable write-back cache for this volume'
          TabOrder = 0
        end
        object GroupBox1: TGroupBox
          Left = 16
          Top = 36
          Width = 401
          Height = 197
          Caption = ' Write-Back Cache Parameters '
          TabOrder = 1
          object Label1: TLabel
            Left = 11
            Top = 24
            Width = 291
            Height = 13
            Caption = 
              'Select a folder to stora temporay client data (folder must exist' +
              '):'
          end
          object Label2: TLabel
            Left = 11
            Top = 80
            Width = 235
            Height = 13
            Caption = 'Quota for each client MBs ("0" indicate unlimited):'
          end
          object Label15: TLabel
            Left = 11
            Top = 136
            Width = 84
            Height = 13
            Caption = 'Block size in KBs:'
          end
          object Label41: TLabel
            Left = 235
            Top = 136
            Width = 57
            Height = 13
            Caption = 'TempClear: '
          end
          object WriteBack_QuotaSize: TSpinEdit
            Left = 40
            Top = 100
            Width = 80
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 0
            Value = 2048
          end
          object WriteBack_TempPath: TEdit
            Left = 40
            Top = 48
            Width = 257
            Height = 21
            ImeName = 'Microsoft IME 2010'
            TabOrder = 1
          end
          object WriteBack_BlackSize: TComboBox
            Left = 40
            Top = 156
            Width = 80
            Height = 21
            Style = csDropDownList
            ImeName = 'Microsoft IME 2010'
            ItemHeight = 13
            TabOrder = 2
            Items.Strings = (
              '2K'
              '4K'
              '8K'
              '16K'
              '32K'
              '64K')
          end
          object WriteBack_bPath: TBitBtn
            Left = 302
            Top = 46
            Width = 75
            Height = 25
            Caption = '...'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Default'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 3
          end
          object SpinEdit7: TSpinEdit
            Left = 296
            Top = 135
            Width = 80
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 4
            Value = 0
          end
        end
      end
      object TabSheet4: TTabSheet
        Caption = 'Snapshot'
        ImageIndex = 3
        object Snapshot_TreeView: TTreeView
          Left = 16
          Top = 16
          Width = 249
          Height = 185
          AutoExpand = True
          Images = ImageList1
          Indent = 19
          ReadOnly = True
          ShowRoot = False
          TabOrder = 0
          OnDeletion = Snapshot_TreeViewDeletion
        end
        object Snapshot_Goto: TBitBtn
          Left = 16
          Top = 212
          Width = 81
          Height = 25
          Caption = 'Go to'
          TabOrder = 1
          OnClick = Snapshot_GotoClick
        end
        object Snapshot_Delete: TBitBtn
          Left = 99
          Top = 212
          Width = 81
          Height = 25
          Caption = 'Delete'
          TabOrder = 2
          OnClick = Snapshot_DeleteClick
        end
        object Snapshot_New: TBitBtn
          Left = 183
          Top = 212
          Width = 81
          Height = 25
          Caption = 'New'
          TabOrder = 3
          OnClick = Snapshot_NewClick
        end
        object Snapshot_Edit: TBitBtn
          Left = 456
          Top = 212
          Width = 81
          Height = 25
          Caption = 'Edit'
          TabOrder = 4
          OnClick = Snapshot_EditClick
        end
        object GroupBox4: TGroupBox
          Left = 288
          Top = 16
          Width = 250
          Height = 85
          Caption = ' Name '
          TabOrder = 5
        end
        object GroupBox5: TGroupBox
          Left = 288
          Top = 115
          Width = 250
          Height = 85
          Caption = ' Description '
          TabOrder = 6
        end
      end
    end
    object bConfirm: TBitBtn
      Left = 357
      Top = 316
      Width = 75
      Height = 25
      Caption = 'Confirm'
      TabOrder = 1
      OnClick = bConfirmClick
    end
    object bCancel: TBitBtn
      Left = 437
      Top = 316
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 2
      OnClick = bCancelClick
    end
    object bApply: TBitBtn
      Left = 517
      Top = 316
      Width = 75
      Height = 25
      Caption = 'Apply'
      TabOrder = 3
      OnClick = bApplyClick
    end
  end
  object ImageList1: TImageList
    Left = 444
    Top = 56
    Bitmap = {
      494C010102000400080010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FE0000000000FFFFFE00AAA0A000ADA1A1008D8181002E5672002A526E006A7C
      8500FAFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000A27D7F0074524C00B8CDAC00457943003C813E0063A8
      6500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FC00978E8B00FFFFFE00AEAAA90083818000A8A5A7000080A30065E5FF0074A2
      B400315F7100147C9F00248CAF00000000000000000000000000000000000000
      0000928E8D00FFFEFE008D676700CBA6A200CEDFBE003E7F470064EC8E0037BF
      61004B814C00F4FFEE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A67A
      7B0095696A00CCB2B200636E6C00BEE7FD003387A1005AEFFF003ACEE6003486
      A9003C8EB10083F8FF004AC3CC00000000000000000000000000FFFFFB00967D
      7B008F6062008C5D5F00A67A7900ECC5C300D4E2C000397B40003ACD71003CD2
      6E0058E8810029A9440000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFC00907E7D00DAC2
      C200E8D0D000AEA19F006369680096EEFF006DC5DD0089D0DE0092D9E700049C
      B4005EF6FF0054ABBB00D8FFFF00000000000000000000000000957E7C00E1C2
      C100E0BBBD00CCA7A900E4C2C200DFC1C000D9E5C7003D7A400043C6650029BD
      590034D06B0051EC8B003D915100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009B7C
      7D00FFE1E200A2A0A00093919100AAA7A300EBE8E400E7E2DF00E1DBDC0046BB
      DA0051C6E50095888600D0C3C100000000000000000000000000FFFDFC00957D
      7D00E9D1D100E1C9C900E2C7CA00E1C6C900DAEFCF004478430081CE940060C7
      7C003CB75700239E3E00899F8300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AE8888009A7474009775
      7500FFE1E400A1A1A100DEDEDE00BABABA00A1A1A100E0E0E000E3E3E300DDDB
      DB00978C8E00DFC5C500896F6F0000000000000000009F898B00A3737100A373
      7100E9D1D100E4CCCC00E8D0D000D9C1C100E0F5D5004B7D4D008FD599006CB2
      760079956A00DCE2CB00BFB8B500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5838300F5D3D300E5D1
      D000F3E6E80094949400B1B1B1000000000000000000C2C4C5008D8F90007F7D
      7D00DCD1D300EFCDCD007E5C5C0000000000000000009A848600E8D4D300E5D1
      D000DFCBCA00EDD5D500BD9E9D00BA9B9A00C7DFBF00547E4F0053864D00A1D4
      9B00F2D6D600DCC0C000745C5C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009F838200F8DCDB00F9E1
      E300E6D6D700D4D2D100BDBBBA009B9B9B00B6B6B600B0AEAD00CCC2C200F8E3
      E200CAB5B40078636200FFFDFC00000000000000000099848300ECDEDF00F1E3
      E400E1CCCE00F4DFE1008B777600FFFDFC00D4CECF00E1DBDC00EFE2E000E1C7
      C700CFA7A8008860610000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFEFC0099858400D0B4
      B400E9CDCD00F7EAE800CFC2C000C1B1B200CDB8BA00D4C0BF00EFD7D700E6C7
      C800C4A5A600745A5A00FFFDFC00000000000000000000000000A4858400D3B4
      B300E2CDD000F9E4E700A07A7A0097717100A9848600BF9A9C00E2CCCE00DDC7
      C900D0A4A5008458590000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFEFC00A8949300D7BF
      BF00EDD5D500E9DAD800F2E3E100DABBBC00E5C6C700ECD7D600E0CBCA00E0C6
      C600E8C9CA00B7999800A3858400000000000000000000000000B1939200DDBF
      BE00EAD6D500EDD9D800F6E2E100D4BCBC00E2C8C800F0D6D600E4CACA00E0C6
      C600EDC8CA00BC97990098858800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFDFC00BBA7A600FFFA
      FB00F6F1F200E9D4D300E4CFCE00F0DEDF00EBD9DA00E0CBCA00E4C5C600C39D
      9D00BE989800967A7900FFFDFE00000000000000000000000000BBA7A600FFF9
      F800FEF0F100E2D4D500E1CFCE00F3DEDD00EDD9D800E2CACA00E5C6C700BF9D
      9E00C1979800A177780000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFEFE00B5A0A200CCA4
      A500BC949500C0A8A800FCE4E400E8D0D000E6CECE00E9D4D300D7C2C1009785
      8600FFFDFE000000000000000000000000000000000000000000C3A09D00C8A5
      A200B9959500CBA7A700F7E5E400E3D1D000E3CFCE00EBD3D300DDC1C000A084
      8300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FDFF
      FF00FDFFFF00AC9D9B00FFF4F400C6A0A000B18B8B00C5A6A700E1C7C7009E89
      8B00FFFEFE000000000000000000000000000000000000000000000000000000
      0000FFFDFC00AF9B9A00FFF5F400B6A2A100B18B8B00CCA6A600E6C7C600A18A
      8800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C2A3A200C0A1A000ADA1A100FFFEFE00B2969500A5898800FFFE
      FF00FFFEFF00000000000000000000000000000000000000000000000000FFFE
      FF00FFFEFE00B6A4A500C0A1A000BE9F9E00FFFDFE00A79798009A8B8900FFFE
      FC00FEFFFD00FFFFFE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000E807FC0F00000000
      E001F00300000000E001C003000000008001C00100000000E001C00100000000
      8001800100000000818180010000000080018003000000008001C00300000000
      8001C001000000008001C003000000008007C00F00000000E007F00F00000000
      F807E00300000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
end
