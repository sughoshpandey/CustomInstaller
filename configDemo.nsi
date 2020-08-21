!include "MUI2.nsh"
!include Sections.nsh
!include LogicLib.nsh


; Interface Settings ----------------

!define MUI_ABORTWARNING
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "Resource\left.bmp"
!define MUI_ICON "Resource\iconImage.ico"
!define MUI_UNICON "Resource\iconImage.ico"

;--------------------------------



; Pages -------------------------

    !define MUI_WELCOMEFINISHPAGE_BITMAP "Resource\left.bmp"
    !define MUI_WELCOMEPAGE_TITLE "NLB ExplorerKIDS Installer"
    !define MUI_WELCOMEPAGE_TITLE_3LINES 
    !define MUI_WELCOMEPAGE_TEXT "Click 'Next' to continue installation!"
!insertmacro MUI_PAGE_WELCOME

    !define MUI_LICENSEPAGE_TEXT_TOP "License"
    !define MUI_LICENSEPAGE_TEXT_BOTTOM "Agree to continue"
!insertmacro MUI_PAGE_LICENSE "Resource\License.md"

    !define MUI_COMPONENTSPAGE_TEXT_TOP "Custom Installer"
    !define MUI_COMPONENTSPAGE_TEXT_DESCRIPTION_TITLE "Select components to install"
!insertmacro MUI_PAGE_COMPONENTS

    !define MUI_DIRECTORYPAGE_TEXT_TOP "Select Directory"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES


    !define MUI_FINISHPAGE_TITLE "Installation Successful"
    !define MUI_FINISHPAGE_TITLE_3LINES
    !define MUI_FINISHPAGE_BUTTON "Finish!"
    !define MUI_FINISHPAGE_SHOWREADME_TEXT "View Readme"
    !define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\Readme.txt"
    !define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
!insertmacro MUI_PAGE_FINISH
;------------------------------

;Languages -------------------------

  !insertmacro MUI_LANGUAGE "English"

;--------------------------------

; Settings ----------------------------------------------

Name "NLB ExplorerKIDS SCAR Setup"
OutFile "Installer\NLBExplorerKIDS_Setup.exe"
InstallDir $PROGRAMFILES64\NLB
DirText "This will install NLB Scar Village and Jam on your Computer. Choose a directory"
;-------------------------------------------------------

; Installer ------------------------------------------------
SectionGroup /e "Files" ; DefaultSec

    ; Default ------------------------------------
    Section "Compulsory" DefaultSec 
        SectionIn RO
        SetOutPath $INSTDIR
        File /r Latest\*
        WriteUninstaller $INSTDIR\NLBScar_Uninstaller.exe
    
        CreateDirectory "$SMPROGRAMS\NLB Scar"
        createShortCut "$SMPROGRAMS\NLB Scar\NLB ExplorerKIDS (Village).lnk" "$INSTDIR\NLBExplorerKids.exe" "-village"
        createShortCut "$SMPROGRAMS\NLB Scar\NLB ExplorerKIDS (Jam).lnk" "$INSTDIR\NLBExplorerKids.exe" "-jam"
    SectionEnd
    ;-------------------------------------------

    ; Village Installer --------------------------
    Section "NLB Village Shortcut" VillageSec 
        createShortCut "$DESKTOP\NLB ExplorerKIDS (Village).lnk" "$INSTDIR\NLBExplorerKids.exe" "-village"
    SectionEnd
    ;--------------------------------------------


    ; Jam Installer ------------------------------
    Section "NLB Jam Shortcut" JamSec 
        createShortCut "$DESKTOP\NLB ExplorerKIDS (Jam).lnk" "$INSTDIR\NLBExplorerKids.exe" "-jam" 
    SectionEnd
    ;--------------------------------------------



SectionGroupEnd
;---------------------------------------



; Description ------------------------------

LangString DESC_DefSec ${LANG_ENGLISH} "Compulsort Files for running the application"
LangString DESC_VillageSec ${LANG_ENGLISH} "Create a desktop shortcut for Village"
LangString DESC_JamSec ${LANG_ENGLISH} "Create a desktop shortcut for Jam"

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${DefaultSec} $(DESC_DefSec)
  !insertmacro MUI_DESCRIPTION_TEXT ${VillageSec} $(DESC_VillageSec)
  !insertmacro MUI_DESCRIPTION_TEXT ${JamSec} $(DESC_JamSec)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

 
; Uninstall -------------------------------------
Section "Uninstall"

Delete $INSTDIR\NLBScar_Uninstaller.exe
RMDir /r "$INSTDIR"

Delete "$SMPROGRAMS\NLB Scar\NLB ExplorerKIDS (Jam).lnk"
Delete "$SMPROGRAMS\NLB Scar\NLB ExplorerKIDS (Village).lnk"
RMDIR "$SMPROGRAMS\NLB Scar"

Delete "$DESKTOP\NLB ExplorerKIDS (Jam).lnk"
Delete "$DESKTOP\NLB ExplorerKIDS (Village).lnk"
;RMDIR "$DESKTOP\NLB Scar"

SectionEnd