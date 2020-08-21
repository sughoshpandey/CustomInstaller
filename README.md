# NSIS Custom Installer
_Pre-requisite : NSIS Installer and built exe of application_<br>

## Instructions

*NSIS custom script - configuration.nsi*<br>
Follow the instructions exactly and double check the folder structure as per instructions below: <br>
1. Make the following directories if they don't exist already inside the root dir which contains "configuration.nsi": <br>
 * BuiltApplicationFiles
 * Installer
 * Resource
2. Place all built application data in folder "BuiltApplicationFiles". Should have all the files required for the exe to run.
3. Place all files required for the installer in "Resource". Eg - place all icons, license details, copyright details shown in the installer in this directory.
4. Open "configuration.nsi" and edit in the details for your custom installer.
 *  MUI_HEADERIMAGE_BITMAP - Left column bitmap image *MUST BE bmp FORMAT*. Should exist in Resource folder
 *  MUI_ICON - Icon image *MUST BE .ico FORMAT*. Should exist in Resource folder
 *  MUI_UNICON - Same as MUI_ICON
 *  !define MUI_WELCOMEPAGE_TITLE "Installer Title" - Installer title
 *  !insertmacro MUI_PAGE_LICENSE "Resource\License.md" - License File, should exist in Resource folder
 *  ; Settings ----------------------------------------------
    *   Name "Setup Name (eg ABC Setup)" - Name of setup <br>
    *   OutFile "$DIR\ExeName (default - Installer\NLBExplorerKIDS_Setup.exe)" <br>
    *   InstallDir $PROGRAMFILES64\[CustomFolderName]<br>
    *   DirText "This will install [ApplicationName] on your Computer. Choose a directory"<br>
    *   ;-------------------------------------------------------
 *  ; Installer ------------------------------------------------
    *   SectionGroup /e "Files" ; DefaultSec

    *   ; Default ------------------------------------
    *   Section "Compulsory" DefaultSec 
        *   SectionIn RO
        *   SetOutPath $INSTDIR
        *   File /r BuiltApplicationFiles\*
        *   WriteUninstaller $INSTDIR\[ApplicationName_Uninstaller.exe] 
    
        *   CreateDirectory "$SMPROGRAMS\[ApplicationName]"
        
    *   SectionEnd
    *   ;-------------------------------------------
 *  ; Uninstall -------------------------------------
    *   Section "Uninstall"

    *   Delete $INSTDIR\[Application_uninstaller.exe]
    *   RMDir /r "$INSTDIR"

    *   RMDIR "$SMPROGRAMS\[ApplicationName]"

5. To double check search for keyword "Application". You need to update it with your current application name.
6. Addition details - 
    * To create a shortcut in startmenu command - createShortCut "$SMPROGRAMS\[ApplicationName]\[Shortcutname].lnk" "$INSTDIR\[ApplicationName].exe" "[CommandlineArgs]"  - *ADD IN INSTALLER SECTION OF CONFIGURATION.NSI*
7. Save "configuration.nsi"
8. Open "configuration.nsi" in NSIS software and run build. After execution ends, you'll find installer created in *INSTALLER* folder.


## MUST FOLLOW GUIDELINES
1. Every installer should have an unistaller built along side.
2. When making uninstaller, make sure to remove *ALL FILES AND SHORTCUTS*

## Issues 
*REFER TO "configDemo.nsi" for reference <br>
Raise issue or contact contributors on Slack.