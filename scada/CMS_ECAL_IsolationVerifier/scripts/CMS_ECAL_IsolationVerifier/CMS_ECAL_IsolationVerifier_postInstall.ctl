#uses "CMS_ECAL_IsolationVerifier/configTools.ctl"

void buildOpcItemsAddresses()
{
  buildAddress("ADC_CH1.value.raw"	, "ns=2;i=3", 759);
  buildAddress("ADC_CH1.value.converted", "ns=2;i=2", 760);
  
  buildAddress("ADC_CH1.mean.raw"	, "ns=2;i=5", 759);
  buildAddress("ADC_CH1.mean.converted" , "ns=2;i=4", 760);
}

void main()
{
  bool expired = false;
  
  buildOpcItemsAddresses();  
  
  fwInstallationManager_command("STOP", "WCCILsim", "-num 30");    
  fwInstallationManager_wait(false, "WCCILsim", 30, 20, expired);    
  
  fwInstallationManager_command("START", "WCCOAopcua", "-num 30");   
  fwInstallationManager_wait(true, "WCCOAopcua", 30, 20, expired);
}
