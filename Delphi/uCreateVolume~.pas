unit uCreateVolume;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Spin, ComCtrls, uSANDeployServerApi;

type
  TfCreateVolume = class(TForm)
    Notebook: TNotebook;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    bBack: TBitBtn;
    bNext: TBitBtn;
    bCancel: TBitBtn;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    rbStandardImageFile: TRadioButton;
    rbVMwareVMDKFile: TRadioButton;
    rbPhysicalDisk: TRadioButton;
    rbDiskPartition: TRadioButton;
    rbVirtualCDImage: TRadioButton;
    rbPhysicalCDDrive: TRadioButton;
    rbSPTIDevice: TRadioButton;
    rbRAMDisk: TRadioButton;
    Image1: TImage;
    Image2: TImage;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label5: TLabel;
    edImageFile: TEdit;
    BitBtn1: TBitBtn;
    Panel18: TPanel;
    Label6: TLabel;
    SpinEdit1: TSpinEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    edPassword: TEdit;
    BitBtn2: TBitBtn;
    Image3: TImage;
    Label7: TLabel;
    Label8: TLabel;
    CheckBox4: TCheckBox;
    GroupBox1: TGroupBox;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    Label9: TLabel;
    Label10: TLabel;
    Image4: TImage;
    Label11: TLabel;
    Label12: TLabel;
    CheckBox5: TCheckBox;
    GroupBox2: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    SpinEdit5: TSpinEdit;
    edVirtualWritePath: TEdit;
    Label15: TLabel;
    cmbBlockSize: TComboBox;
    Image5: TImage;
    Label16: TLabel;
    Label17: TLabel;
    GroupBox3: TGroupBox;
    Memo: TMemo;
    Panel20: TPanel;
    Label18: TLabel;
    Label19: TLabel;
    Image6: TImage;
    Panel21: TPanel;
    Panel22: TPanel;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Label20: TLabel;
    edVMDKFile: TEdit;
    BitBtn3: TBitBtn;
    Panel23: TPanel;
    Label21: TLabel;
    SpinEdit4: TSpinEdit;
    Panel24: TPanel;
    Panel25: TPanel;
    Panel26: TPanel;
    Label22: TLabel;
    Label23: TLabel;
    Image7: TImage;
    Label24: TLabel;
    cmbDisk: TComboBox;
    CheckBox6: TCheckBox;
    Panel27: TPanel;
    Panel28: TPanel;
    Panel29: TPanel;
    Label25: TLabel;
    cmbDrive: TComboBox;
    CheckBox7: TCheckBox;
    Label26: TLabel;
    Label27: TLabel;
    Image8: TImage;
    Panel30: TPanel;
    Panel31: TPanel;
    Panel32: TPanel;
    Label28: TLabel;
    Label29: TLabel;
    Image9: TImage;
    Label30: TLabel;
    edCDFile: TEdit;
    BitBtn4: TBitBtn;
    Panel33: TPanel;
    Panel34: TPanel;
    Panel35: TPanel;
    Label31: TLabel;
    Label32: TLabel;
    Image10: TImage;
    Label33: TLabel;
    cmbCD: TComboBox;
    Panel36: TPanel;
    Panel37: TPanel;
    Panel38: TPanel;
    Label34: TLabel;
    Label35: TLabel;
    Image11: TImage;
    Label36: TLabel;
    ListView_BootServer: TListView;
    Panel39: TPanel;
    Panel40: TPanel;
    Panel41: TPanel;
    Label37: TLabel;
    CheckBox8: TCheckBox;
    SpinEdit6: TSpinEdit;
    Label38: TLabel;
    edRAM: TEdit;
    BitBtn5: TBitBtn;
    Label39: TLabel;
    Label40: TLabel;
    Image12: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bNextClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure bBackClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
  private
    { Private declarations }
    FIScsiTarget: TIScsiTarget;
    function GetDefaultVolumeName(mt: ISCSI_TARGET_MEDIA_TYPES): string;
    procedure GetScsiDevices;
    procedure GetPartitions(Strings: TStrings);
  public
    { Public declarations }
    VolumeHandle: KHANDLE;
    IsAdd: Boolean;
  end;

