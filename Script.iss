#define MyAppName "Grilled Cheese"
#define MyAppVersion "1.0"
#define MyAppPublisher "watheusctavares"
#define MyAppURL "https://github.com/watheusctavares/Grilled-Cheese"

[Setup]
AppId={{D4D0CC4F-3129-447D-BEBF-0DD34E1787AE}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
UsePreviousAppDir=no
DefaultDirName={code:GetTS2LCPath}
DisableDirPage=yes
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
PrivilegesRequired=admin
OutputDir=.\
SetupIconFile=.\Icon.ico
OutputBaseFilename=Setup
Compression=lzma/max
SolidCompression=yes
WizardStyle=modern
CreateUninstallRegKey=no
Uninstallable=no

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "Bin\*"; DestDir: "{app}"; Flags: recursesubdirs createallsubdirs ignoreversion

[Run]
Filename: "cmd.exe"; \
  Parameters: "/C mklink /D ""{userdocs}\EA Games\The Sims 2"" ""{userdocs}\EA Games\The Sims 2 Legacy"""; \
  Flags: runhidden runascurrentuser; \
  StatusMsg: "Creating symbolic link..."

[Registry]
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Sims2.exe"; ValueType: string; ValueName: ""; ValueData: "{app}\Base\TSBin\Sims2.exe"; Flags: uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Sims2.exe"; ValueType: string; ValueName: "Game Registry"; ValueData: "Software\EA GAMES\The Sims 2"
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Sims2.exe"; ValueType: dword; ValueName: "Installed"; ValueData: 1
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Sims2.exe"; ValueType: string; ValueName: "Path"; ValueData: "{app}\Base"
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Sims2.exe"; ValueType: dword; ValueName: "Restart"; ValueData: 0
Root: HKCU; Subkey: "Software\Electronic Arts\The Sims 2 Ultimate Collection 25"; ValueType: string; ValueName: "EPsInstalled"; ValueData: "Sims2EP1.exe,Sims2EP2.exe,Sims2EP3.exe,Sims2EP4.exe,Sims2EP5.exe,Sims2EP6.exe,Sims2EP7.exe,Sims2EP8.exe,Sims2EP9.exe,Sims2SP1.exe,Sims2SP2.exe,Sims2SP4.exe,Sims2SP5.exe,Sims2SP6.exe,Sims2SP7.exe,Sims2SP8.exe"
Root: HKCU; Subkey: "Software\Electronic Arts\The Sims 2 Ultimate Collection 25\Sims2SP8.exe"; ValueType: dword; ValueName: "Installed"; ValueData: 1
Root: HKCU; Subkey: "Software\Electronic Arts\The Sims 2 Ultimate Collection 25\Sims2SP8.exe"; ValueType: string; ValueName: "Path"; ValueData: "{app}\SP8"

[Code]
var
  TS2LCPath: string;

function InitializeSetup(): Boolean;
begin
  if not RegQueryStringValue(
    HKEY_CURRENT_USER,
    'SOFTWARE\Electronic Arts\The Sims 2 Ultimate Collection 25\Sims2.exe',
    'Path',
    TS2LCPath) then
  begin
    MsgBox('Game path not found. The installer will exit.', mbError, MB_OK);
    Result := False;
    Exit;
  end;

  Result := True;
end;

function GetTS2LCPath(Value: string): string;
begin
  Result := ExtractFileDir(TS2LCPath);
end;
