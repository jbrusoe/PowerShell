#1. What class can you use to view the current IP address of a network adapter?
#Does the class have any methods that you could use to release a DHCP lease?
#(Hint: network is a good keyword here.)

<#
PS C:\Users\jbrus\Documents\GitHub\PowerShell-Private> Get-CIMclass *Network*


   NameSpace: ROOT/cimv2

CimClassName                        CimClassMethods      CimClassProperties
------------                        ---------------      ------------------
CIM_NetworkAdapter                  {SetPowerState, R... {Caption, Description, InstallDate, Name...}
Win32_NetworkAdapter                {SetPowerState, R... {Caption, Description, InstallDate, Name...}
Win32_NetworkConnection             {}                   {Caption, Description, InstallDate, Name...}
Win32_NetworkProtocol               {}                   {Caption, Description, InstallDate, Name...}
Win32_NetworkClient                 {}                   {Caption, Description, InstallDate, Name...}
Win32_NetworkAdapterSetting         {}                   {Element, Setting}
Win32_SystemNetworkConnections      {}                   {GroupComponent, PartComponent}
Win32_NetworkAdapterConfiguration   {EnableDHCP, Rene... {Caption, Description, SettingID, ArpAlwaysSourceRoute...} 

PS C:\Users\jbrus\Documents\GitHub\PowerShell-Private> Get-CimInstance Win32_NetworkAdapterConfiguration | GM | where {$_.Name -like "*IP*"}


   TypeName: Microsoft.Management.Infrastructure.CimInstance#root/cimv2/Win32_NetworkAdapterConfiguration

Name                    MemberType  Definition
----                    ----------  ----------
DefaultIPGateway        Property    string[] DefaultIPGateway {get;}
Description             Property    string Description {get;}
IPAddress               Property    string[] IPAddress {get;}
IPConnectionMetric      Property    uint32 IPConnectionMetric {get;}
IPEnabled               Property    bool IPEnabled {get;}
IPFilterSecurityEnabled Property    bool IPFilterSecurityEnabled {get;}
IPPortSecurityEnabled   Property    bool IPPortSecurityEnabled {get;}
IPSecPermitIPProtocols  Property    string[] IPSecPermitIPProtocols {get;}
IPSecPermitTCPPorts     Property    string[] IPSecPermitTCPPorts {get;}
IPSecPermitUDPPorts     Property    string[] IPSecPermitUDPPorts {get;}
IPSubnet                Property    string[] IPSubnet {get;}
IPUseZeroBroadcast      Property    bool IPUseZeroBroadcast {get;}
IPXAddress              Property    string IPXAddress {get;}
IPXEnabled              Property    bool IPXEnabled {get;}
IPXFrameType            Property    uint32[] IPXFrameType {get;}
IPXMediaType            Property    uint32 IPXMediaType {get;}
IPXNetworkNumber        Property    string[] IPXNetworkNumber {get;}
IPXVirtualNetNumber     Property    string IPXVirtualNetNumber {get;}
TcpipNetbiosOptions     Property    uint32 TcpipNetbiosOptions {get;}
IP                      PropertySet IP {Description, Index, IPAddress, IPConnectionMetric, IPEnabled, IPFilterSecuri...

S C:\Users\jbrus\Documents\GitHub\PowerShell-Private> Get-CimInstance Win32_NetworkAdapterConfiguration | where {$_.ServiceName -like "*mrvl*"} |fl


DHCPEnabled      : True
IPAddress        : {192.168.43.44, fe80::f189:f505:2564:10fe}
DefaultIPGateway : {192.168.43.1}
DNSDomain        :
ServiceName      : mrvlpcie8897
Description      : Marvell AVASTAR Wireless-AC Network Controller
Index            : 1

PS C:\Users\jbrus\Documents\GitHub\PowerShell-Private> Get-CimClass Win32_NetworkAdapterConfiguration  |select -expand CimClassMethods

Name                            ReturnType Parameters
----                            ---------- ----------
EnableDHCP                          UInt32 {}
RenewDHCPLease                      UInt32 {}
RenewDHCPLeaseAll                   UInt32 {}
ReleaseDHCPLease                    UInt32 {}
ReleaseDHCPLeaseAll                 UInt32 {}

#>

#2. Create a table that shows a computer name, operating system build number,
#operating system description (caption), and BIOS serial number

<#
PS C:\Users\jbrus\Documents\GitHub\PowerShell-Private> Get-CimInstance Win32_OperatingSystem | select @{Name="ComputerName";Expression={$_.CSName}},BuildNumber,Caption,@{Name = 'BIOS Serial Number'; Expression = {(Get-CimInstance Win32_BIOS).SerialNumber}}

ComputerName    BuildNumber Caption                  BIOS Serial Number
------------    ----------- -------                  ------------------
DESKTOP-1MQ9DJO 18363       Microsoft Windows 10 Pro 017839790853

#>

#3. Query a list of hotfixes using WMI. 

<#

PS C:\Users\jbrus\Documents\GitHub\PowerShell-Private> Get-WmiObject Win32_QuickFixEngineering
Source        Description      HotFixID      InstalledBy          InstalledOn
------        -----------      --------      -----------          -----------
DESKTOP-1M... Update           KB4537572     NT AUTHORITY\SYSTEM  3/2/2020 12:00:00 AM
DESKTOP-1M... Security Update  KB4497932     NT AUTHORITY\SYSTEM  6/4/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4498523     NT AUTHORITY\SYSTEM  6/3/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4503308     NT AUTHORITY\SYSTEM  6/12/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4506933     NT AUTHORITY\SYSTEM  7/1/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4508433     NT AUTHORITY\SYSTEM  7/27/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4509096     NT AUTHORITY\SYSTEM  7/10/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4515383     NT AUTHORITY\SYSTEM  9/10/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4515530     NT AUTHORITY\SYSTEM  9/3/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4516115     NT AUTHORITY\SYSTEM  9/10/2019 12:00:00 AM
DESKTOP-1M... Update           KB4517245     NT AUTHORITY\SYSTEM  11/13/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4520390     NT AUTHORITY\SYSTEM  9/28/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4521863     NT AUTHORITY\SYSTEM  10/8/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4524244     NT AUTHORITY\SYSTEM  2/14/2020 12:00:00 AM
DESKTOP-1M... Security Update  KB4524569     NT AUTHORITY\SYSTEM  11/12/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4525419     NT AUTHORITY\SYSTEM  11/6/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4528759     NT AUTHORITY\SYSTEM  1/15/2020 12:00:00 AM
DESKTOP-1M... Security Update  KB4537759     NT AUTHORITY\SYSTEM  2/11/2020 12:00:00 AM
DESKTOP-1M... Security Update  KB4538674     NT AUTHORITY\SYSTEM  2/11/2020 12:00:00 AM
DESKTOP-1M... Security Update  KB4541338     NT AUTHORITY\SYSTEM  3/10/2020 12:00:00 AM
DESKTOP-1M... Security Update  KB4552152     NT AUTHORITY\SYSTEM  4/15/2020 12:00:00 AM
DESKTOP-1M... Update           KB4550945     NT AUTHORITY\SYSTEM  4/24/2020 12:00:00 AM


PS C:\Users\jbrus\Documents\GitHub\PowerShell-Private> Get-Hotfix

Source        Description      HotFixID      InstalledBy          InstalledOn
------        -----------      --------      -----------          -----------
DESKTOP-1M... Update           KB4537572     NT AUTHORITY\SYSTEM  3/2/2020 12:00:00 AM
DESKTOP-1M... Security Update  KB4497932     NT AUTHORITY\SYSTEM  6/4/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4498523     NT AUTHORITY\SYSTEM  6/3/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4503308     NT AUTHORITY\SYSTEM  6/12/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4506933     NT AUTHORITY\SYSTEM  7/1/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4508433     NT AUTHORITY\SYSTEM  7/27/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4509096     NT AUTHORITY\SYSTEM  7/10/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4515383     NT AUTHORITY\SYSTEM  9/10/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4515530     NT AUTHORITY\SYSTEM  9/3/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4516115     NT AUTHORITY\SYSTEM  9/10/2019 12:00:00 AM
DESKTOP-1M... Update           KB4517245     NT AUTHORITY\SYSTEM  11/13/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4520390     NT AUTHORITY\SYSTEM  9/28/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4521863     NT AUTHORITY\SYSTEM  10/8/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4524244     NT AUTHORITY\SYSTEM  2/14/2020 12:00:00 AM
DESKTOP-1M... Security Update  KB4524569     NT AUTHORITY\SYSTEM  11/12/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4525419     NT AUTHORITY\SYSTEM  11/6/2019 12:00:00 AM
DESKTOP-1M... Security Update  KB4528759     NT AUTHORITY\SYSTEM  1/15/2020 12:00:00 AM
DESKTOP-1M... Security Update  KB4537759     NT AUTHORITY\SYSTEM  2/11/2020 12:00:00 AM
DESKTOP-1M... Security Update  KB4538674     NT AUTHORITY\SYSTEM  2/11/2020 12:00:00 AM
DESKTOP-1M... Security Update  KB4541338     NT AUTHORITY\SYSTEM  3/10/2020 12:00:00 AM
DESKTOP-1M... Security Update  KB4552152     NT AUTHORITY\SYSTEM  4/15/2020 12:00:00 AM
DESKTOP-1M... Update           KB4550945     NT AUTHORITY\SYSTEM  4/24/2020 12:00:00 AM

#>

#4. Display a list of services, including their current statuses, their start modes, and the accounts they use to log on.

<#
PS C:\Users\jbrus\Documents\GitHub\PowerShell-Private> Get-CimInstance win32_service | select Name,Status,StartMode,StartName

Name                                                   Status  StartMode StartName
----                                                   ------  --------- ---------
AJRouter                                               OK      Manual    NT AUTHORITY\LocalService
ALG                                                    OK      Manual    NT AUTHORITY\LocalService
AppIDSvc                                               OK      Manual    NT Authority\LocalService
Appinfo                                                OK      Manual    LocalSystem
AppMgmt                                                OK      Manual    LocalSystem
AppReadiness                                           OK      Manual    LocalSystem
AppVClient                                             OK      Disabled  LocalSystem
AppXSvc                                                OK      Manual    LocalSystem
AssignedAccessManagerSvc                               OK      Manual    LocalSystem
AudioEndpointBuilder                                   OK      Auto      LocalSystem
Audiosrv                                               OK      Auto      NT AUTHORITY\LocalService
autotimesvc                                            OK      Manual    NT AUTHORITY\LocalService
AxInstSV                                               OK      Manual    LocalSystem
BDESVC                                                 OK      Manual    localSystem
#>

#5. Using the CIM cmdlets, list all available classes in the SecurityCenter2 namespace with Product as part of the name.

<#

PS C:\Users\jbrus\Documents\GitHub\PowerShell-Private> Get-CimClass -Namespace root/SecurityCenter2 -ClassName product*
PS C:\Users\jbrus\Documents\GitHub\PowerShell-Private> Get-CimClass -Namespace root/SecurityCenter2 -ClassName anti*


   NameSpace: ROOT/SecurityCenter2

CimClassName                        CimClassMethods      CimClassProperties
------------                        ---------------      ------------------
AntiVirusProduct                    {}                   {displayName, instanceGuid, pathToSignedProductExe, pathToS...
AntiSpywareProduct                  {}                   {displayName, instanceGuid, pathToSignedProductExe, pathToS...


#>