var
  fCreateVolume: TfCreateVolume;

implementation

uses
  Math, uUtils;

function DeviceTypeString(nDeviceType: Integer): string;
begin
  Result:= 'Unknown';
  case nDeviceType of
		0: Result:= 'Hard Disk';
		1: Result:= 'Tape';
		5: Result:= 'CD/DVD-ROM/RW';
		$ff: Result:= 'Other Scsi Device';
  end;
end;

{$R *.dfm}

procedure TfCreateVolume.FormCreate(Sender: TObject);
begin
  IsAdd := False;
end;

procedure TfCreateVolume.FormShow(Sender: TObject);
begin
  bBack.Enabled := False;
  Notebook.PageIndex := 0;

  // Work... Load data
end;

procedure TfCreateVolume.bNextClick(Sender: TObject);
var
  dwRet: Longword;
  nSize: Int64;
  s: string;
begin
  Case Notebook.PageIndex of
     // 1. Select iSCSI Media
     0: begin
          bBack.Enabled := True;
          if rbStandardImageFile.Checked then
          begin
            Notebook.PageIndex := 1;
            FIScsiTarget.iScsiTargetMediaType:= ISCSI_TARGET_MEDIA_TYPE_FILE_IAMGE;
            FIScsiTarget.iScsiTargetDeviceType:= ISCSI_TARGET_TYPE_DISK;
          end
          else if rbVMwareVMDKFile.Checked then
          begin
            FIScsiTarget.iScsiTargetMediaType:= ISCSI_TARGET_MEDIA_TYPE_FILE_IAMGE;
            FIScsiTarget.iScsiTargetDeviceType:= ISCSI_TARGET_TYPE_DISK;
            Notebook.PageIndex := 2;
          end
          else if rbPhysicalDisk.Checked then
          begin
            FIScsiTarget.iScsiTargetMediaType:= ISCSI_TARGET_MEDIA_TYPE_DISK;
            FIScsiTarget.iScsiTargetDeviceType:= ISCSI_TARGET_TYPE_DISK;
            ReadPhysicalDrive(cmbDisk.Items);
            if cmbDisk.Items.Count > 0 then
              cmbDisk.ItemIndex:= 0;
            Notebook.PageIndex := 3;
          end
          else if rbDiskPartition.Checked then
          begin
            FIScsiTarget.iScsiTargetMediaType:= ISCSI_TARGET_MEDIA_TYPE_DRIVE_PARTITION;
            FIScsiTarget.iScsiTargetDeviceType:= ISCSI_TARGET_TYPE_DISK;
            GetPartitions(cmbDrive.Items);
            if cmbDrive.Items.Count > 0 then
              cmbDrive.ItemIndex:= 0;
            Notebook.PageIndex := 4;
          end
          else if rbVirtualCDImage.Checked then
          begin
            FIScsiTarget.iScsiTargetMediaType:= ISCSI_TARGET_MEDIA_TYPE_FILE_IAMGE;
            FIScsiTarget.iScsiTargetDeviceType:= ISCSI_TARGET_TYPE_CDROM;
            Notebook.PageIndex := 5;
          end
          else if rbPhysicalCDDrive.Checked then
          begin
            FIScsiTarget.iScsiTargetMediaType:= ISCSI_TARGET_MEDIA_TYPE_CDROM;
            FIScsiTarget.iScsiTargetDeviceType:= ISCSI_TARGET_TYPE_CDROM;
            Notebook.PageIndex := 6;
          end
          else if rbSPTIDevice.Checked then
          begin
            FIScsiTarget.iScsiTargetMediaType:= ISCSI_TARGET_MEDIA_TYPE_SCSI;
            FIScsiTarget.iScsiTargetDeviceType:= ISCSI_TARGET_TYPE_SCSI;
            GetScsiDevices();
            Notebook.PageIndex := 7;
          end
          else if rbRAMDisk.Checked then
          begin
            FIScsiTarget.iScsiTargetMediaType:= ISCSI_TARGET_MEDIA_TYPE_MEMORY;
            FIScsiTarget.iScsiTargetDeviceType:= ISCSI_TARGET_TYPE_DISK;
            Notebook.PageIndex := 8;
          end;
        end;

     // 2-1. Select Standard Image File
     // 2-2. Select VMware VMDK File
     // 2-3. Select Physical Disk
     // 2-4. Select Disk Partition
     // 2-5. Select Virtual CD/DVD Image File
     // 2-6. Select Physical CD/DVD/RW Drive
     // 2-7. Select SPTI Devices
     // 2-8. Select RAM Disk
     1:
     begin
       FillChar(FIScsiTarget.FileName[0], SizeOf(FIScsiTarget.FileName), 0);
       FillChar(FIScsiTarget.Password[0], SizeOf(FIScsiTarget.Password), 0);
       FIScsiTarget.Params.ImageFile.CreateFlags:= 0;

       FIScsiTarget.Params.ImageFile.CreateNew:= RadioButton1.Checked;
       StrPCopy(@FIScsiTarget.FileName[0], edImageFile.Text);
       nSize:= Int64(SpinEdit1.Value) * 1024 * 1024;
       FIScsiTarget.DeviceSize.QuadPart:= nSize;
       FIScsiTarget.Params.ImageFile.UseSparse:= CheckBox1.Checked;
       if CheckBox2.Checked then
         FIScsiTarget.Params.ImageFile.CreateFlags:=
           FIScsiTarget.Params.ImageFile.CreateFlags or ISCSI_CREATE_FLAG_IMG_COMPRESSED;
       if CheckBox3.Checked then
       begin
         FIScsiTarget.Params.ImageFile.CreateFlags:=
           FIScsiTarget.Params.ImageFile.CreateFlags or ISCSI_CREATE_FLAG_IMG_ENCRYPTED;
         if edPassword.Text = '' then
         begin
           Application.MessageBox('Please enter the password!', nil, MB_OK or MB_ICONWARNING);
           Exit;
         end
         else
           StrPCopy(@FIScsiTarget.Password[0], edPassword.Text);
       end;
       Notebook.PageIndex := 9;
     end;
     2:
     begin
       FillChar(FIScsiTarget.FileName[0], SizeOf(FIScsiTarget.FileName), 0);
       FillChar(FIScsiTarget.Password[0], SizeOf(FIScsiTarget.Password), 0);
       FIScsiTarget.Params.ImageFile.CreateFlags:= 0;
       FIScsiTarget.Params.ImageFile.UseSparse:= False;

       FIScsiTarget.Params.ImageFile.CreateNew:= RadioButton3.Checked;
       StrPCopy(@FIScsiTarget.FileName[0], edVMDKFile.Text);
       nSize:= Int64(SpinEdit4.Value) * 1024 * 1024;
       FIScsiTarget.DeviceSize.QuadPart:= nSize;

       Notebook.PageIndex := 9;
     end;
     3:
     begin
       FillChar(FIScsiTarget.FileName[0], SizeOf(FIScsiTarget.FileName), 0);
       s:= Format('\\.\PhysicalDrive%d', [Integer(cmbDisk.Items.Objects[cmbDisk.ItemIndex])]);
       StrPCopy(@FIScsiTarget.FileName[0], s);
       FIScsiTarget.bReportReadonly:= CheckBox6.Checked;
       GetDiskSize(PChar(s), @FIScsiTarget.DeviceSize);
       Notebook.PageIndex := 9;
     end;
     4:
     begin
       if cmbDrive.Text = '' then
       begin
         Application.MessageBox('Please select the partition which you want to create volume with it!', nil, MB_OK or MB_ICONWARNING);
         Exit;
       end;
       FillChar(FIScsiTarget.FileName[0], SizeOf(FIScsiTarget.FileName), 0);
       s:= '\\.\' + cmbDrive.Text;
       StrPCopy(@FIScsiTarget.FileName[0], s);
       FIScsiTarget.bReportReadonly:= CheckBox7.Checked;
       GetVolumeSize(PChar(s), @FIScsiTarget.DeviceSize);
       Notebook.PageIndex := 9;
     end;
     5:
     begin
       FillChar(FIScsiTarget.FileName[0], SizeOf(FIScsiTarget.FileName), 0);
       StrPCopy(@FIScsiTarget.FileName[0], edCDFile.Text);
       Notebook.PageIndex := 9;
     end;
     6:
     begin
       FillChar(FIScsiTarget.FileName[0], SizeOf(FIScsiTarget.FileName), 0);
       StrPCopy(@FIScsiTarget.FileName[0], cmbCD.Text);
       Notebook.PageIndex := 9;
     end;
     7:
     begin
       if (ListView_BootServer.Selected = nil) then
       begin
         Application.MessageBox('Please select a SPTI device first!', nil, MB_OK or MB_ICONWARNING);
         Exit;
       end;
       FillChar(FIScsiTarget.FileName[0], SizeOf(FIScsiTarget.FileName), 0);
       StrPCopy(@FIScsiTarget.FileName[0], ListView_BootServer.Selected.Caption);
       Notebook.PageIndex := 9;
     end;
     8:
     begin
       FillChar(FIScsiTarget.FileName[0], SizeOf(FIScsiTarget.FileName), 0);
       StrPCopy(@FIScsiTarget.FileName[0], edRAM.Text);
       FIScsiTarget.DeviceSize.QuadPart:= SpinEdit6.Value * 1024 * 1024;
       FIScsiTarget.bReportReadonly:= CheckBox8.Checked;
       Notebook.PageIndex := 9;
     end;

     // 3. High Speed Cache Setting
     9:
     begin
       FillChar(FIScsiTarget.Cache, SizeOf(FIScsiTarget.Cache), 0);
       FIScsiTarget.Cache.EnableCache:= CheckBox4.Checked;
       if FIScsiTarget.Cache.EnableCache then
       begin
         nSize:= Int64(SpinEdit2.Value) * 1024 * 1024;
         FIScsiTarget.Cache.CacheSize.QuadPart:= nSize;
         FIScsiTarget.Cache.RefreshTime:= SpinEdit3.Value;
       end;
       
       Notebook.PageIndex := 10;
     end;

    // 4. Write-Back Cache Setting
    10:
    begin
      FillChar(FIScsiTarget.VirtualWritePath, SizeOf(FIScsiTarget.VirtualWritePath), 0);
      FIScsiTarget.VirtualWriteMode:= Integer(CheckBox5.Checked);
      if CheckBox5.Checked then
      begin
        if edVirtualWritePath.Text = '' then
        begin
          Application.MessageBox('Please enter the write-back path!', nil, MB_OK or MB_ICONWARNING);
          Exit;
        end
        else
          StrPCopy(@FIScsiTarget.VirtualWritePath, edVirtualWritePath.Text);
        nSize:= Int64(SpinEdit5.Value) * 1024 * 1024;
        FIScsiTarget.VirtualWriteQuota.QuadPart:= nSize;
        case cmbBlockSize.ItemIndex of
          0: FIScsiTarget.StartOffset.QuadPart:= 2048;
          1: FIScsiTarget.StartOffset.QuadPart:= 4096;
          2: FIScsiTarget.StartOffset.QuadPart:= 8192;
          3: FIScsiTarget.StartOffset.QuadPart:= 16384;
          4: FIScsiTarget.StartOffset.QuadPart:= 32768;
          5: FIScsiTarget.StartOffset.QuadPart:= 65535;
        end;
      end;
      Memo.Text:= GetDefaultVolumeName(FIScsiTarget.iScsiTargetMediaType);
      Notebook.PageIndex := 11;
      bNext.Caption := 'Finish';
    end;

    // 5. Finish
    11: begin
          // Work ... Save data
          if Memo.Text <> '' then
            StrPCopy(@FIScsiTarget.TargetName[0], Memo.Text);
          FIScsiTarget.bEnable:= True;
          dwRet:= uSANDeployServerApi.AddTarget(VolumeHandle, FIScsiTarget);
          IsAdd := dwRet = 0;
          if (dwRet = 0) then
            Application.MessageBox('Create volume successful!', nil, MB_OK or MB_ICONINFORMATION)
          else
            Application.MessageBox('Create volume failed!', nil, MB_OK or MB_ICONWARNING);
            
          Close;
        end;
  end;
