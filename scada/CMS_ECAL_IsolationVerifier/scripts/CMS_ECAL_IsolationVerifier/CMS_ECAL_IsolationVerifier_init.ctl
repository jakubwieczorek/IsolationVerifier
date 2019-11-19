#uses "CMS_ECAL_IsolationVerifier/configTools.ctl"

void main()
{
  addDriver("Simulation Driver", "WCCILsim", "-num 30");     
  addDriver("OPC UA Client", "WCCOAopcua", "-num 30");
      
  bool expired = false;

  fwInstallationManager_command("STOP", "WCCOAopcua", "-num 30"); 
  fwInstallationManager_wait(false, "WCCOAs7", 30, 20, expired);    

  fwInstallationManager_command("START", "WCCILsim", "-num 30");    
  fwInstallationManager_wait(true, "WCCILsim", 30, 20, expired);   
}
