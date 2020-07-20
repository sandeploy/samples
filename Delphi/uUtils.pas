unit uUtils;

interface

uses
  Windows, SysUtils, Classes;

function FormatSize(AFileSize: Int64): string;
procedure ReadPhysicalDrive(Strings: TStrings);

implementation

uses
  uSANDeployServerApi;

type
  TStorage_Query_Type = (
    PropertyStandardQuery,          // Retrieves the descriptor
    PropertyExistsQuery,                // Used to test whether the descriptor is supported
    PropertyMaskQuery,                  // Used to retrieve a mask of writeable fields in the descriptor
    PropertyQueryMaxDefined     // use to validate the value
    );

  TSTORAGE_PROPERTY_ID = (
      StorageDeviceProperty = 0,
      StorageAdapterProperty
      );

  TSTORAGE_BUS_TYPE = (
    BusTypeUnknown       = $00,
    BusTypeScsi          = $01,
    BusTypeAtapi         = $02,
    BusTypeAta           = $03,
    BusType1394          = $04,
    BusTypeSsa           = $05,
    BusTypeFibre         = $06,
    BusTypeUsb           = $07,
    BusTypeRAID          = $08,
    BusTypeiSCSI         = $09,
    BusTypeSas           = $0A,
    BusTypeSata          = $0B,
    BusTypeMaxReserved   = $7F
  );

  TSTORAGE_PROPERTY_QUERY = packed record
    PropertyId: Longword;
    QueryType: Longword;
    AdditionalParameters: array[0..3] of Byte;
  end;

  TSTORAGE_DEVICE_DESCRIPTOR = packed record
    Version: Longword;
    Size: Longword;
    DeviceType: Byte;
    DeviceTypeModifier: Byte;
    RemovableMedia: Boolean;
    CommandQueueing: Boolean;
    VendorIdOffset: Longword;
    ProductIdOffset: Longword;
    ProductRevisionOffset: Longword;
    SerialNumberOffset: Longword;
    STORAGE_BUS_TYPE: DWORD;
    RawPropertiesLength: Longword;
    RawDeviceProperties: array[0..511] of Byte;
  end;

  PSTORAGE_DEVICE_DESCRIPTOR = ^TSTORAGE_DEVICE_DESCRIPTOR;

const
  MAX_IDE_DRIVES = 16;
  METHOD_BUFFERED   =   0;

  FILE_ANY_ACCESS   =   0;
  FILE_READ_ACCESS  = 1;    (* file & pipe *)
  FILE_WRITE_ACCESS = 2;    (* file & pipe *)


  FILE_DEVICE_DISK           = $00000007;
  FILE_DEVICE_MASS_STORAGE   =   $0000002D;

  IOCTL_STORAGE_BASE   =   FILE_DEVICE_MASS_STORAGE;
  IOCTL_DISK_BASE = FILE_DEVICE_DISK;

  IOCTL_STORAGE_QUERY_PROPERTY   =   ((IOCTL_STORAGE_BASE   shl   16)   or   (FILE_ANY_ACCESS   shl   14)   or
      ($0500   shl   2)   or   METHOD_BUFFERED);



procedure ChangeByteOrder(var Data; Size : Integer);
var
  p : PAnsiChar;
  i : Integer;
  c : AnsiChar;
begin
  p := @Data;
  for i := 0 to (Size shr 1)-1 do
  begin
    c := p^;
    p^ := (p+1)^;
    (p+1)^ := c;
    Inc(p, 2);
  end;
end;