end;

procedure TfCreateVolume.bCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfCreateVolume.bBackClick(Sender: TObject);
begin
  Case Notebook.PageIndex of
     // 1. Select iSCSI Media
     0: begin
        end;

     // 2-1. Select Standard Image File
     // 2-2. Select VMware VMDK File
     // 2-3. Select Physical Disk
     // 2-4. Select Disk Partition
     // 2-5. Select Virtual CD/DVD Image File
     // 2-6. Select Physical CD/DVD/RW Drive
     // 2-7. Select SPTI Devices
     // 2-8. Select RAM Disk
     1, 2, 3, 4, 5, 6, 7, 8:
        begin
          bBack.Enabled := False;
          Notebook.PageIndex := 0;
        end;

     // 3. High Speed Cache Setting
     9: begin
          if rbStandardImageFile.Checked then Notebook.PageIndex := 1 else
          if rbVMwareVMDKFile.Checked    then Notebook.PageIndex := 2 else
          if rbPhysicalDisk.Checked      then Notebook.PageIndex := 3 else
          if rbDiskPartition.Checked     then Notebook.PageIndex := 4 else
          if rbVirtualCDImage.Checked    then Notebook.PageIndex := 5 else
          if rbPhysicalCDDrive.Checked   then Notebook.PageIndex := 6 else
          if rbSPTIDevice.Checked        then Notebook.PageIndex := 7 else
          if rbRAMDisk.Checked           then Notebook.PageIndex := 8;
        end;

    // 4. Write-Back Cache Setting
    10: begin
          Notebook.PageIndex := 9;
        end;

    // 5. Finish
    11: begin
          Notebook.PageIndex := 10;
          bNext.Caption := 'Next >';
        end;
  end;
