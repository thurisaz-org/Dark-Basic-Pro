# PowerShell script to fix hardcoded paths in Phase 2
# Replaces hardcoded Visual Studio, Windows SDK, and DirectX SDK paths with macros

$sdkPath = "Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK"

# Projects that need fixing (from PLAN.md and additional projects found)
$projects = @(
    "Basic2D\Basic2D.vcxproj",
    "Sound\Sound.vcxproj",
    "Animation\Animation.vcxproj",
    "File\File.vcxproj",
    "Image\Image.vcxproj",
    "Objects\Objects.vcxproj",
    "Setup\Setup.vcxproj",
    "Bullet\Bullet.vcxproj",
    "AdvancedMatrix\AdvancedMatrix.vcxproj",
    "Particles\Particles.vcxproj",
    "Sprites\Sprites.vcxproj",
    "Text\Text.vcxproj",
    "System\System.vcxproj",
    "Transforms\Transforms.vcxproj",
    "Bitmap\Bitmap.vcxproj",
    "Input\Input.vcxproj",
    "Memblocks\Memblocks.vcxproj",
    "Music\Music.vcxproj",
    "Core\DBDLLCore.vcxproj",
    "Q2BSP\Q2BSP.vcxproj",
    "Q3BSP\Q3BSP.vcxproj",
    "Vectors\Vectors.vcxproj",
    "Conv3DS\Conv3DS.vcxproj",
    "ConvMD2\ConvMD2.vcxproj",
    "ConvMD3\ConvMD3.vcxproj",
    "ConvMDL\ConvMDL.vcxproj",
    "ConvX\ConvX.vcxproj",
    "CustomBSP\CustomBSP.vcxproj",
    "FTP\FTP.vcxproj",
    "Light\Light.vcxproj",
    "Matrix\Matrix.vcxproj",
    "Multiplayer\Multiplayer.vcxproj",
    "MultiplayerPlus\MultiplayerPlus.vcxproj"
)

# Replacement patterns
$replacements = @{
    # IncludePath replacements
    'C:\\Program Files %28x86%29\\Microsoft SDKs\\Windows\\v7\.0A\\Include;' = '$(WindowsSdkDir)Include;'
    'C:\\Program Files %28x86%29\\Microsoft Visual Studio 10\.0\\VC\\include;' = '$(VCInstallDir)include;'
    'C:\\Program Files %28x86%29\\Microsoft Visual Studio 10\.0\\VC\\atlmfc\\include;' = '$(VCInstallDir)atlmfc\include;'
    'C:\\Program Files %28x86%29\\Microsoft DirectX SDK %28June 2010%29\\Include;' = '$(DXSDK_DIR)\Include;'
    'C:\\Program Files %28x86%29\\Microsoft DirectX SDK %28August 2007%29\\Include;' = '$(DXSDK_DIR)\Include;'
    
    # LibraryPath replacements
    'C:\\Program Files %28x86%29\\Microsoft Visual Studio 10\.0\\VC\\atlmfc\\lib;' = '$(VCInstallDir)atlmfc\lib;'
    'C:\\Program Files %28x86%29\\Microsoft SDKs\\Windows\\v7\.0A\\Lib;' = '$(WindowsSdkDir)Lib;'
    'C:\\Program Files %28x86%29\\Microsoft Visual Studio 10\.0\\VC\\lib;' = '$(VCInstallDir)lib;'
    'C:\\Program Files %28x86%29\\Microsoft DirectX SDK %28June 2010%29\\Lib\\x86;' = '$(DXSDK_DIR)\Lib\x86;'
    'C:\\Program Files %28x86%29\\Microsoft DirectX SDK %28August 2007%29\\Lib\\x86;' = '$(DXSDK_DIR)\Lib\x86;'
}

foreach ($project in $projects) {
    $filePath = Join-Path $sdkPath $project
    if (Test-Path $filePath) {
        Write-Host "Processing $project..."
        $content = Get-Content $filePath -Raw
        
        foreach ($pattern in $replacements.Keys) {
            $replacement = $replacements[$pattern]
            $content = $content -replace $pattern, $replacement
        }
        
        Set-Content -Path $filePath -Value $content -NoNewline
        Write-Host "  Fixed $project"
    } else {
        Write-Host "  File not found: $filePath"
    }
}

Write-Host "`nDone! All projects have been updated."



