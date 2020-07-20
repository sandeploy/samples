object fSmartDiskAttribute: TfSmartDiskAttribute
  Left = 407
  Top = 102
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'SmartDisk iSCSI Attribute'
  ClientHeight = 455
  ClientWidth = 485
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
    Width = 485
    Height = 455
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 8
      Top = 8
      Width = 465
      Height = 401
      ActivePage = TabSheet5
      MultiLine = True
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Remote Management'
        object GroupBox3: TGroupBox
          Left = 16
          Top = 16
          Width = 377
          Height = 89
          Caption = ' Bind '
          TabOrder = 0
          object Label3: TLabel
            Left = 16
            Top = 28
            Width = 54
            Height = 13
            Caption = 'IP Address:'
          end
          object Label4: TLabel
            Left = 201
            Top = 28
            Width = 58
            Height = 13
            Caption = 'Control Port:'
          end
          object RemoteManagement_Port: TEdit
            Left = 201
            Top = 48
            Width = 121
            Height = 21
            ImeName = 'Microsoft IME 2010'
            TabOrder = 0
          end
          object RemoteManagement_IPAddress: TComboBox
            Left = 16
            Top = 48
            Width = 154
            Height = 21
            ImeName = 'Microsoft IME 2010'
            ItemHeight = 0
            TabOrder = 1
          end
        end
        object GroupBox4: TGroupBox
          Left = 16
          Top = 120
          Width = 377
          Height = 65
          Caption = ' Logon User '
          TabOrder = 1
          object Label5: TLabel
            Left = 16
            Top = 31
            Width = 56
            Height = 13
            Caption = 'User Name:'
          end
          object RemoteManagement_UserName: TEdit
            Left = 121
            Top = 28
            Width = 201
            Height = 21
            ImeName = 'Microsoft IME 2010'
            TabOrder = 0
          end
        end
        object gbPassword: TGroupBox
          Left = 16
          Top = 200
          Width = 377
          Height = 137
          Caption = '                                     '
          TabOrder = 2
          object Label6: TLabel
            Left = 16
            Top = 32
            Width = 74
            Height = 13
            Caption = 'New Password:'
          end
          object Label7: TLabel
            Left = 16
            Top = 64
            Width = 87
            Height = 13
            Caption = 'Confirm Password:'
          end
          object RemoteManagement_ChangePassword: TCheckBox
            Left = 12
            Top = -1
            Width = 107
            Height = 17
            Caption = 'Change Password'
            TabOrder = 0
            OnClick = RemoteManagement_ChangePasswordClick
          end
          object RemoteManagement_NewPassword: TEdit
            Left = 121
            Top = 28
            Width = 201
            Height = 21
            Enabled = False
            ImeName = 'Microsoft IME 2010'
            PasswordChar = '*'
            TabOrder = 1
          end
          object RemoteManagement_ConfirmPassword: TEdit
            Left = 121
            Top = 60
            Width = 201
            Height = 21
            Enabled = False
            ImeName = 'Microsoft IME 2010'
            PasswordChar = '*'
            TabOrder = 2
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Load Balance'
        ImageIndex = 1
        object LoadBalance_Server_Remove: TBitBtn
          Left = 164
          Top = 8
          Width = 88
          Height = 25
          Caption = 'Remove'
          TabOrder = 0
          OnClick = LoadBalance_Server_RemoveClick
        end
        object LoadBalance_Server_Add: TBitBtn
          Left = 72
          Top = 8
          Width = 88
          Height = 25
          Caption = 'Add Server'
          TabOrder = 1
          OnClick = LoadBalance_Server_AddClick
        end
        object LoadBalance_ListView_Server: TListView
          Left = 16
          Top = 40
          Width = 424
          Height = 124
          Columns = <
            item
              Caption = 'Server Name'
              Width = 100
            end
            item
              Caption = 'Logon User'
              Width = 100
            end
            item
              Caption = 'Control Port'
              Width = 100
            end
            item
              Caption = 'Connected'
              Width = 100
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 2
          ViewStyle = vsReport
        end
        object LoadBalance_Server_Refresh: TBitBtn
          Left = 348
          Top = 8
          Width = 88
          Height = 25
          Caption = 'Refresh'
          TabOrder = 3
          OnClick = LoadBalance_Server_RefreshClick
        end
        object LoadBalance_Server_Synchronize: TBitBtn
          Left = 256
          Top = 8
          Width = 88
          Height = 25
          Caption = 'Synchronize'
          TabOrder = 4
        end
        object LoadBalance_ListView_Sync: TListView
          Left = 16
          Top = 224
          Width = 425
          Height = 137
          Columns = <
            item
              Caption = 'Target Name'
              Width = 100
            end
            item
              Caption = 'Server Name'
              Width = 100
            end
            item
              Caption = 'Remote Target'
              Width = 100
            end
            item
              Caption = 'Status'
              Width = 100
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 5
          ViewStyle = vsReport
        end
        object LoadBalance_Sync_Delete: TBitBtn
          Left = 164
          Top = 192
          Width = 88
          Height = 25
          Caption = 'Delete Sync'
          TabOrder = 6
          OnClick = LoadBalance_Sync_DeleteClick
        end
        object LoadBalance_Sync_Add: TBitBtn
          Left = 72
          Top = 192
          Width = 88
          Height = 25
          Caption = 'Add Sync'
          TabOrder = 7
          OnClick = LoadBalance_Sync_AddClick
        end
        object LoadBalance_Sync_Refresh: TBitBtn
          Left = 348
          Top = 192
          Width = 88
          Height = 25
          Caption = 'Refresh'
          TabOrder = 8
          OnClick = LoadBalance_Sync_RefreshClick
        end
        object LoadBalance_Sync_Synchronize: TBitBtn
          Left = 256
          Top = 192
          Width = 88
          Height = 25
          Caption = 'Synchronize'
          TabOrder = 9
          OnClick = LoadBalance_Sync_SynchronizeClick
        end
        object chkAutoBal: TCheckBox
          Left = 16
          Top = 168
          Width = 144
          Height = 17
          Caption = 'Automatical load balance'
          TabOrder = 10
        end
      end
      object TabSheet4: TTabSheet
        Caption = 'General'
        ImageIndex = 3
        object Label11: TLabel
          Left = 16
          Top = 16
          Width = 54
          Height = 13
          Caption = 'IP Address:'
        end
        object Label12: TLabel
          Left = 201
          Top = 16
          Width = 85
          Height = 13
          Caption = 'iSCSI Server Port:'
        end
        object General_Port: TEdit
          Left = 201
          Top = 36
          Width = 121
          Height = 21
          ImeName = 'Microsoft IME 2010'
          TabOrder = 0
          Text = '3260'
        end
        object General_IPAddress: TComboBox
          Left = 16
          Top = 36
          Width = 154
          Height = 21
          ImeName = 'Microsoft IME 2010'
          ItemHeight = 0
          TabOrder = 1
        end
        object GroupBox2: TGroupBox
          Left = 16
          Top = 72
          Width = 369
          Height = 249
          Caption = ' Target Portals '
          TabOrder = 2
          object General_ListView: TListView
            Left = 15
            Top = 28
            Width = 338
            Height = 209
            Checkboxes = True
            Columns = <
              item
                Caption = 'IP Address'
                Width = 300
              end>
            GridLines = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object General_BootService: TCheckBox
          Left = 16
          Top = 336
          Width = 183
          Height = 17
          Caption = 'Enable boot service on this server'
          TabOrder = 3
        end
      end
      object TabSheet5: TTabSheet
        Caption = 'Boot Server'
        ImageIndex = 4
        object Label13: TLabel
          Left = 16
          Top = 20
          Width = 55
          Height = 13
          Caption = 'Boot Mode:'
        end
        object BootServer_BootMode: TComboBox
          Left = 88
          Top = 16
          Width = 257
          Height = 21
          Style = csDropDownList
          ImeName = 'Microsoft IME 2010'
          ItemHeight = 13
          TabOrder = 0
          Items.Strings = (
            'Anonymous booting (External DHCP)'
            'Automatically add workstation (External DHCP)'
            'Automatically add workstation (Built-in DHCP)'
            'Manually add workstation (Built-in DHCP)')
        end
        object GroupBox6: TGroupBox
          Left = 16
          Top = 48
          Width = 329
          Height = 265
          Caption = ' Client Settings '
          TabOrder = 1
          object Label14: TLabel
            Left = 16
            Top = 28
            Width = 88
            Height = 21
            AutoSize = False
            Caption = 'Gateway:'
            Color = clRed
            ParentColor = False
            Transparent = True
            Layout = tlCenter
          end
          object Label16: TLabel
            Left = 16
            Top = 58
            Width = 88
            Height = 21
            AutoSize = False
            Caption = 'DNS Server:'
            Color = clRed
            ParentColor = False
            Transparent = True
            Layout = tlCenter
          end
          object Label17: TLabel
            Left = 16
            Top = 88
            Width = 88
            Height = 21
            AutoSize = False
            Caption = 'Host Name Prefix:'
            Color = clRed
            ParentColor = False
            Transparent = True
            Layout = tlCenter
          end
          object Label18: TLabel
            Left = 16
            Top = 114
            Width = 88
            Height = 21
            AutoSize = False
            Caption = 'Start IP Address:'
            Color = clRed
            ParentColor = False
            Transparent = True
            Layout = tlCenter
          end
          object Label19: TLabel
            Left = 16
            Top = 140
            Width = 88
            Height = 21
            AutoSize = False
            Caption = 'End IP Address:'
            Color = clRed
            ParentColor = False
            Transparent = True
            Layout = tlCenter
          end
          object Label20: TLabel
            Left = 16
            Top = 170
            Width = 88
            Height = 21
            AutoSize = False
            Caption = 'IP Mask:'
            Color = clRed
            ParentColor = False
            Transparent = True
            Layout = tlCenter
          end
          object Label21: TLabel
            Left = 16
            Top = 196
            Width = 88
            Height = 21
            AutoSize = False
            Caption = 'Boot IQN:'
            Color = clRed
            ParentColor = False
            Transparent = True
            Layout = tlCenter
          end
          object Label22: TLabel
            Left = 16
            Top = 222
            Width = 88
            Height = 21
            AutoSize = False
            Caption = 'Save Data Mode:'
            Color = clRed
            ParentColor = False
            Transparent = True
            Layout = tlCenter
          end
          object Label23: TLabel
            Left = 188
            Top = 84
            Width = 39
            Height = 21
            AutoSize = False
            Caption = 'ID Len:'
            Color = clRed
            ParentColor = False
            Transparent = True
            Layout = tlCenter
          end
          object BootServer_Gateway: TComboBox
            Left = 112
            Top = 28
            Width = 184
            Height = 21
            ImeName = 'Microsoft IME 2010'
            ItemHeight = 13
            TabOrder = 0
          end
          object BootServer_HostName: TEdit
            Left = 112
            Top = 84
            Width = 66
            Height = 21
            ImeName = 'Microsoft IME 2010'
            TabOrder = 1
          end
          object BootServer_BootIQN: TComboBox
            Left = 111
            Top = 196
            Width = 183
            Height = 21
            ImeName = 'Microsoft IME 2010'
            ItemHeight = 13
            TabOrder = 2
          end
          object BootServer_SaveDataMode: TComboBox
            Left = 111
            Top = 222
            Width = 183
            Height = 21
            ImeName = 'Microsoft IME 2010'
            ItemHeight = 13
            TabOrder = 3
            Items.Strings = (
              'Anatomically reset data after boot'
              'Persistently save data for client')
          end
          object BootServer_IDLen: TSpinEdit
            Left = 233
            Top = 84
            Width = 61
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 4
            Value = 3
          end
          object edDNS: TEdit
            Left = 112
            Top = 56
            Width = 160
            Height = 21
            ImeName = 'Microsoft IME 2010'
            MaxLength = 15
            TabOrder = 5
          end
          object edStartIp: TEdit
            Left = 112
            Top = 112
            Width = 160
            Height = 21
            ImeName = 'Microsoft IME 2010'
            MaxLength = 15
            TabOrder = 6
          end
          object edEndIp: TEdit
            Left = 112
            Top = 140
            Width = 160
            Height = 21
            ImeName = 'Microsoft IME 2010'
            MaxLength = 15
            TabOrder = 7
          end
          object edIpMask: TEdit
            Left = 112
            Top = 168
            Width = 160
            Height = 21
            ImeName = 'Microsoft IME 2010'
            MaxLength = 15
            TabOrder = 8
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'License'
        ImageIndex = 2
        object Label30: TLabel
          Left = 16
          Top = 16
          Width = 59
          Height = 13
          Caption = 'License File:'
        end
        object License_LicenseFile: TEdit
          Left = 16
          Top = 32
          Width = 265
          Height = 21
          ImeName = 'Microsoft IME 2010'
          TabOrder = 0
        end
        object BootServer_Inport: TBitBtn
          Left = 285
          Top = 29
          Width = 75
          Height = 25
          Caption = 'Import'
          TabOrder = 1
        end
        object GroupBox1: TGroupBox
          Left = 16
          Top = 72
          Width = 345
          Height = 217
          Caption = ' License Detail '
          TabOrder = 2
          object Label1: TLabel
            Left = 16
            Top = 28
            Width = 56
            Height = 13
            Caption = 'License To:'
          end
          object Label2: TLabel
            Left = 16
            Top = 52
            Width = 22
            Height = 13
            Caption = 'User'
          end
          object Label8: TLabel
            Left = 16
            Top = 76
            Width = 95
            Height = 13
            Caption = 'COMPUTER NAME'
          end
          object Label9: TLabel
            Left = 16
            Top = 100
            Width = 67
            Height = 13
            Caption = 'License Type:'
          end
          object Label10: TLabel
            Left = 16
            Top = 124
            Width = 194
            Height = 13
            Caption = 'SmartDisk Boot Server - Trial License  ....'
          end
        end
      end
    end
    object bConfirm: TBitBtn
      Left = 237
      Top = 420
      Width = 75
      Height = 25
      Caption = 'Confirm'
      TabOrder = 1
      OnClick = bConfirmClick
    end
    object bCancel: TBitBtn
      Left = 317
      Top = 420
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 2
      OnClick = bCancelClick
    end
    object bApply: TBitBtn
      Left = 397
      Top = 420
      Width = 75
      Height = 25
      Caption = 'Apply'
      TabOrder = 3
      OnClick = bApplyClick
    end
  end
end