end;

procedure TfCreateVolume.BitBtn2Click(Sender: TObject);
begin
  if edPassword.PasswordChar <> #0 then
    edPassword.PasswordChar:= #0
  else
    edPassword.PasswordChar:= '*';
end;

procedure TfCreateVolume.BitBtn1Click(Sender: TObject);
var
  od: TOpenDialog;
begin
  od:= TOpenDialog.Create(Self);
  try
    if od.Execute then
      edImageFile.Text:= od.FileName;
  finally
    od.Free;
  end;
end;

procedure TfCreateVolume.GetScsiDevices;
var
  dwRet: Longword;
  arrSSDD: array[0..63] of SPTI_SCSI_DEVICE_DESP;
  dwCount, I: Longword;
  Item: TListItem;
begin
  ListView_BootServer.Clear;
  FillChar(arrSSDD, SizeOf(arrSSDD), 0);
  dwCount:= SizeOf(arrSSDD);
  dwRet:= uSANDeployServerApi.GetScsiDevices(dwCount, arrSSDD[0]);
  if dwRet = 0 then
  begin
    dwCount:= dwCount div SizeOf(SPTI_SCSI_DEVICE_DESP);
    if dwCount = 0 then
      Exit;
    for I:= 0 to dwCount-1 do
    begin
      Item:= ListView_BootServer.Items.Add();
      Item.Caption:= StrPas(@arrSSDD[I].DeviceName[0]);
      Item.SubItems.Add(StrPas(@arrSSDD[I].Description[0]));
      Item.SubItems.Add(DeviceTypeString(arrSSDD[I].DeviceType));
    end;
  end;
