# PowerShell script to update hardcoded paths in .vcxproj files
# Replaces hardcoded Visual Studio, Windows SDK, and DirectX SDK paths with macros

$sdkPath = "Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK"
$files = Get-ChildItem -Path $sdkPath -Filter "*.vcxproj" -Recurse

$replacements = @{
    # Windows SDK paths
    'C:\\Program Files %28x86%29\\Microsoft SDKs\\Windows\\v7\.0A\\Include' = '$(WindowsSdkDir)Include'
    'C:\\Program Files %28x86%29\\Microsoft SDKs\\Windows\\v7\.0A\\Lib' = '$(WindowsSdkDir)Lib'
    'C:\\Program Files %28x86%29\\Microsoft SDKs\\Windows\\v7\.1A\\Lib' = '$(WindowsSdkDir)Lib'
    
    # Visual Studio paths
    'C:\\Program Files %28x86%29\\Microsoft Visual Studio 10\.0\\VC\\include' = '$(VCInstallDir)include'
    'C:\\Program Files %28x86%29\\Microsoft Visual Studio 10\.0\\VC\\atlmfc\\include' = '$(VCInstallDir)atlmfc\include'
    'C:\\Program Files %28x86%29\\Microsoft Visual Studio 10\.0\\VC\\lib' = '$(VCInstallDir)lib'
    'C:\\Program Files %28x86%29\\Microsoft Visual Studio 10\.0\\VC\\atlmfc\\lib' = '$(VCInstallDir)atlmfc\lib'
    'C:\\Program Files %28x86%29\\Microsoft Visual Studio 14\.0\\VC\\atlmfc\\include' = '$(VCInstallDir)atlmfc\include'
    
    # DirectX SDK paths (June 2010)
    'C:\\Program Files %28x86%29\\Microsoft DirectX SDK %28June 2010%29\\Include' = '$(DXSDK_DIR)\Include'
    'C:\\Program Files %28x86%29\\Microsoft DirectX SDK %28June 2010%29\\Lib\\x86' = '$(DXSDK_DIR)\Lib\x86'
    
    # DirectX SDK paths (August 2007)
    'C:\\Program Files %28x86%29\\Microsoft DirectX SDK %28August 2007%29\\Include' = '$(DXSDK_DIR)\Include'
    'C:\\Program Files %28x86%29\\Microsoft DirectX SDK %28August 2007%29\\Lib\\x86' = '$(DXSDK_DIR)\Lib\x86'
    
    # DirectX SDK paths (October 2006)
    'C:\\Program Files %28x86%29\\Microsoft DirectX SDK %28October 2006%29\\Lib\\x86' = '$(DXSDK_DIR)\Lib\x86'
    
    # Additional DirectX paths in AdditionalLibraryDirectories
    'C:\\Program Files \(x86\)\\Microsoft DirectX SDK \(June 2010\)\\Lib\\x86' = '$(DXSDK_DIR)\Lib\x86'
    'C:\\Program Files \(x86\)\\Microsoft DirectX SDK \(August 2007\)\\Lib\\x86' = '$(DXSDK_DIR)\Lib\x86'
    'C:\\Program Files \(x86\)\\Microsoft DirectX SDK \(October 2006\)\\Lib\\x86' = '$(DXSDK_DIR)\Lib\x86'
}

$updatedFiles = @()

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    $modified = $false
    
    foreach ($pattern in $replacements.Keys) {
        $replacement = $replacements[$pattern]
        if ($content -match $pattern) {
            $content = $content -replace $pattern, $replacement
            $modified = $true
        }
    }
    
    if ($modified) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        $updatedFiles += $file.Name
        Write-Host "Updated: $($file.Name)"
    }
}

Write-Host "`nTotal files updated: $($updatedFiles.Count)"
$updatedFiles | ForEach-Object { Write-Host "  - $_" }
