object fCreateVolume: TfCreateVolume
  Left = 650
  Top = 163
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Create Virtual Volume Wizard'
  ClientHeight = 478
  ClientWidth = 543
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
  object Notebook: TNotebook
    Left = 0
    Top = 0
    Width = 543
    Height = 429
    Align = alClient
    PageIndex = 9
    TabOrder = 0
    object TPage
      Left = 0
      Top = 0
      Caption = '1. Select iSCSI Media'
      object Panel1: TPanel
        Left = 0
        Top = 57
        Width = 543
        Height = 232
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object rbStandardImageFile: TRadioButton
          Left = 32
          Top = 24
          Width = 128
          Height = 17
          Caption = 'Standard Image File'
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object rbVMwareVMDKFile: TRadioButton
          Left = 32
          Top = 48
          Width = 128
          Height = 17
          Caption = 'VMware VMDK File'
          TabOrder = 1
        end
        object rbPhysicalDisk: TRadioButton
          Left = 32
          Top = 72
          Width = 84
          Height = 17
          Caption = 'Physical Disk'
          TabOrder = 2
        end
        object rbDiskPartition: TRadioButton
          Left = 32
          Top = 96
          Width = 83
          Height = 17
          Caption = 'Disk Partition'
          TabOrder = 3
        end
        object rbVirtualCDImage: TRadioButton
          Left = 32
          Top = 120
          Width = 160
          Height = 17
          Caption = 'Virtual CD/DVD Image file'
          TabOrder = 4
        end
        object rbPhysicalCDDrive: TRadioButton
          Left = 32
          Top = 144
          Width = 168
          Height = 17
          Caption = 'Physical CD/DVD/RW Drive'
          TabOrder = 5
        end
        object rbSPTIDevice: TRadioButton
          Left = 32
          Top = 168
          Width = 256
          Height = 17
          Caption = 'SPTI Device (SCSI Pass Through Interface)'
          TabOrder = 6
        end
        object rbRAMDisk: TRadioButton
          Left = 32
          Top = 192
          Width = 69
          Height = 17
          Caption = 'RAM Disk'
          TabOrder = 7
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 543
        Height = 56
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 1
        object Label1: TLabel
          Left = 24
          Top = 8
          Width = 110
          Height = 13
          Caption = 'Select iSCSI Media'
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
          Width = 260
          Height = 13
          Caption = 'Please choose an appropriate media in the following list'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = []
          ParentFont = False
        end
        object Image1: TImage
          Left = 483
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
        Width = 543
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
      Caption = '2-1. Select Standard Image File'
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 543
        Height = 56
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object Label3: TLabel
          Left = 24
          Top = 8
          Width = 99
          Height = 13
          Caption = 'Select Image File'
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
          Width = 183
          Height = 13
          Caption = 'Please choose a regular disk image file'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = []
          ParentFont = False
        end
        object Image2: TImage
          Left = 483
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
        Width = 543
        Height = 1
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        TabOrder = 1
      end
      object Panel17: TPanel
        Left = 0
        Top = 57
        Width = 543
        Height = 264
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object Label5: TLabel
          Left = 32
          Top = 56
          Width = 107
          Height = 13
          Caption = 'Sepcify full path name:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 32
          Top = 120
          Width = 109
          Height = 13
          Caption = 'Enter device size (MB):'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = []
          ParentFont = False
        end
        object RadioButton1: TRadioButton
          Left = 32
          Top = 24
          Width = 131
          Height = 17
          Caption = 'Create a new image file'
          TabOrder = 0
        end
        object RadioButton2: TRadioButton
          Left = 232
          Top = 24
          Width = 125
          Height = 17
          Caption = 'Use existing image file'
          Checked = True
          TabOrder = 1
          TabStop = True
        end
        object edImageFile: TEdit
          Left = 32
          Top = 72
          Width = 321
          Height = 21
          ImeName = 'Microsoft IME 2010'
          MaxLength = 255
          TabOrder = 2
        end
        object BitBtn1: TBitBtn
          Left = 357
          Top = 69
          Width = 75
          Height = 25
          Caption = 'Browse'
          TabOrder = 3
          OnClick = BitBtn1Click
        end
        object Panel18: TPanel
          Left = 26
          Top = 107
          Width = 414
          Height = 1
          BevelOuter = bvNone
          Color = clSilver
          TabOrder = 4
        end
        object SpinEdit1: TSpinEdit
          Left = 32
          Top = 136
          Width = 109
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 5
          Value = 1024
        end
        object CheckBox1: TCheckBox
          Left = 32
          Top = 168
          Width = 97
          Height = 17
          Caption = 'Use spare file'
          TabOrder = 6
        end
        object CheckBox2: TCheckBox
          Left = 32
          Top = 192
          Width = 97
          Height = 17
          Caption = 'Commpressed'
          TabOrder = 7
        end
        object CheckBox3: TCheckBox
          Left = 32
          Top = 216
          Width = 119
          Height = 17
          Caption = 'Encrypted password:'
          TabOrder = 8
        end
        object edPassword: TEdit
          Left = 160
          Top = 214
          Width = 193
          Height = 21
          ImeName = 'Microsoft IME 2010'
          MaxLength = 20
          TabOrder = 9
        end
        object BitBtn2: TBitBtn
          Left = 357
          Top = 212
          Width = 28
          Height = 25
          Caption = '*'
          TabOrder = 10
          OnClick = BitBtn2Click
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = '2-2. Select VMware VMDK File'
      object Panel20: TPanel
        Left = 0
        Top = 0
        Width = 543
        Height = 56
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object Label18: TLabel
          Left = 24
          Top = 8
          Width = 114
          Height = 13
          Caption = 'Select VMDK Media'
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
          Width = 124
          Height = 13
          Caption = 'Please choose a vmdk file'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = []
          ParentFont = False
        end
        object Image6: TImage
          Left = 483
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
        Width = 543
        Height = 1
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        TabOrder = 1
      end
      object Panel22: TPanel
        Left = 0
        Top = 57
        Width = 543
        Height = 224
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object Label20: TLabel
          Left = 32
          Top = 56
          Width = 107
          Height = 13
          Caption = 'Sepcify full path name:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = []
          ParentFont = False
        end
        object Label21: TLabel
          Left = 32
          Top = 120
          Width = 109
          Height = 13
          Caption = 'Enter device size (MB):'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = []
          ParentFont = False
        end
        object RadioButton3: TRadioButton
          Left = 32
          Top = 24
          Width = 131
          Height = 17
          Caption = 'Create a new image file'
          TabOrder = 0
        end
        object RadioButton4: TRadioButton
          Left = 232
          Top = 24
          Width = 125
          Height = 17
          Caption = 'Use existing image file'
          Checked = True
          TabOrder = 1
          TabStop = True
        end
        object edVMDKFile: TEdit
          Left = 32
          Top = 72
          Width = 321
          Height = 21
          ImeName = 'Microsoft IME 2010'
          MaxLength = 255
          TabOrder = 2
        end
        object BitBtn3: TBitBtn
          Left = 357
          Top = 69
          Width = 75
          Height = 25
          Caption = 'Browse'
          TabOrder = 3
          OnClick = BitBtn3Click
        end
        object Panel23: TPanel
          Left = 26
          Top = 107
          Width = 414
          Height = 1
          BevelOuter = bvNone
          Color = clSilver
          TabOrder = 4
        end
        object SpinEdit4: TSpinEdit
          Left = 32
          Top = 136
          Width = 109
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 5
          Value = 1024
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = '2-3. Select Physical Disk'
      object Panel24: TPanel
        Left = 0
        Top = 0
        Width = 543
        Height = 56
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object Label22: TLabel
          Left = 24
          Top = 8
          Width = 117
          Height = 13
          Caption = 'Select Physical Disk'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label23: TLabel
          Left = 48
          Top = 24
          Width = 273
          Height = 13
          Caption = 'Please choose a appropriate physical disk in the below list'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = []
          ParentFont = False
        end
        object Image7: TImage
          Left = 483
          Top = 0
          Width = 60
          Height = 56
          Align = alRight
          Center = True
        end
      end
      object Panel25: TPanel
        Left = 0
        Top = 56
        Width = 543
        Height = 1
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        TabOrder = 1
      end
      object Panel26: TPanel
        Left = 0
        Top = 57
        Width = 543
        Height = 280
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object Label24: TLabel
          Left = 32
          Top = 24
          Width = 120
          Height = 13
          Caption = 'Select a physical disk list:'
        end
        object cmbDisk: TComboBox
          Left = 32
          Top = 40
          Width = 224
          Height = 21
          Style = csDropDownList
          ImeName = 'Microsoft IME 2010'
          ItemHeight = 13
          TabOrder = 0
        end
        object CheckBox6: TCheckBox
          Left = 32
          Top = 72
          Width = 173
          Height = 17
          Caption = 'Read-only access to this device'
          TabOrder = 1
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = '2-4. Select Disk Partition'
      object Panel27: TPanel
        Left = 0
        Top = 0
        Width = 543
        Height = 56
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object Label26: TLabel
          Left = 24
          Top = 8
          Width = 88
          Height = 13
          Caption = 'Select Partition'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label27: TLabel
          Left = 48
          Top = 24
          Width = 313
          Height = 13
          Caption = 
            'Please choose a appropriate physical disk partition in the below' +
            ' list'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = []
          ParentFont = False
        end
        object Image8: TImage
          Left = 483
          Top = 0
          Width = 60
          Height = 56
          Align = alRight
          Center = True
        end
      end
      object Panel28: TPanel
        Left = 0
        Top = 56
        Width = 543
        Height = 1
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        TabOrder = 1
      end
      object Panel29: TPanel
        Left = 0
        Top = 57
        Width = 543
        Height = 256
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object Label25: TLabel
          Left = 32
          Top = 24
          Width = 140
          Height = 13
          Caption = 'Select a drive letter list below:'
        end
        object cmbDrive: TComboBox
          Left = 32
          Top = 40
          Width = 233
          Height = 21
          ImeName = 'Microsoft IME 2010'
          ItemHeight = 13
          TabOrder = 0
        end
        object CheckBox7: TCheckBox
          Left = 32
          Top = 72
          Width = 173
          Height = 17
          Caption = 'Read-only access to this device'
          TabOrder = 1
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = '2-5. Select Virtual CD/DVD Image File'
      object Panel30: TPanel
        Left = 0
        Top = 0
        Width = 543
        Height = 56
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object Label28: TLabel
          Left = 24
          Top = 8
          Width = 152
          Height = 13
          Caption = 'Select CD/DVD Image File'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label29: TLabel
          Left = 48
          Top = 24
          Width = 207
          Height = 13
          Caption = 'Please choose a regular CD/DVD image file'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = []
          ParentFont = False
        end
        object Image9: TImage
          Left = 483
          Top = 0
          Width = 60
          Height = 56
          Align = alRight
          Center = True
        end
      end
      object Panel31: TPanel
        Left = 0
        Top = 56
        Width = 543
        Height = 1
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        TabOrder = 1
      end
      object Panel32: TPanel
        Left = 0
        Top = 57
        Width = 543
        Height = 240
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object Label30: TLabel
          Left = 32
          Top = 24
          Width = 209
          Height = 13
          Caption = 'Select a CD/DVD image file (.ise, .bin, .mdf):'
        end
        object edCDFile: TEdit
          Left = 32
          Top = 40
          Width = 321
          Height = 21
          ImeName = 'Microsoft IME 2010'
          TabOrder = 0
        end
        object BitBtn4: TBitBtn
          Left = 357
          Top = 37
          Width = 75
          Height = 25
          Caption = 'Browse'
          TabOrder = 1
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = '2-6. Select Physical CD/DVD/RW Drive'
      object Panel33: TPanel
        Left = 0
        Top = 0
        Width = 543
        Height = 56
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object Label31: TLabel
          Left = 24
          Top = 8
          Width = 152
          Height = 13
          Caption = 'Select CD/DVD Image File'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label32: TLabel
          Left = 48
          Top = 24
          Width = 302
          Height = 13
          Caption = 'Please choose a appropriate CD/DVD/RE drive in the below list'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = []
          ParentFont = False
        end
        object Image10: TImage
          Left = 483
          Top = 0
          Width = 60
          Height = 56
          Align = alRight
          Center = True
        end
      end
      object Panel34: TPanel
        Left = 0
        Top = 56
        Width = 543
        Height = 1
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        TabOrder = 1
      end
      object Panel35: TPanel
        Left = 0
        Top = 57
        Width = 543
        Height = 304
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object Label33: TLabel
          Left = 32
          Top = 24
          Width = 149
          Height = 13
          Caption = 'Select CD/DVD/RW list below:'
        end
        object cmbCD: TComboBox
          Left = 32
          Top = 40
          Width = 305
          Height = 21
          Style = csDropDownList
          ImeName = 'Microsoft IME 2010'
          ItemHeight = 13
          TabOrder = 0
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = '2-7. Select SPTI Devices'
      object Panel36: TPanel
        Left = 0
        Top = 0
        Width = 543
        Height = 56
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object Label34: TLabel
          Left = 24
          Top = 8
          Width = 117
          Height = 13
          Caption = 'Select Physical Disk'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label35: TLabel
          Left = 48
          Top = 24
          Width = 273
          Height = 13
          Caption = 'Please choose a appropriate physical disk in the below list'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = []
          ParentFont = False
        end
        object Image11: TImage
          Left = 483
          Top = 0
          Width = 60
          Height = 56
          Align = alRight
          Center = True
        end
      end
      object Panel37: TPanel
        Left = 0
        Top = 56
        Width = 543
        Height = 1
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        TabOrder = 1
      end
      object Panel38: TPanel
        Left = 0
        Top = 57
        Width = 543
        Height = 256
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object Label36: TLabel
          Left = 32
          Top = 24
          Width = 191
          Height = 13
          Caption = 'Select a SCSI device form the list below:'
        end
        object ListView_BootServer: TListView
          Left = 32
          Top = 40
          Width = 400
          Height = 177
          Columns = <
            item
              Caption = 'DeviceName'
              Width = 200
            end
            item
              Caption = 'Description'
              Width = 100
            end
            item
              Caption = 'DeviceType'
              Width = 80
            end>
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = '2-8. Select RAM Disk'
      object Panel39: TPanel
        Left = 0
        Top = 0
        Width = 543
        Height = 56
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object Label39: TLabel
          Left = 24
          Top = 8
          Width = 117
          Height = 13
          Caption = 'Select Physical Disk'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label40: TLabel
          Left = 48
          Top = 24
          Width = 273
          Height = 13
          Caption = 'Please choose a appropriate physical disk in the below list'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = []
          ParentFont = False
        end
        object Image12: TImage
          Left = 483
          Top = 0
          Width = 60
          Height = 56
          Align = alRight
          Center = True
        end
      end
      object Panel40: TPanel
        Left = 0
        Top = 56
        Width = 543
        Height = 1
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        TabOrder = 1
      end
      object Panel41: TPanel
        Left = 0
        Top = 57
        Width = 543
        Height = 280
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object Label37: TLabel
          Left = 32
          Top = 24
          Width = 109
          Height = 13
          Caption = 'Enter device size (MB):'
        end
        object Label38: TLabel
          Left = 32
          Top = 104
          Width = 107
          Height = 13
          Caption = 'Sepcify full path name:'
        end
        object CheckBox8: TCheckBox
          Left = 32
          Top = 80
          Width = 173
          Height = 17
          Caption = 'Read-only access to this device'
          TabOrder = 0
        end
        object SpinEdit6: TSpinEdit
          Left = 32
          Top = 40
          Width = 105
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 0
        end
        object edRAM: TEdit
          Left = 32
          Top = 120
          Width = 321
          Height = 21
          ImeName = 'Microsoft IME 2010'
          TabOrder = 2
        end
        object BitBtn5: TBitBtn
          Left = 357
          Top = 117
          Width = 75
          Height = 25
          Caption = 'Browse'
          TabOrder = 3
          OnClick = BitBtn5Click
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = '3. High Speed Cache Setting'
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 543
        Height = 56
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object Image3: TImage
          Left = 483
          Top = 0
          Width = 60
          Height = 56
          Align = alRight
          Center = True
        end
        object Label7: TLabel
          Left = 24
          Top = 8
          Width = 151
          Height = 13
          Caption = 'High Speed Cache Setting'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label8: TLabel
          Left = 48
          Top = 24
          Width = 210
          Height = 13
          Caption = 'Choose enable or disable high speed cache.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = []
          ParentFont = False
        end
      end
      object Panel10: TPanel
        Left = 0
        Top = 56
        Width = 543
        Height = 1
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        TabOrder = 1
      end
      object Panel14: TPanel
        Left = 0
        Top = 57
        Width = 543
        Height = 288
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object Label41: TLabel
          Left = 32
          Top = 200
          Width = 23
          Height = 13
          Caption = 'Size:'
        end
        object Label42: TLabel
          Left = 40
          Top = 240
          Width = 25
          Height = 13
          Caption = 'Path:'
        end
        object CheckBox4: TCheckBox
          Left = 32
          Top = 24
          Width = 213
          Height = 17
          Caption = 'Enable high speed cache on this volume'
          TabOrder = 0
        end
        object GroupBox1: TGroupBox
          Left = 32
          Top = 48
          Width = 401
          Height = 105
          Caption = ' Cache Parameters '
          TabOrder = 1
          object Label9: TLabel
            Left = 11
            Top = 28
            Width = 90
            Height = 13
            Caption = 'Chche size in MBs:'
          end
          object Label10: TLabel
            Left = 11
            Top = 60
            Width = 174
            Height = 13
            Caption = 'Cache block expiry period time in ms:'
          end
          object SpinEdit2: TSpinEdit
            Left = 192
            Top = 24
            Width = 121
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 0
            Value = 512
          end
          object SpinEdit3: TSpinEdit
            Left = 192
            Top = 56
            Width = 121
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 1
            Value = 5000
          end
        end
        object chkSSDCache: TCheckBox
          Left = 32
          Top = 168
          Width = 213
          Height = 17
          Caption = 'Enable SSD cache on this volume'
          TabOrder = 2
        end
        object edSSDCachePath: TEdit
          Left = 96
          Top = 240
          Width = 256
          Height = 21
          ImeName = 'Microsoft IME 2010'
          MaxLength = 256
          TabOrder = 3
        end
        object edSSDCacheSize: TSpinEdit
          Left = 96
          Top = 200
          Width = 121
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 4
          Value = 512
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = '4. Write-Back Cache Setting'
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 543
        Height = 56
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object Image4: TImage
          Left = 483
          Top = 0
          Width = 60
          Height = 56
          Align = alRight
          Center = True
        end
        object Label11: TLabel
          Left = 24
          Top = 8
          Width = 148
          Height = 13
          Caption = 'Write-Back Cache Setting'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label12: TLabel
          Left = 48
          Top = 24
          Width = 282
          Height = 13
          Caption = 'Select a folder for saving the temporaly data of each clients.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = []
          ParentFont = False
        end
      end
      object Panel11: TPanel
        Left = 0
        Top = 56
        Width = 543
        Height = 1
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        TabOrder = 1
      end
      object Panel15: TPanel
        Left = 0
        Top = 57
        Width = 543
        Height = 296
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object CheckBox5: TCheckBox
          Left = 32
          Top = 24
          Width = 240
          Height = 17
          Caption = 'Enable write-back cache for this volume'
          TabOrder = 0
        end
        object GroupBox2: TGroupBox
          Left = 32
          Top = 48
          Width = 401
          Height = 193
          Caption = ' Write-Back Cache Parameters '
          TabOrder = 1
          object Label13: TLabel
            Left = 11
            Top = 24
            Width = 291
            Height = 13
            Caption = 
              'Select a folder to stora temporay client data (folder must exist' +
              '):'
          end
          object Label14: TLabel
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
          object SpinEdit5: TSpinEdit
            Left = 40
            Top = 100
            Width = 80
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 0
            Value = 2048
          end
          object edVirtualWritePath: TEdit
            Left = 40
            Top = 48
            Width = 256
            Height = 21
            ImeName = 'Microsoft IME 2010'
            MaxLength = 256
            TabOrder = 1
          end
          object cmbBlockSize: TComboBox
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
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = '5. Finish'
      object Panel9: TPanel
        Left = 0
        Top = 0
        Width = 543
        Height = 56
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object Image5: TImage
          Left = 483
          Top = 0
          Width = 60
          Height = 56
          Align = alRight
          Center = True
        end
        object Label16: TLabel
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
        object Label17: TLabel
          Left = 48
          Top = 24
          Width = 404
          Height = 13
          Caption = 
            'Congratulations, the target is being created you have completed ' +
            'all the configurations.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Default'
          Font.Style = []
          ParentFont = False
        end
      end
      object Panel12: TPanel
        Left = 0
        Top = 56
        Width = 543
        Height = 3
        Align = alTop
        BevelInner = bvLowered
        TabOrder = 1
      end
      object Panel16: TPanel
        Left = 0
        Top = 59
        Width = 543
        Height = 262
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object GroupBox3: TGroupBox
          Left = 32
          Top = 24
          Width = 401
          Height = 137
          Caption = ' Description '
          TabOrder = 0
          object Memo: TMemo
            Left = 12
            Top = 24
            Width = 372
            Height = 80
            ImeName = 'Microsoft IME 2010'
            MaxLength = 255
            TabOrder = 0
          end
        end
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 429
    Width = 543
    Height = 1
    Align = alBottom
    BevelOuter = bvNone
    Color = clSilver
    TabOrder = 1
  end
  object Panel5: TPanel
    Left = 0
    Top = 430
    Width = 543
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object bBack: TBitBtn
      Left = 253
      Top = 12
      Width = 75
      Height = 25
      Caption = '< Back'
      TabOrder = 0
      OnClick = bBackClick
    end
    object bNext: TBitBtn
      Left = 333
      Top = 12
      Width = 75
      Height = 25
      Caption = 'Next >'
      TabOrder = 1
      OnClick = bNextClick
    end
    object bCancel: TBitBtn
      Left = 429
      Top = 12
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 2
      OnClick = bCancelClick
    end
  end
end