end;

procedure TfCreateVolume.GetPartitions(Strings: TStrings);
var
  sl: TStringList;
  str: string;
  dwLen: Longword;
  i: Integer;
begin
  if Strings = nil then
    Exit;
  Strings.Clear;
  sl:= TStringList.Create;
  try
    dwLen:= 1024;
    SetLength(str, dwLen);
    dwLen:= GetLogicalDriveStrings(dwLen, @str[1]);
    if dwLen = 0 then
      Exit;
    for i := 1 to dwLen do
      if Byte(str[i]) = 0 then
        str[i] := #13;
    sl.Text := str;
    for i:= sl.Count-1 downto 0 do
    begin
      if GetDriveType(PChar(sl[i])) <> DRIVE_FIXED then
        sl.Delete(i)
      else
        sl[i]:= Copy(sl[i], 1, Length(sl[i])-1);
    end;
    Strings.Assign(sl);
  finally
    sl.Free;
  end;
end;

procedure TfCreateVolume.BitBtn3Click(Sender: TObject);
var
  od: TOpenDialog;
begin
  od:= TOpenDialog.Create(Self);
  try
    od.Filter:= 'VMDK Image(*.vmdk)|*.vmdk';
    if od.Execute then
      edVMDKFile.Text:= od.FileName;
  finally
    od.Free;
  end;
