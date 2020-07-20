object fMain: TfMain
  Left = 605
  Top = 138
  Width = 894
  Height = 590
  Caption = 'SmartDISK'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Default'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 100
    Top = 27
    Height = 504
  end
  object Panel1: TPanel
    Left = 0
    Top = 27
    Width = 100
    Height = 504
    Align = alLeft
    BevelOuter = bvNone
    BorderWidth = 1
    Color = clGray
    TabOrder = 0
    object btnUsers: TBitBtn
      Left = 0
      Top = 1
      Width = 100
      Height = 32
      Caption = 'Users'
      TabOrder = 0
      OnClick = btnUsersClick
    end
    object BitBtn2: TBitBtn
      Left = 0
      Top = 33
      Width = 100
      Height = 32
      Caption = 'Groups'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 0
      Top = 65
      Width = 100
      Height = 32
      Caption = 'Virtual Volumes'
      TabOrder = 2
      OnClick = BitBtn3Click
    end
    object BitBtn4: TBitBtn
      Left = 0
      Top = 97
      Width = 100
      Height = 32
      Caption = 'iSCSI Targets'
      TabOrder = 3
      OnClick = BitBtn4Click
    end
    object BitBtn5: TBitBtn
      Left = 0
      Top = 129
      Width = 100
      Height = 32
      Caption = 'BootServer'
      TabOrder = 4
      OnClick = BitBtn5Click
    end
  end
  object Panel5: TPanel
    Left = 103
    Top = 27
    Width = 775
    Height = 504
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Panel2: TPanel
      Left = 0
      Top = 27
      Width = 775
      Height = 477
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 1
      Color = clGray
      TabOrder = 0
      object Notebook: TNotebook
        Left = 1
        Top = 1
        Width = 773
        Height = 475
        Align = alClient
        PageIndex = 4
        TabOrder = 0
        object TPage
          Left = 0
          Top = 0
          Caption = 'Root'
          object ListView_Root: TListView
            Left = 0
            Top = 0
            Width = 773
            Height = 475
            Align = alClient
            BorderStyle = bsNone
            Columns = <
              item
                Caption = 'Name'
                Width = 100
              end
              item
                Caption = 'Description'
                Width = 300
              end>
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object TPage
          Left = 0
          Top = 0
          Caption = 'Users'
          object ListView_Users: TListView
            Left = 0
            Top = 26
            Width = 773
            Height = 449
            Align = alClient
            BorderStyle = bsNone
            Columns = <
              item
                Caption = 'Name'
                Width = 100
              end
              item
                Caption = 'Groups'
                Width = 300
              end>
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
          object Panel4: TPanel
            Left = 0
            Top = 0
            Width = 773
            Height = 26
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object User_Create: TBitBtn
              Left = 1
              Top = 1
              Width = 115
              Height = 25
              Caption = 'Create User'
              TabOrder = 0
              OnClick = User_CreateClick
            end
            object User_SetPassword: TBitBtn
              Left = 117
              Top = 1
              Width = 115
              Height = 25
              Caption = 'Set Password'
              TabOrder = 1
              OnClick = User_SetPasswordClick
            end
            object User_Delete: TBitBtn
              Left = 233
              Top = 1
              Width = 115
              Height = 25
              Caption = 'Delete'
              TabOrder = 2
              OnClick = User_DeleteClick
            end
            object User_Refresh: TBitBtn
              Left = 349
              Top = 1
              Width = 115
              Height = 25
              Caption = 'Refresh'
              TabOrder = 3
              OnClick = User_RefreshClick
            end
          end
        end
        object TPage
          Left = 0
          Top = 0
          Caption = 'Groups'
          object ListView_Groups: TListView
            Left = 0
            Top = 26
            Width = 773
            Height = 449
            Align = alClient
            BorderStyle = bsNone
            Columns = <
              item
                Caption = 'Name'
                Width = 100
              end
              item
                Caption = 'Members Count'
                Width = 300
              end>
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
          object Panel7: TPanel
            Left = 0
            Top = 0
            Width = 773
            Height = 26
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object Group_Create: TBitBtn
              Left = 1
              Top = 1
              Width = 115
              Height = 25
              Caption = 'Create Group'
              TabOrder = 0
              OnClick = Group_CreateClick
            end
            object Group_AddtoGroup: TBitBtn
              Left = 117
              Top = 1
              Width = 115
              Height = 25
              Caption = 'Add to Group'
              TabOrder = 1
              OnClick = Group_AddtoGroupClick
            end
            object Group_Delete: TBitBtn
              Left = 233
              Top = 1
              Width = 115
              Height = 25
              Caption = 'Delete'
              TabOrder = 2
              OnClick = Group_DeleteClick
            end
            object Group_Refresh: TBitBtn
              Left = 349
              Top = 1
              Width = 115
              Height = 25
              Caption = 'Refresh'
              TabOrder = 3
              OnClick = Group_RefreshClick
            end
          end
        end
        object TPage
          Left = 0
          Top = 0
          Caption = 'Virtual Volumes'
          object ListView_Volume: TListView
            Left = 0
            Top = 26
            Width = 773
            Height = 449
            Align = alClient
            BorderStyle = bsNone
            Columns = <
              item
                Caption = 'Device Type'
                Width = 90
              end
              item
                Caption = 'Source'
                Width = 200
              end
              item
                Caption = 'Capacity'
                Width = 60
              end
              item
                Caption = 'Status'
              end
              item
                Caption = 'Description'
                Width = 200
              end
              item
                Caption = 'Write-Back Path'
                Width = 100
              end>
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
            OnDblClick = ListView_VolumeDblClick
            OnDeletion = ListView_VolumeDeletion
          end
          object Panel8: TPanel
            Left = 0
            Top = 0
            Width = 773
            Height = 26
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object Volume_Create: TBitBtn
              Left = 1
              Top = 1
              Width = 120
              Height = 25
              Caption = 'Create Virtual Volume'
              TabOrder = 0
              OnClick = Volume_CreateClick
            end
            object Volume_Online: TBitBtn
              Left = 121
              Top = 1
              Width = 120
              Height = 25
              Caption = 'Online'
              TabOrder = 1
              OnClick = Volume_OnlineClick
            end
            object Volume_Offline: TBitBtn
              Left = 242
              Top = 1
              Width = 120
              Height = 25
              Caption = 'Offline'
              TabOrder = 2
              OnClick = Volume_OfflineClick
            end
            object Volume_Delete: TBitBtn
              Left = 363
              Top = 1
              Width = 120
              Height = 25
              Caption = 'Delete'
              TabOrder = 3
              OnClick = Volume_DeleteClick
            end
            object Volume_Refresh: TBitBtn
              Left = 605
              Top = 1
              Width = 120
              Height = 25
              Caption = 'Refresh'
              TabOrder = 4
              OnClick = Volume_RefreshClick
            end
            object Volume_Attribute: TBitBtn
              Left = 484
              Top = 1
              Width = 120
              Height = 25
              Caption = 'Attribute'
              TabOrder = 5
              OnClick = Volume_AttributeClick
            end
          end
        end
        object TPage
          Left = 0
          Top = 0
          Caption = 'iSCSI Targets'
          object Splitter2: TSplitter
            Left = 0
            Top = 185
            Width = 773
            Height = 3
            Cursor = crVSplit
            Align = alTop
          end
          object Panel9: TPanel
            Left = 0
            Top = 0
            Width = 773
            Height = 185
            Align = alTop
            BevelOuter = bvNone
            Color = clGray
            TabOrder = 0
            object Panel11: TPanel
              Left = 0
              Top = 0
              Width = 773
              Height = 27
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 0
              object Target_Create: TBitBtn
                Left = 1
                Top = 1
                Width = 115
                Height = 25
                Caption = 'Create Target'
                TabOrder = 0
                OnClick = Target_CreateClick
              end
              object Target_Online: TBitBtn
                Left = 117
                Top = 1
                Width = 115
                Height = 25
                Caption = 'Online'
                TabOrder = 1
                OnClick = Target_OnlineClick
              end
              object Target_Offline: TBitBtn
                Left = 233
                Top = 1
                Width = 115
                Height = 25
                Caption = 'Offline'
                TabOrder = 2
                OnClick = Target_OfflineClick
              end
              object Target_Delete: TBitBtn
                Left = 349
                Top = 1
                Width = 115
                Height = 25
                Caption = 'Delete'
                TabOrder = 3
                OnClick = Target_DeleteClick
              end
              object Target_Refresh: TBitBtn
                Left = 581
                Top = 1
                Width = 180
                Height = 25
                Caption = 'Refresh (When click targets)'
                TabOrder = 4
                OnClick = Target_RefreshClick
              end
              object Target_Attribute: TBitBtn
                Left = 465
                Top = 1
                Width = 115
                Height = 25
                Caption = 'Attribute'
                TabOrder = 5
                OnClick = Target_AttributeClick
              end
            end
            object ListView_Target: TListView
              Left = 0
              Top = 27
              Width = 773
              Height = 158
              Align = alClient
              BorderStyle = bsNone
              Columns = <
                item
                  Caption = 'Target Name'
                  Width = 200
                end
                item
                  Caption = 'LUN Count'
                  Width = 70
                end
                item
                  Caption = 'Authentication'
                  Width = 90
                end
                item
                  Caption = 'Status'
                end>
              ReadOnly = True
              RowSelect = True
              TabOrder = 1
              ViewStyle = vsReport
              OnSelectItem = ListView_TargetSelectItem
            end
          end
          object Panel10: TPanel
            Left = 0
            Top = 188
            Width = 773
            Height = 287
            Align = alClient
            BevelOuter = bvNone
            Caption = 'Panel10'
            TabOrder = 1
            object ListView_SubTarget: TListView
              Left = 0
              Top = 52
              Width = 773
              Height = 235
              Align = alClient
              BorderStyle = bsNone
              Columns = <
                item
                  Caption = 'Computer Name'
                  Width = 100
                end
                item
                  Caption = 'IP Address'
                  Width = 100
                end
                item
                  Caption = 'MAC Address'
                  Width = 100
                end
                item
                  Caption = 'IN (M)'
                  Width = 60
                end
                item
                  Caption = 'OUT (M)'
                  Width = 60
                end
                item
                  Caption = 'Logon User'
                  Width = 80
                end
                item
                  Caption = 'Initiator Name'
                  Width = 200
                end
                item
                  Caption = 'Permission'
                  Width = 80
                end>
              ReadOnly = True
              RowSelect = True
              TabOrder = 0
              ViewStyle = vsReport
            end
            object Panel6: TPanel
              Left = 0
              Top = 0
              Width = 773
              Height = 52
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 1
              object TargetClient_Remove: TBitBtn
                Left = 1
                Top = 26
                Width = 115
                Height = 25
                Caption = 'Remove'
                TabOrder = 0
                OnClick = TargetClient_RemoveClick
              end
              object TargetClient_SetCommit: TBitBtn
                Left = 117
                Top = 26
                Width = 115
                Height = 25
                Caption = 'Set Commit'
                TabOrder = 1
                OnClick = TargetClient_SetCommitClick
              end
              object TargetClient_AddtoWorkstations: TBitBtn
                Left = 233
                Top = 26
                Width = 115
                Height = 25
                Caption = 'Add to Workstations'
                TabOrder = 2
                OnClick = TargetClient_AddtoWorkstationsClick
              end
              object TargetClient_Refresh: TBitBtn
                Left = 349
                Top = 26
                Width = 180
                Height = 25
                Caption = 'Refresh (When click selected target)'
                TabOrder = 3
                OnClick = TargetClient_RefreshClick
              end
              object Panel13: TPanel
                Left = 0
                Top = 0
                Width = 773
                Height = 24
                Align = alTop
                Alignment = taLeftJustify
                BevelOuter = bvNone
                Caption = '  Client of Selected Target'
                Color = clGray
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Default'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 4
              end
            end
          end
        end
        object TPage
          Left = 0
          Top = 0
          Caption = 'BootServer'
          object ListView_BootServer: TListView
            Left = 0
            Top = 26
            Width = 773
            Height = 449
            Align = alClient
            BorderStyle = bsNone
            Columns = <
              item
                Caption = 'Computer Name'
                Width = 100
              end
              item
                Caption = 'IP Address'
                Width = 100
              end
              item
                Caption = 'Mask'
                Width = 100
              end
              item
                Caption = 'Mac Address'
                Width = 100
              end
              item
                Caption = 'Permission'
                Width = 70
              end
              item
                Caption = 'Boot Target'
                Width = 200
              end>
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
          object Panel12: TPanel
            Left = 0
            Top = 0
            Width = 773
            Height = 26
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object BootServer_AddWorkstations: TBitBtn
              Left = 1
              Top = 1
              Width = 115
              Height = 25
              Caption = 'Add Workstation'
              TabOrder = 0
              OnClick = BootServer_AddWorkstationsClick
            end
            object BootServer_WakeupAll: TBitBtn
              Left = 117
              Top = 1
              Width = 115
              Height = 25
              Caption = 'Wakeup All'
              TabOrder = 1
              OnClick = BootServer_WakeupAllClick
            end
            object WorkStation_Attribute: TBitBtn
              Left = 233
              Top = 1
              Width = 115
              Height = 25
              Caption = 'Attribute'
              TabOrder = 2
              OnClick = WorkStation_AttributeClick
            end
            object BootServer_Delete: TBitBtn
              Left = 349
              Top = 1
              Width = 115
              Height = 25
              Caption = 'Delete'
              TabOrder = 3
              OnClick = BootServer_DeleteClick
            end
            object BootServer_Refresh: TBitBtn
              Left = 465
              Top = 1
              Width = 115
              Height = 25
              Caption = 'Refresh'
              TabOrder = 4
              OnClick = BootServer_RefreshClick
            end
            object BootServer_Attribute: TBitBtn
              Left = 581
              Top = 1
              Width = 115
              Height = 25
              Caption = 'BootServer Attribute'
              TabOrder = 5
              OnClick = BootServer_AttributeClick
            end
          end
        end
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 775
      Height = 27
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Panel_SelectedText: TPanel
        Left = 0
        Top = 0
        Width = 775
        Height = 24
        Align = alTop
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '  SmartDISK'
        Color = clGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Default'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  object Panel14: TPanel
    Left = 0
    Top = 0
    Width = 878
    Height = 27
    Align = alTop
    TabOrder = 2
    object BitBtn42: TBitBtn
      Left = 1
      Top = 1
      Width = 134
      Height = 25
      Caption = 'Connect to another server'
      TabOrder = 0
      OnClick = BitBtn42Click
    end
    object BitBtn43: TBitBtn
      Left = 137
      Top = 1
      Width = 134
      Height = 25
      Caption = 'SmartDisk iSCSI Attribute'
      TabOrder = 1
      OnClick = BitBtn43Click
    end
  end
  object MainMenu: TMainMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 152
    Top = 168
    object MainMenu_File: TMenuItem
      Caption = 'File'
      object MainMenu_File1: TMenuItem
        Caption = 'Option'
        OnClick = MainMenu_File1Click
      end
      object MainMenu_File2: TMenuItem
        Caption = 'Exit'
        OnClick = MainMenu_File2Click
      end
    end
    object MainMenu_Action: TMenuItem
      Caption = 'Action'
    end
    object MainMenu_Help: TMenuItem
      Caption = 'Help'
    end
  end
end
