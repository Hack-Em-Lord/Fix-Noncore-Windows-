@echo off
title Tool Fix-Noncore Windows - Hack'Em Lord

::========================================================================================================================================
::Trinh Tuan Kiet
::Auto Change Permissions
chcp 65001 >nul
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo  You Need Run This Tool By 'Run as Administrator'
    goto goUAC 
) else (
 goto goADMIN )

:goUAC
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:goADMIN
    pushd "%CD%"
    CD /D "%~dp0"
::========================================================================================================================================
mode 70, 26
call :txt

::Dashboard
:MainMenu 
cls
echo:
echo:
echo:                        Hack'Em Lord
echo:       ___________________________________________________ 
echo:                                                          
echo:          [1] Fix-Noncore Windows 10, Server 2016/2019                                 
echo           [2] Fix-Noncore Windows 8, Server 2012/R2
echo:          [3] Fix-Noncore Windows 7, Server 2008 R2                             
echo:          _____________________________________________                                                                                   
echo:          [4] About                                    
echo:          [5] Exit                                       
echo:       ___________________________________________________
echo:   
echo:      Enter a menu option in the Keyboard [1,2,3,4,5]
set /p ans=

if %ans%==1 goto :1
if %ans%==2 goto :2
if %ans%==3 goto :3
if %ans%==4 goto :about
if %ans%==5 exit

:1
cls
sc config wuauserv start= auto
sc config bits start= auto
sc config DcomLaunch start= auto
net stop wuauserv
net start wuauserv
net stop bits
net start bits
net start DcomLaunch
REG add "HKLM\SYSTEM\CurrentControlSet\services\sppsvc" /v Start /t REG_DWORD /d 4 /f
REG add "HKLM\SYSTEM\CurrentControlSet\services\sppsvc" /v Start /t REG_DWORD /d 2 /f\
shutdown -r

:2
cls
net stop sppsvc
cd %windir%\ServiceProfiles\LocalService\AppData\Local\Microsoft\WSLicense
ren tokens.dat tokens.bar
net start sppsvc
cscript.exe %windir%\system32\slmgr.vbs /rilc
shutdown -r

:3
cls
net stop sppsvc
cd %windir%\ServiceProfiles\NetworkService\AppData\Roaming\Microsoft\SoftwareProtectionPlatform
ren tokens.dat tokens.bar
net start sppsvc
cscript.exe %windir%\system32\slmgr.vbs /rilc
slmgr -rearm
shutdown -r

:about
cls
cls
echo:           ___________________________________________________ 
echo:                      Thanks For Using Our Tools !!!
echo:           ___________________________________________________ 
echo:
start https://discord.gg/pZhZDu9Anw
start https://github.com/Hack-Em-Lord