end;

function TfCreateVolume.GetDefaultVolumeName(mt: ISCSI_TARGET_MEDIA_TYPES): string;
const
  cVolumeNameFormat = 'iqn.%.4d-%.2d.com.smatdisk.volume.%s.%2d%.2d%.2d%.2d';
var
  st: TSystemTime;
  s: string;
begin
  case mt of
    ISCSI_TARGET_MEDIA_TYPE_MEMORY: s:= 'RAM';
		ISCSI_TARGET_MEDIA_TYPE_FILE_IAMGE: s:= 'ImageFile';
		ISCSI_TARGET_MEDIA_TYPE_FILE_INDIVIDUAL_IAMGE: s:= 'IndividualImageFile';
		ISCSI_TARGET_MEDIA_TYPE_DRIVE_PARTITION: s:= 'Partition';
		ISCSI_TARGET_MEDIA_TYPE_DISK: s:= 'Disk';
		ISCSI_TARGET_MEDIA_TYPE_CDROM: s:= 'CDROM';
		ISCSI_TARGET_MEDIA_TYPE_SCSI: s:= 'SCSI';
		ISCSI_TARGET_MEDIA_TYPE_MIRROR: s:= 'Mirror';
		ISCSI_TARGET_MEDIA_TYPE_VHD: s:= 'VHD';
		ISCSI_TARGET_MEDIA_TYPE_VMDK: s:= 'VMDK';
		ISCSI_TARGET_MEDIA_TYPE_TAPE: s:= 'Tape';
  end;
  try
    GetLocalTime(st);
    Result:= Format(cVolumeNameFormat, [st.wYear, st.wMonth, s, st.wDay, st.wHour, st.wMinute, st.wSecond]);
  except

  end;
end;

procedure TfCreateVolume.BitBtn5Click(Sender: TObject);
var
  od: TOpenDialog;
begin
  od:= TOpenDialog.Create(Self);
  try
    if od.Execute then
      edRAM.Text:= od.FileName;
  finally
    od.Free;
  end;
end;

end.

