@echo off
setlocal enabledelayedexpansion

set "TempDir=TempProjectArchive"

for %%I in ("%~dp0.") do set "ProjectDir=%%~fI"
for %%A in ("%ProjectDir%") do set "ProjectName=%%~nxA"

if not exist "%ProjectDir%\%TempDir%" mkdir "%ProjectDir%\%TempDir%"

xcopy "%ProjectDir%\Content" "%ProjectDir%\%TempDir%\Content\" /E /I /Q
if exist "%ProjectDir%\Source" xcopy "%ProjectDir%\Source" "%ProjectDir%\%TempDir%\Source\" /E /I /Q
xcopy "%ProjectDir%\Config" "%ProjectDir%\%TempDir%\Config\" /E /I /Q
copy "%ProjectDir%\*.uproject" "%ProjectDir%\%TempDir%\" >nul

set "ZipFile=%ProjectDir%\%ProjectName%.zip"
cd "%ProjectDir%\%TempDir%"
powershell -Command "Compress-Archive -Path '*' -DestinationPath '%ZipFile%' -Force"
cd "%ProjectDir%"

echo Project archived to: %ZipFile%

rd /s /q "%ProjectDir%\%TempDir%"
