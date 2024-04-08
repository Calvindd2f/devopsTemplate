$IntMgmt395src="https://codeload.github.com/Micke-K/IntuneManagement/zip/refs/tags/3.9.5"
$src="~\.intunemgmt"# vars
$intAppPkgs="$src\appPackages"
$intDownloadDir="$src\appDownloads"
$intAndy6="$src\logs"
#--------------------------------------------------
cd ~
mkdir $src
cd $src
iwr -uri $IntMgmt395src -OutFile $src #3.9.5 is zip
expand-archive .\3.9.5
if(test-path "$src\3.9"){
	cd $src\3.9
	rm $src\3.9.5 #rm original zip
	Cp -R "$src\3.9\IntuneManagement-3.9.5\" $src
	rm $src\3.9
}
$src="$src\IntuneManagement-3.9.5"
cd $src
mkdir $intAppPkgs 				#app packages folder for intune
mkdir $intDownloadDir 			#app downlaods folder for intune
mkdir $intAndy6					#log file
#--------------------------------------------------
$unblockCMD=gci -Filter "*.cmd" # cmd files need to be unblocked; they will unblock all others
foreach($file in $unblockCMD){Unblock-File $file}

# modules - BETA of msgraph required.
if(!(gmo microsoft.graph.beta)){inmo microsoft.graph.beta;IPMO MICROSOFT.GRAPH.BETA}

# appreg not required but heavy advised as Intune & Graph will use default enterprise app scopes/permissions
# grant request will occur if missing permissions

# can be ran with delegated authentication with & $src\Start.cmd
$tenantId=$env:tenantId 
$appId=$env:appId
$appSecret=$env:appSecret
$appcertThumb=$env:Appthumbprint
#Start-IntuneManagement.ps1 -Silent -TenantId "<TenantID>" [-AppId <AppId>] [-Secret <Secret> | -Certificate <CertThumb>]
.\Start-WithApp.cmd -Silent -TenantId $tenantId -AppId $appId -Secret $appSecret -Certificate $appcertThumb
###################
<#
1. APP HAS STARTED
2. ACCEPT TERMS 
3. CLICK `file` > `settings` :
4. Define MSAL Library File AS genuine path of "$src\Microsoft.Identity.Client.dll"
   So : C:\users\<username>\.intunemgmt\IntuneManagement-3.9.5\Microsoft.Identity.Client.dll

5. Get Tenant List : 			Enabled
   Use Default Permissions: 	Enabled
   Show Azure AD login menu: 	Enabled
   Sort account list: 			Enabled

7.	Define root folder, app packages folder, app download folder
8.  Add company name: disabled
	export assignments: disabled
	import assingments: disabled
	add id to export file: enabled
9.

10. configure the application settings in Silent/Batch Job - so you do not have to do this again.

11. export configuration and save in ITG or something
	jebaited...

configuration.json in $src for example.
{
    "AddCompanyName":  "False",
    "AddIDToExportFile":  "True",
    "AddObjectType":  "True",
    "AzureADLoginMenu":  "True",
    "AzureADRoleRead":  "False",
    "CacheMSALToken":  "True",
    "CheckForUpdates":  "True",
    "ConvertSyncedGroupOnImport":  "True",
    "CreateGroupOnImport":  "True",
    "Debug":  "False",
    "EMAllowBulkDelete":  "False",
    "EMAllowDelete":  "True",
    "ExpandAssignments":  "False",
    "ExportAssignments":  "False",
    "FirstTimeRunning":  "False",
    "GetTenantList":  "True",
    "GraphAzureAppCert":  "_____<nsfw>______",
    "GraphAzureAppId":  "_____<nsfw>______",
    "GraphAzureAppLogin":  "False",
    "GraphAzureAppSecret":  "_____<nsfw>______",
    "HideNoAccess":  "False",
    "ImportAssignments":  "False",
    "ImportScopeTags":  "True",
    "ImportType":  "alwaysImport",
    "LicenseAccepted":  "True",
    "LogFile":  "C:\\users\\c\\.intunemgmt\\logs",
    "LogFileSize":  "1024",
    "LogOutputError":  "True",
    "MenuBGColor":  "AntiqueWhite",
    "MenuFGColor":  "Cyan",
    "MenuShowOrganizationName":  "True",
    "MSALDLL":  "C:\\users\\c\\.intunemgmt\\IntuneManagement-3.9.5\\Microsoft.Identity.Client.dll",
    "PreviewFeatures":  "True",
    "ProxyURI":  "",
    "RefreshObjectsAfterCopy":  "True",
    "ResolveReferenceInfo":  "True",
    "RootFolder":  "C:\\users\\c\\.intunemgmt\\",
    "SortAccountList":  "True",
    "UseBatchAPI":  "False",
    "UseDefaultPermissions":  "True",
    "UseGraphV1":  "False",
    "EndpointManager":  {
                            "EMAzureApp":  "_____<nsfw>______",
                            "EMCustomAppId":  "_____<nsfw>______",
                            "EMCustomAppRedirect":  "_____<nsfw>______",
                            "EMCustomAuthority":  "_____<nsfw>______",
                            "EMCustomTenantId":  "_____<nsfw>______",
                            "EMIntuneAppDownloadFolder":  "C:\\users\\c\\.intunemgmt",
                            "EMIntuneAppPackages":  "C:\\users\\c\\.intunemgmt",
                            "EMSaveEncryptionFile":  "False"
                        }
}

