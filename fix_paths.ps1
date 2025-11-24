# PowerShell script to fix hardcoded paths in .vcxproj files
# This script replaces hardcoded paths with Visual Studio macros

$files = Get-ChildItem -Path "Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK" -Filter "*.vcxproj" -Recurse

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Replace hardcoded Windows SDK paths
    $content = $content -replace 'C:\\Program Files %28x86%29\\Microsoft SDKs\\Windows\\v7\.0A\\Include', '$(WindowsSdkDir)Include'
    $content = $content -replace 'C:\\Program Files %28x86%29\\Microsoft SDKs\\Windows\\v7\.0A\\Lib', '$(WindowsSdkDir)Lib'
    
    # Replace hardcoded Visual Studio 10.0 paths
    $content = $content -replace 'C:\\Program Files %28x86%29\\Microsoft Visual Studio 10\.0\\VC\\include', '$(VCInstallDir)include'
    $content = $content -replace 'C:\\Program Files %28x86%29\\Microsoft Visual Studio 10\.0\\VC\\atlmfc\\include', '$(VCInstallDir)atlmfc\include'
    $content = $content -replace 'C:\\Program Files %28x86%29\\Microsoft Visual Studio 10\.0\\VC\\lib', '$(VCInstallDir)lib'
    $content = $content -replace 'C:\\Program Files %28x86%29\\Microsoft Visual Studio 10\.0\\VC\\atlmfc\\lib', '$(VCInstallDir)atlmfc\lib'
    
    # Replace DirectX SDK paths (June 2010 and August 2007)
    $content = $content -replace 'C:\\Program Files %28x86%29\\Microsoft DirectX SDK %28June 2010%29\\Include', '$(DXSDK_DIR)\Include'
    $content = $content -replace 'C:\\Program Files %28x86%29\\Microsoft DirectX SDK %28June 2010%29\\Lib\\x86', '$(DXSDK_DIR)\Lib\x86'
    $content = $content -replace 'C:\\Program Files %28x86%29\\Microsoft DirectX SDK %28August 2007%29\\Include', '$(DXSDK_DIR)\Include'
    $content = $content -replace 'C:\\Program Files %28x86%29\\Microsoft DirectX SDK %28August 2007%29\\Lib\\x86', '$(DXSDK_DIR)\Lib\x86'
    $content = $content -replace 'C:\\Program Files %28x86%29\\Microsoft DirectX SDK %28October 2006%29\\Lib\\x86', '$(DXSDK_DIR)\Lib\x86'
    
    # Replace AdditionalLibraryDirectories paths
    $content = $content -replace 'C:\\Program Files \(x86\)\\Microsoft DirectX SDK \(October 2006\)\\Lib\\x86', '$(DXSDK_DIR)\Lib\x86'
    $content = $content -replace 'C:\\Program Files \(x86\)\\Microsoft DirectX SDK \(August 2007\)\\Lib\\x86', '$(DXSDK_DIR)\Lib\x86'
    $content = $content -replace 'C:\\Program Files \(x86\)\\Microsoft DirectX SDK \(June 2010\)\\Lib\\x86', '$(DXSDK_DIR)\Lib\x86'
    
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
    Write-Host "Fixed: $($file.Name)"
}

Write-Host "Done!"



