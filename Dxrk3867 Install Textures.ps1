$host.ui.RawUI.WindowTitle = "Dxrk3867 Textures Installer"

Write-Host "[1] Install Gray Textures"
Write-Host "[2] Install Dark Textures"
Write-Host "[3] Remove Textures (Normal)"
Write-Host ""

$choice = Read-Host "Choose an option [1, 2, 3]"

$DEST_FOLDER = [System.IO.Path]::Combine($env:USERPROFILE, "AppData\Local\Bloxstrap\Versions\version-080ad6451df24461\PlatformContent\pc")

$GRAY_TEXTURES_URL = "https://github.com/Dxrk38677/Rivals-Textures/raw/refs/heads/main/Gray%20Textures.zip"
$DARK_TEXTURES_URL = "https://github.com/Dxrk38677/Rivals-Textures/raw/refs/heads/main/Dark%20Textures.zip"

if ($choice -eq "1") {
    $RAR_URL = $GRAY_TEXTURES_URL
    $RAR_FILE = "$env:TEMP\graytextures.zip"
    $TEXTURE_TYPE = "Gray Textures"
}
elseif ($choice -eq "2") {
    $RAR_URL = $DARK_TEXTURES_URL
    $RAR_FILE = "$env:TEMP\darktextures.zip"
    $TEXTURE_TYPE = "Dark Textures"
}
elseif ($choice -eq "3") {
    Write-Host "Removing existing 'textures' folder..."
    Remove-Item -Path "$DEST_FOLDER\textures" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Textures removed."
    Exit
}
else {
    Write-Host "Invalid choice! Please choose 1, 2, or 3."
    Exit
}

Write-Host "You chose to install $TEXTURE_TYPE."
Write-Host "Proceeding with the installation..."

Write-Host "Downloading $TEXTURE_TYPE..."
try {
    Invoke-WebRequest -Uri $RAR_URL -OutFile $RAR_FILE -ErrorAction Stop
    Write-Host "Download complete."
} catch {
    Write-Host "Download failed! Error: $_"
    Exit
}

Write-Host "Removing existing 'textures' folder..."
Remove-Item -Path "$DEST_FOLDER\textures" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "Extracting $TEXTURE_TYPE..."

if (Test-Path "C:\Program Files\7-Zip\7z.exe") {
    Write-Host "7-Zip found, extracting using 7-Zip..."
    & "C:\Program Files\7-Zip\7z.exe" x $RAR_FILE -o$DEST_FOLDER -y
}
elseif (Test-Path "C:\Program Files\WinRAR\winrar.exe") {
    Write-Host "WinRAR found, extracting using WinRAR..."
    & "C:\Program Files\WinRAR\winrar.exe" x $RAR_FILE $DEST_FOLDER
}
elseif ($RAR_FILE -match "\.zip$") {
    Write-Host "Extracting .zip file using PowerShell Expand-Archive..."
    try {
        Expand-Archive -Path $RAR_FILE -DestinationPath $DEST_FOLDER -Force -ErrorAction Stop
        Write-Host "Extraction complete."
    } catch {
        Write-Host "Failed to extract .zip file! Error: $_"
        Exit
    }
}
else {
    Write-Host "No suitable extractor found! Please install 7-Zip or WinRAR."
    Exit
}

Write-Host "Deleting archive file..."
Remove-Item $RAR_FILE -ErrorAction SilentlyContinue

Write-Host "$TEXTURE_TYPE installation complete."
Pause
