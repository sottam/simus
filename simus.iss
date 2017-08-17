; -- SimusWin.iss --


[Setup]
AppName=SimusWin
AppVerName=SimusWin version 1.0 alfa
DefaultDirName={pf}\SimusWin
DefaultGroupName=SimusWin
UninstallDisplayIcon={app}\SimusWin.exe

[Files]
Source: "simusWin.exe"; DestDir: "{app}"
Source: "simusWin.chm"; DestDir: "{app}"
Source: "simusWin.pdf"; DestDir: "{app}"; Flags: isreadme
; Source: "SimusFontes.zip"; DestDir: "{app}"

Source: "Exemplos\*"; DestDir: "{app}";

[Icons]
Name: "{group}\SimusWin"; Filename: "{app}\simusWin.exe"; WorkingDir: "{app}"

