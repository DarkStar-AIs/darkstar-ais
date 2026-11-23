#define MyAppName "ATLAS"
#define MyAppVersion "0.1.0"
#define MyAppPublisher "Darkstar AIs"
[Setup]
AppId={{D7B57F47-B81A-44C6-B3F4-1F1AC9A87D91}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={localappdata}\Programs\Darkstar ATLAS
DefaultGroupName=Darkstar ATLAS
OutputDir=output
OutputBaseFilename=ATLAS-Setup-Windows
Compression=lzma2
SolidCompression=yes
PrivilegesRequired=lowest
ArchitecturesAllowed=x64compatible
WizardStyle=modern
UninstallDisplayIcon={app}\ATLAS.exe
[Files]
Source: "dist\ATLAS\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
[Icons]
Name: "{autoprograms}\ATLAS"; Filename: "{app}\ATLAS.exe"
Name: "{autodesktop}\ATLAS"; Filename: "{app}\ATLAS.exe"; Tasks: desktopicon
[Tasks]
Name: desktopicon; Description: "Create a desktop shortcut"; GroupDescription: "Additional shortcuts:"; Flags: checkedonce
[Run]
Filename: "{app}\ATLAS.exe"; Description: "Launch ATLAS"; Flags: nowait postinstall skipifsilent
