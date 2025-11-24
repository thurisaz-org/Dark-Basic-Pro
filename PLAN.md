# Dark Basic Pro - Update Plan

This document outlines the issues found in the codebase and provides a plan for updating them to make the project more portable and maintainable.

## Executive Summary

The Dark Basic Pro project contains numerous hardcoded paths and outdated configurations that prevent it from working correctly on different systems. This plan identifies all issues and provides a systematic approach to fixing them.

---

## 1. Hardcoded Paths in Project User Files (.vcxproj.user)

### Issue
Multiple `.vcxproj.user` files contain hardcoded `LocalDebuggerWorkingDirectory` paths pointing to non-existent locations:
- `F:\TGCSHARED\fpsc-reloaded\FPS Creator Files\`
- `C:\TGCSHARED\fpsc-reloaded\FPS Creator Reloaded\Install\Projects\...`
- `D:\SteamLibrary\SteamApps\common\...`
- `C:\Users\Lee\Documents\...`

### Affected Files
- `DBProCompiler\DBPCompiler\DBPCompiler.vcxproj.user` ✅ **FIXED**
- `DBProCompiler\DBPCompilerEXE\DarkEXE.vcxproj.user` ✅ **FIXED**
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\Setup\Setup.vcxproj.user` ✅ **FIXED**
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\Objects\Objects.vcxproj.user` ✅ **FIXED**
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\Core\DBDLLCore.vcxproj.user` ✅ **FIXED**
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\Camera\Camera.vcxproj.user` ✅ **FIXED**
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\Bullet\Bullet.vcxproj.user` ✅ **FIXED**

### Solution
Replace all hardcoded `LocalDebuggerWorkingDirectory` values with `$(OutDir)` or `$(ProjectDir)` to use relative paths.

### Priority: **HIGH**

---

## 2. Hardcoded Output Directories in Project Files (.vcxproj)

