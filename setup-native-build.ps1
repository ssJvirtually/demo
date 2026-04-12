# Script to set up Visual Studio environment for GraalVM Native Image
# Run this script to check for Visual Studio Build Tools and configure the environment

Write-Host "Checking for Visual Studio Build Tools..." -ForegroundColor Cyan

# Check for vswhere
$vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"

if (Test-Path $vswhere) {
    Write-Host "Found vswhere at: $vswhere" -ForegroundColor Green
    
    # Check for Build Tools
    $buildToolsPath = & $vswhere -products "Microsoft.VisualStudio.Product.BuildTools" -property installationPath
    
    if ($buildToolsPath) {
        Write-Host "Found Visual Studio Build Tools at: $buildToolsPath" -ForegroundColor Green
        
        # Check for VC++ tools
        $vcVarsAll = Get-ChildItem -Path $buildToolsPath -Filter "vcvarsall.bat" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty FullName
        
        if ($vcVarsAll) {
            Write-Host "Found vcvarsall.bat at: $vcVarsAll" -ForegroundColor Green
            Write-Host "`nTo build native image, run:" -ForegroundColor Yellow
            Write-Host "1. Open 'x64 Native Tools Command Prompt for VS 2022'" -ForegroundColor Yellow
            Write-Host "2. Navigate to your project directory" -ForegroundColor Yellow
            Write-Host "3. Run: mvn clean native:compile -Pnative" -ForegroundColor Yellow
        } else {
            Write-Host "vcvarsall.bat not found. You may need to install C++ build tools." -ForegroundColor Red
        }
    } else {
        Write-Host "Visual Studio Build Tools not found." -ForegroundColor Red
        Write-Host "`nPlease install Visual Studio Build Tools:" -ForegroundColor Yellow
        Write-Host "1. Download from: https://visualstudio.microsoft.com/downloads/" -ForegroundColor Yellow
        Write-Host "2. Select 'Desktop development with C++' workload" -ForegroundColor Yellow
        Write-Host "3. Make sure 'Windows 10/11 SDK' and 'MSVC v143 build tools' are selected" -ForegroundColor Yellow
    }
} else {
    Write-Host "vswhere.exe not found. Visual Studio Installer may not be installed." -ForegroundColor Red
}

Write-Host "`nAlternative: Use the GitHub Actions workflow I created (.github/workflows/native-image.yml)" -ForegroundColor Cyan
Write-Host "This will build the native image on GitHub's Linux servers without needing Visual Studio." -ForegroundColor Cyan
