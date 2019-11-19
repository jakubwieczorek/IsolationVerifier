#uses "fwDevice/fwDevice.ctl"
#uses "fwConfigs/fwPeriphAddress.ctl"



public void buildAddress(const string &aDpe, const string &aAddress, const int &aType) 
{
  dyn_anytype params;
  dyn_string exc;

  params[fwPeriphAddress_TYPE]			= fwPeriphAddress_TYPE_OPCUACLIENT;
  params[fwPeriphAddress_DRIVER_NUMBER]		= 30;
  params[fwPeriphAddress_ROOT_NAME]		= aAddress;
  params[fwPeriphAddress_DIRECTION]	 	= DPATTR_ADDR_MODE_INPUT_SPONT; 	//input, spontaneous
  params[fwPeriphAddress_DATATYPE] 	   	= aType; 				//default type convertion. see WinCC OA help on _address for more options
  params[fwPeriphAddress_ACTIVE]		= true; 				//address active
  params[fwPeriphAddress_OPCUA_LOWLEVEL] 	= 0;              			//no low level comparison
  params[fwPeriphAddress_OPCUA_SERVER_NAME]  	= "RASPBERRY_DOCKER_OPC_SERVER_1"; 	//OPC UA server
  params[fwPeriphAddress_OPCUA_SUBSCRIPTION]	= "parameters"; 			//OPC UA subscription
  params[fwPeriphAddress_OPCUA_KIND]         	= "1";				//OPC UA Value/Event/Alarm
  params[fwPeriphAddress_OPCUA_VARIANT]		= "1";     				//OPC UA Node/Browse path
  params[fwPeriphAddress_OPCUA_POLL_GROUP]      = ""; 			//polling group name

  fwPeriphAddress_set(aDpe, params,  exc);
  
  // exception logging
  int exceptionsAmount = sizeof(exc);
  if(exceptionsAmount > 0)
  {
    for(int i = 0; i < exceptionsAmount; i++)
    {
      DebugN(exc[i]);
    }
  } else
  {
    DebugN("Building address " + aAddress + " finished successfully");
  }
}

public void buildArchive(const string &aDp)
{
  dyn_string exc;
  fwArchive_set(aDp, "RDB-99) EVENT", DPATTR_ARCH_PROC_VALARCH, 0, 0, 0, exc);

  // exception logging
  int exceptionsAmount = sizeof(exc);
  if(exceptionsAmount > 0)
  {
    for(int i = 0; i < exceptionsAmount; i++)
    {
      DebugN(exc[i]);
    }
  } else
  {
    DebugN("Building archiving " + aDp + " finished successfully");
  }
}

public int addDriver(const string &aName, const string &aMng, const string &aParams)
{
  int result;
  string resultText;

  result = fwInstallationManager_append(TRUE, aName, aMng, "manual", 30, 2, 2, aParams);

  switch(result)
  {
    case 1:
      resultText = "OK";
      break;
    case 2:
      resultText = "Already exists";
      break;
    default:
      resultText = "Failed";
      break;
  }

  DebugN("Adding " + aName + " - " + resultText);
  
  return result;
}


