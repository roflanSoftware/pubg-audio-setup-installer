; Build with Inno Setup 6.  The compiled installer is written to dist\.
; It packages the supplied Equalizer APO, Peace, VSTs, and presets for private use.

#define AppName "PUBG Audio Setup"
#define AppVersion "1.0.0"

[Setup]
AppId={{EDE5F7BF-663B-4B93-9B9F-E789D2C7EA85}
AppName={#AppName}
AppVersion={#AppVersion}
DefaultDirName={autopf}\EqualizerAPO
DisableDirPage=yes
DisableProgramGroupPage=yes
CreateAppDir=no
Uninstallable=no
PrivilegesRequired=admin
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
OutputDir=..\dist
OutputBaseFilename=PUBG-Audio-Setup
Compression=lzma2/ultra64
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "en"; MessagesFile: "compiler:Default.isl"
Name: "ru"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "uk"; MessagesFile: "compiler:Languages\Ukrainian.isl"

[Files]
Source: "..\payload\EqualizerAPO-x64-1.4.2.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall ignoreversion
Source: "..\payload\PeaceSetup.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall ignoreversion
Source: "..\payload\vst\*"; DestDir: "{tmp}\vst"; Flags: recursesubdirs createallsubdirs deleteafterinstall ignoreversion
Source: "..\payload\config.txt"; DestDir: "{tmp}"; Flags: deleteafterinstall ignoreversion
Source: "..\payload\compressor\*"; DestDir: "{tmp}\compressor"; Flags: recursesubdirs createallsubdirs deleteafterinstall ignoreversion

[Code]
var
  EqFilePage: TInputFileWizardPage;
  EqSourceFile: String;
  UsePersonalEq: Boolean;
  EapoConfigDir: String;

function StartsWith(const Value, Prefix: String): Boolean;
begin
  Result := CompareText(Copy(Trim(Value), 1, Length(Prefix)), Prefix) = 0;
end;

function IsZeroPreamp(const Line: String): Boolean;
var
  Value: String;
  I: Integer;
begin
  Value := Trim(Copy(Line, Length('Preamp:') + 1, MaxInt));
  Result := True;
  for I := 1 to Length(Value) do begin
    if (Value[I] >= '1') and (Value[I] <= '9') then begin
      Result := False;
      Exit;
    end;
  end;
end;

function GetEapoConfigDir: String;
var
  ConfigPath: String;
begin
  ConfigPath := '';
  if not RegQueryStringValue(HKLM64, 'SOFTWARE\EqualizerAPO', 'ConfigPath', ConfigPath) then
    RegQueryStringValue(HKLM, 'SOFTWARE\EqualizerAPO', 'ConfigPath', ConfigPath);

  if ConfigPath <> '' then
    Result := RemoveBackslashUnlessRoot(ConfigPath)
  else
    Result := ExpandConstant('{autopf}\EqualizerAPO\config');
end;

function ReadEapoConfigDir(Param: String): String;
begin
  Result := GetEapoConfigDir;
end;

function GetEapoInstallDir: String;
begin
  Result := RemoveBackslashUnlessRoot(ExtractFileDir(GetEapoConfigDir));
end;

function ReadEditorExe(Param: String): String;
begin
  Result := AddBackslash(GetEapoInstallDir) + 'Editor.exe';
end;

function ReadPeaceExe(Param: String): String;
begin
  Result := AddBackslash(GetEapoConfigDir) + 'Peace.exe';
end;

function ShouldOpenPeace: Boolean;
begin
  Result := UsePersonalEq;
end;

function IsEapoInstalled: Boolean;
var
  ConfigPath: String;
begin
  ConfigPath := GetEapoConfigDir;
  Result := FileExists(AddBackslash(ConfigPath) + 'config.txt') or
    FileExists(ExpandConstant('{autopf}\EqualizerAPO\Editor.exe'));
end;

function RunRequiredInstaller(const FileName, ProductName: String): Boolean;
var
  ResultCode: Integer;
begin
  Result := Exec(FileName, '', '', SW_SHOW, ewWaitUntilTerminated, ResultCode);
  if not Result then begin
    MsgBox('Could not start ' + ProductName + '.', mbError, MB_OK);
    Exit;
  end;
  if ResultCode <> 0 then begin
    MsgBox(ProductName + ' ended with code ' + IntToStr(ResultCode) +
      '. The PUBG audio configuration was not changed.', mbError, MB_OK);
    Result := False;
  end;
end;

function MakePeaceConfig(const SourceFile, DestinationFile: String): Boolean;
var
  SourceLines, OutputLines: TArrayOfString;
  I, Count: Integer;
  Line: String;
begin
  Result := LoadStringsFromFile(SourceFile, SourceLines);
  if not Result then
    Exit;

  SetArrayLength(OutputLines, GetArrayLength(SourceLines) + 2);
  OutputLines[0] := 'Device: all';
  OutputLines[1] := 'Channel: all';
  Count := 2;

  for I := 0 to GetArrayLength(SourceLines) - 1 do begin
    Line := Trim(SourceLines[I]);
    if (Line = '') or StartsWith(Line, 'Device:') or StartsWith(Line, 'Channel:') then
      Continue;
    if StartsWith(Line, 'Preamp:') and IsZeroPreamp(Line) then
      Continue;
    OutputLines[Count] := Line;
    Count := Count + 1;
  end;

  SetArrayLength(OutputLines, Count);
  Result := SaveStringsToFile(DestinationFile, OutputLines, False);
end;

function TextBetween(const Value, LeftText, RightText: String): String;
var
  StartPos, EndPos: Integer;
  Remainder: String;
begin
  Result := '';
  StartPos := Pos(LeftText, Value);
  if StartPos = 0 then
    Exit;
  Remainder := Copy(Value, StartPos + Length(LeftText), MaxInt);
  EndPos := Pos(RightText, Remainder);
  if EndPos = 0 then
    Exit;
  Result := Trim(Copy(Remainder, 1, EndPos - 1));
end;

function FirstWord(const Value: String): String;
var
  SpacePos: Integer;
begin
  Result := Trim(Value);
  SpacePos := Pos(' ', Result);
  if SpacePos > 0 then
    Result := Copy(Result, 1, SpacePos - 1);
end;

procedure AddOutputLine(var Lines: TArrayOfString; var Count: Integer; const Value: String);
begin
  SetArrayLength(Lines, Count + 1);
  Lines[Count] := Value;
  Count := Count + 1;
end;

function PeaceFilterCode(const FilterType: String): String;
begin
  Result := '';
  if (CompareText(FilterType, 'LS') = 0) or (CompareText(FilterType, 'LSC') = 0) then
    Result := '4'
  else if (CompareText(FilterType, 'HS') = 0) or (CompareText(FilterType, 'HSC') = 0) then
    Result := '5';
end;

function WriteMainConfigFromTemplate(const TemplateFile, DestinationFile: String;
  IncludePersonalEq: Boolean): Boolean;
var
  Lines: TArrayOfString;
  I: Integer;
  Line, Trimmed: String;
begin
  Result := LoadStringsFromFile(TemplateFile, Lines);
  if not Result then
    Exit;

  for I := 0 to GetArrayLength(Lines) - 1 do begin
    Line := Lines[I];
    StringChange(Line, 'C:\Program Files\EqualizerAPO\config\vst\FabFilter Pro-MB.dll',
      AddBackslash(EapoConfigDir) + 'vst\FabFilter Pro-MB.dll');
    StringChange(Line, '..\config\vst\FabFilter Pro-MB.dll',
      AddBackslash(EapoConfigDir) + 'vst\FabFilter Pro-MB.dll');
    StringChange(Line, 'C:\Program Files\EqualizerAPO\config\vst\FabFilter Pro-C 2.dll',
      AddBackslash(EapoConfigDir) + 'vst\FabFilter Pro-C 2.dll');
    StringChange(Line, '..\config\vst\FabFilter Pro-C 2.dll',
      AddBackslash(EapoConfigDir) + 'vst\FabFilter Pro-C 2.dll');
    StringChange(Line, 'C:\Program Files\EqualizerAPO\config\vst\FabFilter Pro-C 3.dll',
      AddBackslash(EapoConfigDir) + 'vst\FabFilter Pro-C 3.dll');
    StringChange(Line, '..\config\vst\FabFilter Pro-C 3.dll',
      AddBackslash(EapoConfigDir) + 'vst\FabFilter Pro-C 3.dll');
    StringChange(Line, 'C:\Program Files\EqualizerAPO\config\vst\reacomp-standalone.dll',
      AddBackslash(EapoConfigDir) + 'vst\reacomp-standalone.dll');
    StringChange(Line, '..\config\vst\reacomp-standalone.dll',
      AddBackslash(EapoConfigDir) + 'vst\reacomp-standalone.dll');

    Trimmed := Trim(Line);
    { The template controls which VSTs and presets are enabled. Only the
      Peace include is changed here when no personal EQ is supplied. }
    if CompareText(Trimmed, '# Include: peace.txt') = 0 then begin
      if IncludePersonalEq then
        Line := 'Include: peace.txt'
      else
        Line := '# Include: peace.txt';
    end;
    Lines[I] := Line;
  end;

  { SaveStringsToFile writes ASCII and changes unsupported characters to '?'.
    The configuration template contains Cyrillic comments, so preserve them
    in UTF-8 instead. }
  Result := SaveStringsToUTF8File(DestinationFile, Lines, False);
end;

function MakePeacePreset(const SourceFile, DestinationFile: String): Boolean;
var
  SourceLines, OutputLines, Frequencies, Gains, Qualities, FilterTypes: TArrayOfString;
  Disabled: TArrayOfBoolean;
  I, Index, Count, HighestIndex: Integer;
  Line, FilterType, PreAmp: String;
begin
  Result := LoadStringsFromFile(SourceFile, SourceLines);
  if not Result then
    Exit;

  SetArrayLength(Frequencies, 32);
  SetArrayLength(Gains, 32);
  SetArrayLength(Qualities, 32);
  SetArrayLength(FilterTypes, 32);
  SetArrayLength(Disabled, 32);
  HighestIndex := 0;
  PreAmp := '';

  for I := 0 to GetArrayLength(SourceLines) - 1 do begin
    Line := Trim(SourceLines[I]);
    if StartsWith(Line, 'Preamp:') then begin
      PreAmp := TextBetween(Line, 'Preamp:', 'dB');
      Continue;
    end;
    if not StartsWith(Line, 'Filter ') then
      Continue;

    Index := StrToIntDef(TextBetween(Line, 'Filter ', ':'), 0);
    if (Index < 1) or (Index > 31) then
      Continue;
    Frequencies[Index] := TextBetween(Line, 'Fc ', 'Hz');
    Gains[Index] := TextBetween(Line, 'Gain ', 'dB');
    Qualities[Index] := FirstWord(TextBetween(Line, 'Q ', ' '));
    if Qualities[Index] = '' then
      Qualities[Index] := FirstWord(Copy(Line, Pos('Q ', Line) + 2, MaxInt));
    if Pos('ON ', Line) > 0 then
      FilterType := FirstWord(Copy(Line, Pos('ON ', Line) + 3, MaxInt))
    else
      FilterType := FirstWord(Copy(Line, Pos('OFF ', Line) + 4, MaxInt));
    if StartsWith(Line, 'Filter ' + IntToStr(Index) + ': OFF') then
      Disabled[Index] := True;
    FilterTypes[Index] := PeaceFilterCode(FilterType);
    if Index > HighestIndex then
      HighestIndex := Index;
  end;

  if HighestIndex = 0 then begin
    Result := False;
    Exit;
  end;

  Count := 0;
  AddOutputLine(OutputLines, Count, '[Frequencies]');
  for I := 1 to HighestIndex do
    if Frequencies[I] <> '' then
      AddOutputLine(OutputLines, Count, 'Frequency' + IntToStr(I) + '=' + Frequencies[I]);
  AddOutputLine(OutputLines, Count, '[Gains]');
  for I := 1 to HighestIndex do
    if Gains[I] <> '' then
      AddOutputLine(OutputLines, Count, 'Gain' + IntToStr(I) + '=' + Gains[I]);
  AddOutputLine(OutputLines, Count, '[Qualities]');
  for I := 1 to HighestIndex do
    if Qualities[I] <> '' then
      AddOutputLine(OutputLines, Count, 'Quality' + IntToStr(I) + '=' + Qualities[I]);
  AddOutputLine(OutputLines, Count, '[Filters]');
  for I := 1 to HighestIndex do
    if FilterTypes[I] <> '' then
      AddOutputLine(OutputLines, Count, 'Filter' + IntToStr(I) + '=' + FilterTypes[I]);
  AddOutputLine(OutputLines, Count, '[Disabled]');
  for I := 1 to HighestIndex do
    if Disabled[I] then
      AddOutputLine(OutputLines, Count, 'Disabled' + IntToStr(I) + '=1');
  AddOutputLine(OutputLines, Count, '[General]');
  if (PreAmp <> '') and not IsZeroPreamp('Preamp: ' + PreAmp) then
    AddOutputLine(OutputLines, Count, 'PreAmp=' + PreAmp);
  AddOutputLine(OutputLines, Count, '[Speakers]');
  AddOutputLine(OutputLines, Count, 'SpeakerId0=0');
  AddOutputLine(OutputLines, Count, 'SpeakerTargets0=all');
  AddOutputLine(OutputLines, Count, 'SpeakerName0=All');
  AddOutputLine(OutputLines, Count, 'SpeakerId1=1');
  AddOutputLine(OutputLines, Count, 'SpeakerTargets1=L');
  AddOutputLine(OutputLines, Count, 'SpeakerName1=Left');
  AddOutputLine(OutputLines, Count, 'SpeakerId2=2');
  AddOutputLine(OutputLines, Count, 'SpeakerTargets2=R');
  AddOutputLine(OutputLines, Count, 'SpeakerName2=Right');
  AddOutputLine(OutputLines, Count, 'SpeakerId3=3');
  AddOutputLine(OutputLines, Count, 'SpeakerTargets3=C');
  AddOutputLine(OutputLines, Count, 'SpeakerName3=Center');
  AddOutputLine(OutputLines, Count, 'SpeakerId4=4');
  AddOutputLine(OutputLines, Count, 'SpeakerTargets4=SUB');
  AddOutputLine(OutputLines, Count, 'SpeakerName4=Subwoofer');
  AddOutputLine(OutputLines, Count, 'SpeakerId5=5');
  AddOutputLine(OutputLines, Count, 'SpeakerTargets5=RL');
  AddOutputLine(OutputLines, Count, 'SpeakerName5=Left rear');
  AddOutputLine(OutputLines, Count, 'SpeakerId6=6');
  AddOutputLine(OutputLines, Count, 'SpeakerTargets6=RR');
  AddOutputLine(OutputLines, Count, 'SpeakerName6=Right rear');
  AddOutputLine(OutputLines, Count, 'SpeakerId7=7');
  AddOutputLine(OutputLines, Count, 'SpeakerTargets7=SL');
  AddOutputLine(OutputLines, Count, 'SpeakerName7=Left side');
  AddOutputLine(OutputLines, Count, 'SpeakerId8=8');
  AddOutputLine(OutputLines, Count, 'SpeakerTargets8=SR');
  AddOutputLine(OutputLines, Count, 'SpeakerName8=Right side');
  Result := SaveStringsToFile(DestinationFile, OutputLines, False);
end;

procedure CopyRequiredFile(const SourceFile, DestinationFile: String);
begin
  if not CopyFile(SourceFile, DestinationFile, False) then
    RaiseException('Could not copy ' + ExtractFileName(SourceFile) + ' to ' + DestinationFile + '.');
end;

procedure WriteReacompPreset(const SourceFile, DestinationFile, VstDir: String);
var
  Lines: TArrayOfString;
  I: Integer;
begin
  if not LoadStringsFromFile(SourceFile, Lines) then
    RaiseException('Could not read ' + SourceFile + '.');
  for I := 0 to GetArrayLength(Lines) - 1 do
    StringChange(Lines[I], 'C:\Program Files\VSTPlugins\ReaPlugs\reacomp-standalone.dll',
      AddBackslash(VstDir) + 'reacomp-standalone.dll');
  for I := 0 to GetArrayLength(Lines) - 1 do
    StringChange(Lines[I], 'C:\Program Files\EqualizerAPO\config\vst\reacomp-standalone.dll',
      AddBackslash(VstDir) + 'reacomp-standalone.dll');
  if not SaveStringsToFile(DestinationFile, Lines, False) then
    RaiseException('Could not write ' + DestinationFile + '.');
end;

procedure CopyCompressorFolder(const SourceDir, DestinationDir, VstDir: String);
var
  FindData: TFindRec;
  SourcePath, DestinationPath: String;
begin
  ForceDirectories(DestinationDir);
  if FindFirst(AddBackslash(SourceDir) + '*', FindData) then begin
    try
      repeat
        if (FindData.Name <> '.') and (FindData.Name <> '..') then begin
          SourcePath := AddBackslash(SourceDir) + FindData.Name;
          DestinationPath := AddBackslash(DestinationDir) + FindData.Name;
          if (FindData.Attributes and FILE_ATTRIBUTE_DIRECTORY) <> 0 then
            CopyCompressorFolder(SourcePath, DestinationPath, VstDir)
          else if CompareText(ExtractFileExt(FindData.Name), '.txt') = 0 then
            WriteReacompPreset(SourcePath, DestinationPath, VstDir)
          else
            CopyRequiredFile(SourcePath, DestinationPath);
        end;
      until not FindNext(FindData);
    finally
      FindClose(FindData);
    end;
  end;
end;

procedure DeployConfiguration;
var
  BackupDir, VstDir, CompressorDir, PeacePreset: String;
begin
  EapoConfigDir := GetEapoConfigDir;
  if not DirExists(EapoConfigDir) then
    RaiseException('Equalizer APO configuration folder was not found: ' + EapoConfigDir);

  BackupDir := AddBackslash(EapoConfigDir) + 'PUBG Audio Setup Backup ' +
    GetDateTimeString('yyyy-mm-dd hh-nn-ss', '-', '-');
  if FileExists(AddBackslash(EapoConfigDir) + 'config.txt') then begin
    ForceDirectories(BackupDir);
    CopyRequiredFile(AddBackslash(EapoConfigDir) + 'config.txt',
      AddBackslash(BackupDir) + 'config.txt');
  end;

  VstDir := AddBackslash(EapoConfigDir) + 'vst';
  CompressorDir := AddBackslash(EapoConfigDir) + 'compressor';
  ForceDirectories(VstDir);
  ForceDirectories(CompressorDir);

  CopyRequiredFile(ExpandConstant('{tmp}\vst\reacomp-standalone.dll'),
    AddBackslash(VstDir) + 'reacomp-standalone.dll');
  CopyRequiredFile(ExpandConstant('{tmp}\vst\FabFilter Pro-MB.dll'),
    AddBackslash(VstDir) + 'FabFilter Pro-MB.dll');
  CopyRequiredFile(ExpandConstant('{tmp}\vst\FabFilter Pro-C 2.dll'),
    AddBackslash(VstDir) + 'FabFilter Pro-C 2.dll');
  CopyRequiredFile(ExpandConstant('{tmp}\vst\FabFilter Pro-C 3.dll'),
    AddBackslash(VstDir) + 'FabFilter Pro-C 3.dll');
  CopyCompressorFolder(ExpandConstant('{tmp}\compressor'), CompressorDir, VstDir);

  if UsePersonalEq then begin
    if not MakePeaceConfig(EqSourceFile, AddBackslash(EapoConfigDir) + 'peace.txt') then
      RaiseException('Could not create peace.txt from the selected EQ file.');

    PeacePreset := AddBackslash(EapoConfigDir) + '_pubg-config.peace';
    if not MakePeacePreset(EqSourceFile, PeacePreset) then
      RaiseException('Could not create the _pubg-config Peace preset from the selected EQ file.');
    CopyRequiredFile(PeacePreset, AddBackslash(EapoConfigDir) + 'Last Configuration.peace');
    SetIniString('General', 'Selected Configuration', '_pubg-config',
      AddBackslash(EapoConfigDir) + 'peace.ini');
  end;

  if not WriteMainConfigFromTemplate(ExpandConstant('{tmp}\config.txt'),
    AddBackslash(EapoConfigDir) + 'config.txt', UsePersonalEq) then
    RaiseException('Could not write Equalizer APO config.txt.');
end;

procedure InitializeWizard;
begin
  EqFilePage := CreateInputFilePage(wpSelectDir,
    'Personal equalizer configuration',
    'Optionally select your personal EQ text file',
    'This step is optional. Select the .txt file that contains your headphone EQ filters to ' +
    'import it, or leave the field empty to install the PUBG audio setup without a personal EQ. ' +
    'When a file is selected, the installer creates peace.txt with Device: all and Channel: all, ' +
    'and removes a zero-dB preamp line.');
  EqFilePage.Add('Personal EQ file (optional):', 'Text files (*.txt)|*.txt|All files (*.*)|*.*', '.txt');
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result := True;
  if CurPageID = EqFilePage.ID then begin
    EqSourceFile := Trim(EqFilePage.Values[0]);
    UsePersonalEq := EqSourceFile <> '';
    if UsePersonalEq and not FileExists(EqSourceFile) then begin
      MsgBox('Choose a valid personal EQ .txt file before continuing.', mbError, MB_OK);
      Result := False;
    end;
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep <> ssPostInstall then
    Exit;

  if not IsEapoInstalled then begin
    if not RunRequiredInstaller(ExpandConstant('{tmp}\EqualizerAPO-x64-1.4.2.exe'), 'Equalizer APO setup') then
      Abort;
  end;

  EapoConfigDir := GetEapoConfigDir;
  if not FileExists(AddBackslash(EapoConfigDir) + 'Peace.exe') then begin
    if not RunRequiredInstaller(ExpandConstant('{tmp}\PeaceSetup.exe'), 'Peace setup') then
      Abort;
  end;

  DeployConfiguration;
end;

[Run]
Filename: "{code:ReadEditorExe}"; Description: "Open Equalizer APO Configuration Editor"; Flags: postinstall nowait skipifsilent unchecked
Filename: "{code:ReadPeaceExe}"; Parameters: "_pubg-config"; Description: "Open Peace with _pubg-config selected"; Flags: postinstall nowait skipifsilent unchecked; Check: ShouldOpenPeace
