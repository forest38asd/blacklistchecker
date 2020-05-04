#SingleInstance force

if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"
   ExitApp
}

;=================================================
;====================== INFO =====================
;=================================================
; Создатель - Bogdan_Forest
current_version = 0.1
;=================================================

;=================================================
;================ UPDATE CHECKER =================
;=================================================
new_version := URLDownloadToVar("https://raw.githubusercontent.com/forest38asd/blacklistchecker/master/version.txt")
if (current_version != new_version)
{
	changes := URLDownloadToVar("https://raw.githubusercontent.com/forest38asd/blacklistchecker/master/changelog/" new_version ".txt")
	
	MsgBox, 4, Обновление скрипта, Список изменений:`n`n %changes%
	
	IfMsgBox, Yes
	{
		new_file_name = %A_ScriptName%%new_version%.ahk
		UrlDownloadToFile, https://raw.githubusercontent.com/forest38asd/blacklistchecker/master/versions/blacklistchecker`%20v%new_version%.ahk, %new_file_name%
		sleep 100
		while not FileExist(new_file_name)
		{
			sleep 2000
		}
		FileDelete, %A_ScriptName%
		FileMove, %new_file_name%, %A_ScriptName%
		Run, %A_ScriptName%
		exit
	}
}

;=================================================

if not FileExist("SAMP.ahk")
{
	UrlDownloadToFile, https://raw.githubusercontent.com/forest38asd/blacklistchecker/master/SAMP.ahk, SAMP.ahk
	while not FileExist("SAMP.ahk")
	{
		sleep 2000
	}
}

#Include SAMP.ahk

;=================================================
;================ GOOGLE CHECKER =================
;=================================================

!1::
	MsgBox, Работаем :)




URLDownloadToVar(url){
	hObject:=ComObjCreate("WinHttp.WinHttpRequest.5.1")
	hObject.Open("GET",url)
	hObject.Send()
	return hObject.ResponseText
}