// Samples.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <windows.h>
#include "../SANDeployServerApi/SANDeployServerApi.h"

BOOL g_bConnected = FALSE;

DWORD Connect()
{
	DWORD dwRet = ConnectTo("127.0.0.1",3261,"admin","sandeploy",TRUE);

	if(!dwRet)
		g_bConnected = TRUE;

	return dwRet;
}

DWORD CreateHDTarget()
{
	ISCSI_TARGET Target;

	strcpy(Target.TargetName,"iqn.2008-08.com.sandeploy:testserver.testtarget");
	Target.ID = -1;
	Target.bEnable = TRUE;
	Target.iScsiTargetMediaType = ISCSI_TARGET_MEDIA_TYPE_DISK;
	Target.iScsiTargetDeviceType = ISCSI_TARGET_TYPE_DISK;
	Target.ulAuthMode = ISCSI_AUTH_MODE_ANONYMOUS;	
	Target.bLockVolume = FALSE;
	Target.bMultipleInitiator = FALSE;
	Target.bReportReadonly = FALSE;
	//	unsigned char						HardSerial[8];
	Target.DeviceSize.QuadPart = 0;
	Target.StartOffset.QuadPart = 0;
	Target.InheritAuthorization = TRUE;
	Target.InheritTargetPortal = TRUE;
	Target.VirtualWriteMode = ISCSI_VIRTUAL_MODE_NONE;
	Target.VirtualWriteQuota.QuadPart = 0;
	//	ISCSI_TARGET_PORTAL					Portal[MAX_PORTAL_ADDRESS];
	strcpy(Target.FileName,"\\\\.\\PhysicalDrive1");
	//	CHAR								VirtualWritePath[MAX_PATH];
	Target.Cache.EnableCache = FALSE;
	Target.Params.PhysicalDisk.ExclusiveAccess = FALSE;

	KHANDLE hTarget;

	return AddTarget(&hTarget,&Target);
}

DWORD DeleteTarget()
{
	KHANDLE hStart = NULL;
	DWORD dwRet = 0;

	while(TRUE)
	{
		dwRet = FindNextTarget(hStart,&hStart);
		if(!hStart || dwRet)
			break;

		ISCSI_TARGET Target;

		GetTargetConfig(hStart,&Target);

		if(stricmp(Target.TargetName,"iqn.2008-08.com.sandeploy:testserver.testtarget") == 0)
		{
			return DeleteTarget(hStart);
		}
	}

	return dwRet;
}

DWORD CreateVolumeTarget(CHAR *VolumePath)
{
	ISCSI_TARGET Target;

	strcpy(Target.TargetName,"iqn.2008-08.com.sandeploy:testserver.testtarget");
	Target.ID = -1;
	Target.bEnable = TRUE;
	Target.iScsiTargetMediaType = ISCSI_TARGET_MEDIA_TYPE_DRIVE_PARTITION;
	Target.iScsiTargetDeviceType = ISCSI_TARGET_TYPE_DISK;
	Target.ulAuthMode = ISCSI_AUTH_MODE_ANONYMOUS;	
	Target.bLockVolume = FALSE;
	Target.bMultipleInitiator = FALSE;
	Target.bReportReadonly = FALSE;
	//	unsigned char						HardSerial[8];
	Target.DeviceSize.QuadPart = 0;
	Target.StartOffset.QuadPart = 0;
	Target.InheritAuthorization = TRUE;
	Target.InheritTargetPortal = TRUE;
	Target.VirtualWriteMode = ISCSI_VIRTUAL_MODE_NONE;
	Target.VirtualWriteQuota.QuadPart = 0;
	//	ISCSI_TARGET_PORTAL					Portal[MAX_PORTAL_ADDRESS];
	strcpy(Target.FileName,VolumePath);
	//	CHAR								VirtualWritePath[MAX_PATH];
	Target.Cache.EnableCache = FALSE;
	Target.Params.PartitionToDisk.ExclusiveAccess = FALSE;

	Target.Params.PartitionToDisk.MakeBootRecordFlags = 0;  //0, ISCSI_TARGET_BR_MBR or ISCSI_TARGET_BR_GPT

	KHANDLE hTarget;

	return AddTarget(&hTarget,&Target);
}

