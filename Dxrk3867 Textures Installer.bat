@echo off
setlocal

title Dxrk3867 Textures Installer

echo [1] Install Gray Textures
echo [2] Install Dark Textures
echo [3] Remove Textures (Normal)
echo.

set /p choice=Choose an option [1, 2, 3]: 

set DEST_FOLDER=%USERPROFILE%\AppData\Local\Bloxstrap\Versions\version-080ad6451df24461\PlatformContent\pc

set GRAY_TEXTURES_URL=https://github.com/Dxrk38677/Rivals-Textures/raw/refs/heads/main/Gray%20Textures.zip
set DARK_TEXTURES_URL=https://github.com/Dxrk38677/Rivals-Textures/raw/refs/heads/main/Dark%20Textures.zip

if "%choice%"=="1" (
    set ZIP_URL=%GRAY_TEXTURES_URL%
    set ZIP_FILE=%TEMP%\graytextures.zip
    set TEXTURE_TYPE=Gray Textures
) else if "%choice%"=="2" (
    set ZIP_URL=%DARK_TEXTURES_URL%
    set ZIP_FILE=%TEMP%\darktextures.zip
    set TEXTURE_TYPE=Dark Textures
) else if "%choice%"=="3" (
    echo Removing existing "textures" folder...
    rmdir /s /q "%DEST_FOLDER%\textures"
    echo Textures removed.
    exit /b
) else (
    echo Invalid choice! Please choose 1, 2, or 3.
    exit /b
)

echo You chose to install %TEXTURE_TYPE%.
echo Proceeding with the installation...

echo Downloading %TEXTURE_TYPE%...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%ZIP_URL%', '%ZIP_FILE%')"

if exist "%ZIP_FILE%" (
    echo Download complete.
) else (
    echo Download failed!
    exit /b
)

echo Removing existing "textures" folder...
rmdir /s /q "%DEST_FOLDER%\textures"

echo Extracting %TEXTURE_TYPE%...

set EXTRACTOR="C:\Program Files\7-Zip\7z.exe"
if exist %EXTRACTOR% (
    "%EXTRACTOR%" x "%ZIP_FILE%" -o"%DEST_FOLDER%" -y
) else (
    set EXTRACTOR="C:\Program Files\WinRAR\winrar.exe"
    if exist %EXTRACTOR% (
        "%EXTRACTOR%" x "%ZIP_FILE%" "%DEST_FOLDER%"
    ) else (
        powershell -Command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%DEST_FOLDER%' -Force"
    )
)

if exist "%DEST_FOLDER%" (
    echo Extraction complete.
) else (
    echo Extraction failed!
    exit /b
)

echo Deleting zip file...
del "%ZIP_FILE%"

echo %TEXTURE_TYPE% installation complete.
pause

endlocal
