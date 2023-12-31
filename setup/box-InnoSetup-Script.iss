; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "BOXES"
#define MyAppVersion "0,24"
#define MyAppPublisher "AzGame"
#define MyAppURL "https://www.azfoxgame.my.cam"
#define MyAppExeName "boxes.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{F0D80DDF-67AF-4A93-852F-CC848B6FE713}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputBaseFilename=boxsetup
Compression=lzma
SolidCompression=yes
WizardStyle=modern
SetupIconFile=linux.ico

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "czech"; MessagesFile: "compiler:Languages\Czech.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl"
Name: "polish"; MessagesFile: "compiler:Languages\Polish.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"
Name: "turkish"; MessagesFile: "compiler:Languages\Turkish.isl"
Name: "ukrainian"; MessagesFile: "compiler:Languages\Ukrainian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "D:\BOXES\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\BOXES\DevIL.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\BOXES\love.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\BOXES\lua51.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\BOXES\mpg123.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\BOXES\msvcp120.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\BOXES\msvcr120.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\BOXES\OpenAL32.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\BOXES\SDL2.dll"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

