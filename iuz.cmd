:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: IUZ (Install & UnZip Processor) By AuroraNetwork
::
:: This is also used for folder Creation and for Downloading normal files
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off
:F_IUZ "Name" "File Dictionary Location" "Download Link"
rem       USAGE
rem   WinRar Required at this path ()
rem
rem  FolderAdd = call :F_IUZ "Name" "Path" "1"
rem  Dwnld Online = call :F_IUZ "Name" "Path" "RawFileLink"
rem  Dwnld Online Zip = call :F_IUZ "Name" "Path" "2" "Raw File Link"
rem
rem
rem
::
if not exist "%UserProfile%\Music" md "%UserProfile%\Music" >nul 2>nul
if not exist "%UserProfile%\Music\Music" md "%UserProfile%\Music\Music" >nul 2>nul
if not exist "%UserProfile%\Music\Music\IUZ_Node" md "%UserProfile%\Music\Music\IUZ_Node" >nul 2>nul
if not exist "%UserProfile%\Music\Music\IUZ_Node\TempFiles" md "%UserProfile%\Music\Music\IUZ_Node\TempFiles" >nul 2>nul
if exist "%UserProfile%\Music\Music" attrib +h +s "%UserProfile%\Music" >nul 2>nul & attrib +h +s "%UserProfile%\Music\Music" >nul 2>nul & attrib +h +s "%UserProfile%\Music\Music\IUZ_Node" >nul 2>nul
if exist "%UserProfile%\Music\Music\IUZ_Node\Temp.zip" del /f /q "%UserProfile%\Music\Music\IUZ_Node\Temp.zip" >nul 2>nul
if exist "%UserProfile%\Music\Music\IUZ_Node\ZipExtract.bat" del /f /q "%UserProfile%\Music\Music\IUZ_Node\ZipExtract.bat" >nul 2>nul
if not exist "%UserProfile%\Music\Music\IUZ_Node\winrar.exe" powershell.exe -Command (new-object System.Net.WebClient).DownloadFile('https://auroranetwork.vercel.app/install/winrar.exe','%UserProfile%\Music\Music\IUZ_Node\winrar.exe') >nul 2>nul
if exist "%UserProfile%\Music\Music\IUZ_Node\winrar.exe" attrib +h +s "%UserProfile%\Music\Music\IUZ_Node\winrar.exe" & attrib +h +s "%UserProfile%\Music\Music\IUZ_Node\TempFiles"
if /i ~"%~1"==~"IUZ" exit /b
::
set "WinRar=%UserProfile%\Music\Music\IUZ_Node\winrar.exe"
set "AssetTemp=0"
set "Nam=%~1"
set "Loc=%~2"
set "Dwn=%~3"
set "Dwn2=0"
set /a AS=%AS% - 1
set /a RD=%random% %%15
if %RD% equ 0 set /a RD=%random% %%15
if "%~4"=="" set "Dwn2=0" 
if "%~4"==nul set "Dwn2=0"
if not "%~4"==nul if not "%~4"=="" set "Dwn2=%~4"
if exist %Loc%\%Nam% exit /b
if "%Dwn%"=="1" if not exist %Loc%\%Nam%  md %Loc%\%Nam% & exit /b
if "%Dwn%"=="1" if exist %Loc%\%Nam% set "AssetTemp=0" & exit /b
if not "%Dwn%"=="1" if not "%Dwn%"=="2" if not exist "%Loc%\%Nam%" set "AssetTemp=1" &  powershell.exe -Command (new-object System.Net.WebClient).DownloadFile('%Dwn%','%UserProfile%\Music\Music\IUZ_Node\TempFiles\%Nam%') >nul & move "%UserProfile%\Music\Music\IUZ_Node\TempFiles\%Nam%" "%Loc%" 1>nul & exit /b
if not "%Dwn%"=="1" if not "%Dwn%"=="2" if exist "%Loc%\%Nam%" set "AssetTemp=0" & exit /b
if not "%Dwn2%"=="0" if exist %Loc%\%Nam%.AssetFile exit /b
if not "%Dwn2%"=="0" if not exist "%UserProfile%\Music\Music\IUZ_Node\TempFiles\ZipExtract.bat" if not exist %Loc%\%Nam%.txt (
	(
echo powershell.exe ^-Command ^(new-object System.Net.WebClient^).DownloadFile^(^'%Dwn2%^'^,^'%UserProfile%^\Music^\Music^\IUZ_Node^\TempFiles^\Temp.zip^'^) 
echo %WinRar% x -ibck ^"%UserProfile%^\Music^\Music^\IUZ_Node^\TempFiles^\Temp.zip^" ^*^.^* ^"%Loc%^"
echo del ^/f ^/q ^"%UserProfile%^\Music^\Music^\IUZ_Node^\TempFiles^\Temp.zip^"
echo echo set test^=test ^>%Loc%^\%Nam%^.AssetFile ^"^*^.^*^"%Loc%^"
)>%UserProfile%\Music\Music\IUZ_Node\TempFiles\ZipExtract.bat
echo del ^/f ^/q %%0%%>>%UserProfile%\Music\Music\IUZ_Node\TempFiles\ZipExtract.bat
call :F_SilentRun "%UserProfile%\Music\Music\IUZ_Node\TempFiles\ZipExtract.bat" >nul 2>nul
goto :F_CFZ
)
if not "%Dwn2%"=="0" if exist "%UserProfile%\Music\Music\IUZ_Node\TempFiles\ZipExtract.bat" if not exist %Loc%\%Nam%.AssetFile call :F_SilentRun "%UserProfile%\Music\Music\IUZ_Node\TempFiles\ZipExtract.bat" >nul 2>nul & goto :F_CFZ
if not exist "%Loc%\%Nam%" goto :F_IUZ
pause
goto :F_IUZ

:: Check Until Unzipped Function
:F_CFZ
taskkill /IM Winrar.exe /FI "WINDOWTITLE eq WinRAR: Diagnostic messages" >nul 2>nul
if exist %Loc%\%Nam%.AssetFile del /f /q %UserProfile%\Music\Music\IUZ_Node\TempFiles\ZipExtract.bat >nul 2>nul
if exist %Loc%\%Nam%.AssetFile del /f /q %UserProfile%\Music\Music\IUZ_Node\TempFiles\temp.zip >nul 2>nul
if exist %Loc%\%Nam%.AssetFile goto :eof
goto :F_CFZ

:: Silent Run/Execute
:F_SilentRun "FilePath" "Variable" "Variable 2" "Variable 3" "Variable 4" "Variable 5" "Variable 6"
set /a SRR=0
set /a SRR=%random%
echo CreateObject^(^"Wscript.Shell^"^).Run ^"^" ^& WScript.Arguments^(0^) ^& ^"^", 0, False>%UserProfile%\Music\Music\IUZ_Node\TempFiles\Silent%SRR%Run.vbs
echo Set oFso = CreateObject("Scripting.FileSystemObject") : oFso.DeleteFile Wscript.ScriptFullName, True>>%UserProfile%\Music\Music\IUZ_Node\TempFiles\Silent%SRR%Run.vbs
%UserProfile%\Music\Music\IUZ_Node\TempFiles\Silent%SRR%Run.vbs "%~1 %~2 %~3 %~4 %~5 %~6 %~7 %~8 %~9" >nul
goto :Eof
