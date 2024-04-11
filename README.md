# Unreal-Engine-Utilities
 
## archive_proj.bat
This archives the necessary folders such as /Content, /Config, /Source (if it exists), and the .uproject.
Place it in the root of your UE project and run it. The .zip will be in the same place.

## Building Commands
Use this command if you're doing C++ scripting stuff: `UnrealBuildTool.exe -projectfiles -project="C:\FULL_PATH_TO_YOUR\UNREAL_PROJECT.uproject" -game -engine -progress`
Note, be sure to add `C:\Program Files\Epic Games\UE_5.3\Engine\Binaries\DotNET\UnrealBuildTool` to your environment variables.
