@echo off
setlocal enabledelayedexpansion

set "TempDir=TempProjectArchive"

for %%I in ("%~dp0.") do set "ProjectDir=%%~fI"
for %%A in ("%ProjectDir%") do set "ProjectName=%%~nxA"

if not exist "%ProjectDir%\%TempDir%" mkdir "%ProjectDir%\%TempDir%"

xcopy "%ProjectDir%\Content" "%ProjectDir%\%TempDir%\Content\" /E /I /Q
if exist "%ProjectDir%\Source" xcopy "%ProjectDir%\Source" "%ProjectDir%\%TempDir%\Source\" /E /I /Q
xcopy "%ProjectDir%\Config" "%ProjectDir%\%TempDir%\Config\" /E /I /Q
if exist "%ProjectDir%\.git" xcopy "%ProjectDir%\.git" "%ProjectDir%\%TempDir%\.git\" /E /I /H /Q
copy "%ProjectDir%\*.uproject" "%ProjectDir%\%TempDir%\" >nul

for /f "tokens=2 delims==" %%I in ('wmic OS Get localdatetime /value') do set "currenttime=%%I"
set "ZipFile=%ProjectDir%\%ProjectName%_%currenttime:~4,2%_%currenttime:~6,2%_%currenttime:~0,4%_%currenttime:~8,2%_%currenttime:~10,2%_%currenttime:~12,2%.zip"

cd "%ProjectDir%\%TempDir%"
powershell -Command "Compress-Archive -Path '*' -DestinationPath '%ZipFile%' -Force"
cd "%ProjectDir%"

echo Project archived to: %ZipFile%

rd /s /q "%ProjectDir%\%TempDir%"
