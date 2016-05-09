'-- ============================================================================
'-- 2014 VOLVO GTT
'-- ============================================================================
'-- TEMPLATE MATLAB
'-- ============================================================================
'-- Filename : launch_template-matlab-v3.0.vbs
'-- ============================================================================
'-- This file is used to launch appli from CAELA (XML)
'-- ============================================================================
'-- Revision History
'-- ----------------
'-- AUTHOR                  	DATE        	COMMENT
'-- Mathieu CABANES      			04-Jun-2009 	Creation
'-- Olivier DUFOUR           	05-May-2010  	Update to 1.1
'-- Maxime CAZENAVE          	20-Jun-2010  	Update to 2.0
'-- Mathieu CABANES          	19-Jun-2014  	Update to version 3.0
'-- <Name> <Company>        	yyyy/mm/dd 	  <Modification description>
'-- ============================================================================
'-- Declaration section
'-- -------------------
'--Option Explicit
dim fso, wss
dim f_proc_varenv
dim current_dir
'--
'-- WS Object creation
'-- ------------------
'-- for file system infos
Set fso = WScript.CreateObject("Scripting.FileSystemObject")
'-- To read BU/Site
Set WSHNetwork = WScript.CreateObject("WScript.Network")
'-- For environment
Set wss        = WScript.CreateObject("WScript.Shell")
'-- To set env variables for the currenr process
set f_proc_varenv  = wss.Environment("PROCESS")
'-- for LDAP infos
Set objSysInfo 	= WScript.CreateObject("ADSystemInfo")
'--
'-- load current directory where the script is executed from:
wss.CurrentDirectory = fso.GetParentFolderName(WScript.scriptfullname)
current_dir = wss.CurrentDirectory
'--
'-- current_dir can be used when scripts (bat or vbs)do not use applirvi
'-- else applirvi (it was "C:\CAE") must be set with my_root
'-- else my_appli_home can be used: it contains the full path before "bin"
'-- the application structure must follow the waited one with the folder "bin"
'-- --------------------------------------------------------------------------
Dim my_root 
my_root = GetLocalInstallRoot(current_dir)
Err.Clear
'--
Dim my_appli_home 
my_appli_home = GetAppliHome(current_dir, "bin")
'--
'-- set/read variables to be updated according to the current release
'-- -----------------------------------------------------------------
my_appli_name = "matlab-template"
my_appli_release = "3.0"  '
'--
user_BU = ""
user_site = ""
'-- 
'-- Code section
'-- ------------
'-- Load infos from LDAP
'-- BU
user_BU = GetUserBusinessUnit() 
'--
'-- Set Site if Domain found (means connected) else "" (network not found)
If user_BU <> "" Then
user_site = objSysInfo.SiteName
Else
user_site = "UNKOWN"
user_BU = "UNKOWN"
MsgBox "Offline mode !", vbExclamation, "Local Network"
End If
'-- set env var
f_proc_varenv("MY_BU") = user_BU
'-- 
'--WScript.Echo f_proc_varenv("MY_BU") 
f_proc_varenv("MY_SITE") = user_site
'-- 
'-- track the usage
wss.run current_dir &"\caplog.exe " &" -dCAE -aTEMPLATE -eMATLAB -v" &my_appli_release &" -mTOOL -cRUN -lFROM_CAELA"
'--
wss.run current_dir &"\launch_" &my_appli_name &".bat " &my_appli_home &" " &my_appli_release
WScript.quit(0)
'-- 
'-- Local functions
'-- ---------------
'-- Function : GetUserBusinessUnit() (code given by VIT)
'-- ----------------------------------------------------
Function GetUserBusinessUnit()
' Get BU of the user
On Error Resume Next
Dim AdObj, ou
Set AdObj       = Getobject("LDAP://" & objSysInfo.DomainDNSName)
AdObj.filter 	= Array("OrganizationalUnit")
For Each ou In AdObj
If InStr(1,objSysInfo.UserName,"," & ou.name & ",",1) > 0 Then
GetUserBusinessUnit = ou.ou
End If
Next
If Err.Number <> 0 Then 
MsgBox "An error occurred in section: GetUserBusinessUnit. Error Number: " & Err.Number & " with description: " & Err.Description
End If     
Err.Clear
End Function
'-- 
'-- End of Function
'-- ---------------
'-- Function : GetLocalInstallRoot(string current_dir_IN)
'-- -----------------------------------------------------
Function GetLocalInstallRoot(current_dir_IN)
' Get the root used for installation
local_root = ""
'-- load list of folder and sub-folder contained into "current_dir_IN"
folder_array = Split(current_dir_IN, "\", -1, 1)
'-- test folder_array size (from  LBound(TestArray) to UBound(TestArray) , starting from 0
'-- build local_root from C: (folder_array(0) ) and the first root folder (folder_array(1) )
array_size = UBound(folder_array) + 1
If array_size <2 Then
local_root = ""
Else
local_root = folder_array(0) + "\" + folder_array(1)
End If
GetLocalInstallRoot = local_root 
If Err.Number <> 0 Then 
MsgBox "An error occurred in section: GetLocalInstallRoot. Error Number: " & Err.Number & " with description: " & Err.Description
End If     
Err.Clear
End Function
'-- 
'-- End of Function
'-- ---------------
'-- Function :GetAppliHome(CurrentDir_IN, StopFolder_IN)
'-- Aim : return the path before "bin"
'-- if StopFolder_IN  not found : return same as CurrentDir_IN
'-- ----------------------------------------------------------
Function GetAppliHome(CurrentDir_IN, StopFolder_IN)
dim appliHome
appliHome = ""
'-- load array with the list of sub-folder names
folder_array = Split(CurrentDir_IN, "\", -1, 1)
'-- search folder where to stop and build appliHome
For i_fold = LBound(folder_array, 1) To UBound(folder_array, 1)
If folder_array(i_fold) = StopFolder_IN  Then
stop
Else
If  i_fold = 0 Then
appliHome = folder_array(0)
Else
appliHome = appliHome + "\" + folder_array(i_fold)
End If
End If
Next
GetAppliHome = appliHome '-- return the value
End Function
'-- 
'-- End of Function
'-- ---------------
'-- ========================== END OF FILE ======================================