### Issue
Many `.vcxproj` files contain hardcoded `OutDir` and `OutputFile` paths pointing to:
- `F:\TGCSHARED\fpsc-reloaded\FPS Creator Files\`
- `C:\TGCSHARED\fpsc-reloaded\FPS Creator Reloaded\...`

### Affected Files
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\Camera\Camera.vcxproj`
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\Sound\Sound.vcxproj`
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\Animation\Animation.vcxproj`
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\Basic2D\Basic2D.vcxproj`
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\File\File.vcxproj`
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\Image\Image.vcxproj`
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\Objects\Objects.vcxproj`
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\Setup\Setup.vcxproj`
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\Bullet\Bullet.vcxproj`
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\AdvancedMatrix\AdvancedMatrix.vcxproj`
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\Particles\Particles.vcxproj`
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\Sprites\Sprites.vcxproj`
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\Text\Text.vcxproj`
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\System\System.vcxproj`
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\Transforms\Transforms.vcxproj`
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\Bitmap\Bitmap.vcxproj`
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\Input\Input.vcxproj`
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\Memblocks\Memblocks.vcxproj`
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\Music\Music.vcxproj`
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\Core\DBDLLCore.vcxproj`
- `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDKMore\GameFX\GameFX.vcxproj`
- `DBProCompiler\DBPCompilerEXE\DarkEXE.vcxproj`

### Solution
1. Remove or update `DebugFPSC` configuration-specific `OutDir` settings
2. Replace hardcoded `OutputFile` paths with relative paths using `$(OutDir)` and `$(TargetName)`
3. Ensure all output files go to `$(SolutionDir)Install\Compiler\plugins\` or appropriate relative locations

### Priority: **HIGH**

---

## 3. Hardcoded Include and Library Paths

### Issue
Project files contain hardcoded paths to:
- Visual Studio installations: `C:\Program Files (x86)\Microsoft Visual Studio 10.0\...`
- DirectX SDK: `C:\Program Files (x86)\Microsoft DirectX SDK (June 2010)\...`
- Windows SDK: `C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\...`
- BCG Control Bar: `F:\TGCSHARED\Dark-Basic-Pro\Synergy Editor TGC\BCGControlBarPro(Editor)\...`

### Affected Files
- All SDK project files in `Dark Basic Public Shared\Dark Basic Pro SDK\DarkSDK\`
- `Synergy Editor TGC\Synergy Editor\Synergy Editor.vcxproj`

### Solution
1. Use Visual Studio macros like `$(VCInstallDir)`, `$(WindowsSDKDir)`, `$(DXSDK_DIR)`
2. For DirectX SDK, use environment variable `$(DXSDK_DIR)` or relative paths
3. For BCG Control Bar, use `$(SolutionDir)` relative paths
4. Create a common property sheet (.props) file for shared paths

### Priority: **MEDIUM**

---

## 4. Hardcoded Paths in Synergy Editor Project

### Issue
`Synergy Editor TGC\Synergy Editor\Synergy Editor.vcxproj` contains:
- `F:\TGCSHARED\Dark-Basic-Pro\Synergy Editor TGC\BCGControlBarPro(Editor)\BCGCBPro\`
- `F:\TGCSHARED\Dark-Basic-Pro\Synergy Editor TGC\BCGControlBarPro(Editor)\Bin\`

### Solution
Replace with `$(SolutionDir)` relative paths:
- `$(SolutionDir)BCGControlBarPro(Editor)\BCGCBPro\`
- `$(SolutionDir)BCGControlBarPro(Editor)\Bin\`

### Priority: **MEDIUM**

---

## 5. Hardcoded Paths in Project Data Files

### Issue
`Install\Projects\Hello World\Hello World.dbpro` contains:
- `media root path=F:\DOWNLOADS\Dark Basic Pro\Install\Projects\Hello World\`

### Solution
Replace with relative path:
- `media root path=$(ProjectDir)` or use relative path from project location

### Priority: **LOW**

---

## 6. Outdated Solution File Format

### Issue
`Dark Basic Pro.sln` is marked as "Visual Studio 2012" format (Version 12.00)

### Solution
Update to a more recent format version (though this is generally backward compatible)

### Priority: **LOW**

---

## 7. Deprecated Visual Studio Project Files (.vcproj)

### Issue
Old `.vcproj` files may exist (Visual Studio 2008 format)

### Solution
- Identify any remaining `.vcproj` files
- Migrate to `.vcxproj` format if needed
- Remove obsolete files

### Priority: **LOW**

---

## 8. DirectX SDK Dependency

### Issue
Project requires Microsoft DirectX SDK (August 2007 or June 2010), which is deprecated and may not be available on all systems.

### Solution
1. Document the requirement clearly in README.md
2. Consider migrating to Windows SDK DirectX headers (if possible)
3. Provide installation instructions for DirectX SDK
4. Consider using environment variable `DXSDK_DIR` for path resolution

### Priority: **MEDIUM**

---

## 9. Build Configuration Issues

### Issue
Some projects have `DebugFPSC` configurations that output to hardcoded FPS Creator paths, which may not be relevant for general Dark Basic Pro development.

### Solution
1. Review if `DebugFPSC` configurations are still needed
2. If needed, update paths to use relative locations
3. If not needed, consider removing these configurations

### Priority: **MEDIUM**

---

## 10. Missing or Incorrect Path Macros

### Issue
Some paths use hardcoded locations instead of Visual Studio macros.

### Solution
Create a common property sheet (`.props` file) that defines:
- DirectX SDK path using `$(DXSDK_DIR)` or relative path
- BCG Control Bar paths relative to solution
- Common output directories
- Common include/library paths

### Priority: **MEDIUM**

---

## Implementation Plan

### Phase 1: Critical Path Fixes (Week 1)
1. ✅ Fix `DBPCompiler.vcxproj.user` working directory
2. ✅ Fix all `.vcxproj.user` files with hardcoded working directories
3. ✅ Fix hardcoded output directories in critical project files
4. ⏳ Test compilation after each fix (pending)

### Phase 2: Path Standardization (Week 2)
1. ⏳ Create common property sheet for shared paths (approach defined, implementation ongoing)
2. 🔄 Update all IncludePath and LibraryPath entries (Camera project partially updated, pattern established)
3. ✅ Fix Synergy Editor paths
4. ✅ Update project data files with relative paths

### Phase 3: Configuration Cleanup (Week 3)
1. Review and update/remove DebugFPSC configurations
2. Standardize output directories across all projects
3. Update solution file format if needed
4. Remove obsolete project files

### Phase 4: Documentation and Testing (Week 4)
1. Update README.md with setup instructions
2. Document all required dependencies
3. Create setup guide for new developers
4. Test full solution build on clean system

---

## Testing Checklist

After implementing fixes, verify:
- [ ] All projects compile without path errors
- [ ] Debugger working directories are correct
- [ ] Output files are placed in expected locations
- [ ] Include paths resolve correctly
- [ ] Library paths resolve correctly
- [ ] Solution builds on a clean system
- [ ] No hardcoded absolute paths remain (except system paths via macros)

---

## Notes

- `.vcxproj.user` files are typically not committed to version control, but fixing them helps with initial setup
- Some hardcoded paths may be intentional for specific build configurations
- DirectX SDK requirement should be clearly documented
- Consider creating a setup script to configure environment variables

---

## Tools and Scripts Needed

1. **Path Replacement Script**: PowerShell script to find and replace hardcoded paths
2. **Validation Script**: Script to verify no hardcoded paths remain
3. **Property Sheet Template**: Common `.props` file for shared configurations

---

## Estimated Effort

- **Phase 1**: 4-6 hours
- **Phase 2**: 6-8 hours
- **Phase 3**: 4-6 hours
- **Phase 4**: 4-6 hours
- **Total**: 18-26 hours

---

*Last Updated: 2025-11-24*
*Status: Phase 1 - COMPLETED | Phase 2 - IN PROGRESS (Synergy Editor & project data files fixed, SDK paths partially updated)*