DWORD ListVolumes()
{
	ISCSI_VOLUMES TempVolume;
	DWORD	dwLength;
	
	DWORD dwRet = GetVolumes(&TempVolume,0,&dwLength);
	if(dwRet == SANDEPLOY_ERR_BUFFER_OVERFLOW)
	{
		PISCSI_VOLUMES pVolumes = new ISCSI_VOLUMES[dwLength / sizeof(ISCSI_VOLUMES)];
		dwRet = GetVolumes(pVolumes,dwLength,&dwLength);
		if(!dwRet)
		{
			for(int i=0;i<dwLength / sizeof(ISCSI_VOLUMES); i++)
			{
				printf(pVolumes[i].Letter);
				printf("\t");
				printf(pVolumes[i].DeviceName);
				printf("\r\n");
			}
		}

		delete [] pVolumes;
	}

	return dwRet;
}

DWORD ModifyServerSetting()
{
	DWORD dwRet;

	ISCSI_SERVER_CONFIG ServerConfig;

	dwRet = GetServerConfig(&ServerConfig);

	if(dwRet)
		return dwRet;

	//Modify your settings here.	
	dwRet = SetServerConfig(&ServerConfig);

	return dwRet;
}

DWORD ListClient()
{
	KHANDLE hClient = NULL;

	while(TRUE)
	{
		DWORD dwRet = FindNextStaticClient(NULL,hClient,&hClient);

		if(dwRet || !hClient)
			break;

		CLIENTCONFIG ClientConfig;
		GetStaticClientConfig(NULL,hClient,&ClientConfig);

		//Do modify to client here.

		in_addr in;

		in.s_addr = ClientConfig.ClientAddress;

		printf("%02x-%02x-%02x-%02x-%02x-%02x : %s \t %s \r\n",
			(UCHAR)ClientConfig.MacAddress[0], (UCHAR)ClientConfig.MacAddress[1],
			(UCHAR)ClientConfig.MacAddress[2], (UCHAR)ClientConfig.MacAddress[3],
			(UCHAR)ClientConfig.MacAddress[4], (UCHAR)ClientConfig.MacAddress[5],
			inet_ntoa(in),ClientConfig.TargetName);
	}

	return 0;
}

int _tmain(int argc, _TCHAR* argv[])
{
	int error=0; 
	WSADATA data;

	WSAStartup(MAKEWORD(2,0),&data);

	int test = sizeof(ISCSI_SERVER_CONFIG);
	while(TRUE)
	{
		CHAR Command[32];

		printf("Enter command:\r\n");
		scanf("%s",Command);

		if(stricmp(Command,"logon") == 0)
		{
			DWORD dwRet = Connect();

			if(dwRet)
				printf("Logon error %x\n",dwRet);
			else
				printf("Logon successfully.\r\n");
		}
		else if(stricmp(Command,"CreateHDTarget") == 0)
		{
			DWORD dwRet = CreateHDTarget();

			if(dwRet)
				printf("Create target error %x\n",dwRet);
			else
				printf("Target created successfully.\r\n");
		}
		else if(stricmp(Command,"ListVolumes") == 0)
		{	
			ListVolumes();
		}
		else if(stricmp(Command,"CreateVolumeTarget") == 0)
		{
			CHAR VolumePath[MAX_PATH];

			printf("\r\n Enter volume path:\r\n");

			scanf("%s",VolumePath);

			DWORD dwRet = CreateVolumeTarget(VolumePath);
			if(dwRet)
				printf("Create target error %x\n",dwRet);
			else
				printf("Target created successfully.\r\n");
		}
		else if(stricmp(Command,"DeleteTarget") == 0)
		{
			DWORD dwRet = DeleteTarget();
			if(dwRet)
				printf("Delete target error %x\n",dwRet);
			else
				printf("Target deleted successfully.\r\n");
		}
		else if(stricmp(Command,"ModifyServer") == 0)
		{
			DWORD dwRet = ModifyServerSetting();
			if(dwRet)
				printf("Modify server error %x\n",dwRet);
			else
				printf("Modify server successfully.\r\n");
		}
		else if(stricmp(Command,"ListClient") == 0)
		{
			DWORD dwRet = ListClient();
			if(dwRet)
				printf("List client error %x\n",dwRet);
			else
				printf("List client successfully.\r\n");
		}
		else if(stricmp(Command,"Exit") == 0)
			break;

		printf("\r\n");

	}


	return 0;
}