function FlipAndCodeBytes(const pInput: PAnsiChar; position: Integer; flip: Boolean;
  pOutput: PAnsiChar): Boolean;

  function IsSpace(c: AnsiChar): Boolean;
  begin
    Result:= (c = ' ') or (c = #9) or (c = #10);
  end;

  function ToLower(c: AnsiChar): AnsiChar;
  begin
    if (c >= 'A') and (c <= 'Z') then
      Result:= Chr(ord(c) + 32)
    else
      Result:= c;
  end;

  function IsPrint(c: AnsiChar): Boolean;
  begin
    Result:= (c >= ' ') and (c <= '~'); 
  end;

  function HexChar(c: Char): Byte;
  begin
    case c of
      '0'..'9':  Result := Byte(c) - Byte('0');
      'a'..'f':  Result := (Byte(c) - Byte('a')) + 10;
      'A'..'F':  Result := (Byte(c) - Byte('A')) + 10;
    else
      Result := 0;
    end;
  end;

  function HexByte(p: PAnsiChar): AnsiChar;
  begin
    Result := AnsiChar((HexChar(p[0]) shl 4) + HexChar(p[1]));
  end;

var
  i, j, k, p: Integer;
  c: AnsiChar;
  HexChars: array[0..1] of AnsiChar;
begin
  Result:= False;
  if (pInput = nil) or (pOutput = nil) or (position < 0) then
    Exit;
    
  i:= 0;
  j:= 0;
  k:= 0;

  if (j = 0) then
  begin
    p := 0;
	  j:= 1;
	  k:= 0;
	  pOutput[k]:= #0;
//    MessageBox(0, PAnsiChar(IntToStr(position)), nil, MB_OK);
//    MessageBox(0, PAnsiChar(Integer(pInput)+position), nil, MB_OK);
    i:= position;
    // First try to gather all characters representing hex digits only.
    while (pInput[i] <> #0) do
    begin
      c:= ToLower(pInput[i]);

      if (IsSpace(c)) then
        c:= '0';

      if (c in ['0'..'9']) or (c in ['a'..'f']) then
        HexChars[p] := c
      else
      begin
        j:= 0;
        break;
      end;

      inc(p);

      if p = 2 then
      begin
        pOutput[k]:= HexByte(@HexChars[0]);
        if not IsPrint(pOutput[k]) then
        begin
          j:= 0;
          break;
        end;
        Inc(k);
        p:= 0;
        pOutput[k]:= #0;
      end;

      Inc(i);
    end;
  end;

  // There are non-digit characters, gather them as is.
  if (j = 0) then
  begin
    j:= 1;
	  k:= 0;
    while (pInput[i] <> #0) do
    begin
      c:= pInput[i];
      if not IsPrint(c) then
      begin
        j:= 0;
        break;
      end;
      pOutput[k]:= c;
      Inc(k);
      Inc(i);
	  end;
  end;

  // The characters are not there or are not printable.
  if (j = 0) then
    k:= 0;

  pOutput[k]:= #0;

  if flip then
	  // Flip adjacent characters
  begin
    j:= 0;
    while j < k do
    begin
      c:= pOutput[j];
      pOutput[j]:= pOutput[j+1];
      pOutput[j+1]:= c;
      Inc(j, 2);
    end;
  end;

  i:= -1;
  j:= -1;
  k:= 0;
  while (pOutput[k] <> #0) do
  begin
    if not IsSpace(pOutput[k]) then
    begin
      if (i < 0) then
        i:= k;
      j:= k;
    end;
    inc(k);
  end;

  if ((i >= 0) and (j >= 0)) then
  begin
    k:= i;
    while (k <= j) and (pOutput[k] <> #0) do
    begin
      pOutput[k-i]:= pOutput[k];
      Inc(k);
    end;
    pOutput[k-i]:= #0;
  end;
  
  Result:= True;
end;

procedure ReadPhysicalDrive(Strings: TStrings);
var
  iDrive: Integer;
  hPhysicalDriveIOCTL: THandle;
  DriveName: string;
  query: TSTORAGE_PROPERTY_QUERY;
  desc: TSTORAGE_DEVICE_DESCRIPTOR;
  cbBytesReturned: Longword;
  Buffer: array[0..8191] of AnsiChar;
  ProductName: array[0..1023] of AnsiChar;
  psdd: PSTORAGE_DEVICE_DESCRIPTOR;
  diskSize: _LARGE_INTEGER;
  str, strSize: string;
begin
  cbBytesReturned:= 0;
  for iDrive := 0 to MAX_IDE_DRIVES - 1 do
  begin
    DriveName:= Format('\\.\PhysicalDrive%d', [iDrive]);
    hPhysicalDriveIOCTL:= CreateFile(PChar(DriveName), 0,
                               FILE_SHARE_READ or FILE_SHARE_WRITE , nil,
                               OPEN_EXISTING, 0, 0);

    if (hPhysicalDriveIOCTL = INVALID_HANDLE_VALUE) then
      Continue
    else
    begin
      FillChar(Buffer[0], SizeOf(Buffer), 0);
      FillChar(ProductName[0], SizeOf(ProductName), 0);
      FillChar(query, SizeOf(query), 0);
//  	  query.PropertyId:= StorageDeviceProperty;
//		  query.QueryType:= PropertyStandardQuery;
      FillChar(desc, SizeOf(desc), 0);
      desc.Size:= SizeOf(desc);
      if DeviceIoControl(hPhysicalDriveIOCTL, IOCTL_STORAGE_QUERY_PROPERTY,
        @query, SizeOf(query), @Buffer[0], SizeOf(Buffer), cbBytesReturned, nil) then
      begin
        psdd:= PSTORAGE_DEVICE_DESCRIPTOR(@Buffer[0]);
        if (psdd <> nil) and (psdd^.ProductIdOffset > 0) and (psdd^.ProductIdOffset < cbBytesReturned)
          and FlipAndCodeBytes(@Buffer[0], psdd^.ProductIdOffset, False, @ProductName[0]) then
        begin
          strSize:= '';
          if (uSANDeployServerApi.GetDiskSize(PAnsiChar(DriveName), @diskSize) = 0) then
            strSize:= FormatSize(diskSize.QuadPart);
//          ChangeByteOrder(modelName[0], SizeOf(modelName));
          str:= Format('%s-%s-%s', [DriveName, StrPas(@ProductName[0]), strSize]);
          Strings.AddObject(str, TObject(iDrive))
        end;
      end;
      CloseHandle(hPhysicalDriveIOCTL);
    end;
  end;
end;

function FormatSize(AFileSize: Int64): string;
const
  cOneGB: Int64 = 1024 * 1024 * 1024;
  cOneMB: Int64 = 1024 * 1024;
  cOneKB: Int64 = 1024;
begin
  if (AFileSize >= cOneGB) then
    Result := Format('%4.1f GB', [AFileSize / cOneGB])
  else if (AFileSize >= cOneMB) then
    Result := Format('%4.1f MB', [AFileSize / cOneMB])
  else
    Result := Format('%4.1f KB', [AFileSize / cOneKB]);
end;


end.
