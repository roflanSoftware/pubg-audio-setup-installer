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

[CustomMessages]
EqTitle=Personal equalizer configuration
ru.EqTitle=Настройка персонального эквалайзера
uk.EqTitle=Налаштування персонального еквалайзера
EqSubtitle=Select your personal EQ file (optional)
ru.EqSubtitle=Выберите файл настроек эквалайзера (необязательно)
uk.EqSubtitle=Виберіть файл налаштувань еквалайзера (необов’язково)
EqInstructions=Select a .txt file with your headphone EQ filters, or leave the field empty to skip importing a personal EQ.
ru.EqInstructions=Выберите файл .txt с фильтрами эквалайзера для наушников или оставьте поле пустым, чтобы пропустить импорт.
uk.EqInstructions=Виберіть файл .txt із фільтрами еквалайзера для навушників або залиште поле порожнім, щоб пропустити імпорт.
EqFileLabel=Personal EQ file (optional):
ru.EqFileLabel=Файл эквалайзера (необязательно):
uk.EqFileLabel=Файл еквалайзера (необов’язково):
EqFileFilter=Text files (*.txt)|*.txt|All files (*.*)|*.*
ru.EqFileFilter=Текстовые файлы (*.txt)|*.txt|Все файлы (*.*)|*.*
uk.EqFileFilter=Текстові файли (*.txt)|*.txt|Усі файли (*.*)|*.*
EqInvalidFile=Choose a valid personal EQ .txt file before continuing.
ru.EqInvalidFile=Чтобы продолжить, выберите существующий файл настроек эквалайзера в формате .txt.
uk.EqInvalidFile=Щоб продовжити, виберіть наявний файл налаштувань еквалайзера у форматі .txt.
DependencyStartError=Could not start the %1 installer.
ru.DependencyStartError=Не удалось запустить установщик %1.
uk.DependencyStartError=Не вдалося запустити інсталятор %1.
DependencyExitError=The %1 installer ended with code %2. The PUBG audio configuration was not applied.
ru.DependencyExitError=Установщик %1 завершился с кодом %2. Настройки звука PUBG не применены.
uk.DependencyExitError=Інсталятор %1 завершився з кодом %2. Налаштування звуку PUBG не застосовано.
CopyError=Could not copy %1 to %2.
ru.CopyError=Не удалось скопировать %1 в %2.
uk.CopyError=Не вдалося скопіювати %1 до %2.
ReadError=Could not read %1.
ru.ReadError=Не удалось прочитать %1.
uk.ReadError=Не вдалося прочитати %1.
WriteError=Could not write %1.
ru.WriteError=Не удалось записать %1.
uk.WriteError=Не вдалося записати %1.
ConfigFolderMissing=Equalizer APO configuration folder was not found: %1
ru.ConfigFolderMissing=Папка конфигурации Equalizer APO не найдена: %1
uk.ConfigFolderMissing=Папку конфігурації Equalizer APO не знайдено: %1
AutoApoCaption=AutoAPO
ru.AutoApoCaption=AutoAPO
uk.AutoApoCaption=AutoAPO
AutoApoDescription=Automatic switching for PUBG
ru.AutoApoDescription=Автоматическое включение для PUBG
uk.AutoApoDescription=Автоматичне вмикання для PUBG
AutoApoQuestion=Do you want to use AutoAPO to automatically turn the setup on when launching PUBG?%n%nIf not, you will be required to manually turn everything on in Configuration editor each time.
ru.AutoApoQuestion=Хотите использовать AutoAPO, чтобы настройки автоматически включались при запуске PUBG?%n%nЕсли нет, вам придётся каждый раз вручную включать всё в Configuration Editor.
uk.AutoApoQuestion=Бажаєте використовувати AutoAPO, щоб налаштування автоматично вмикалися під час запуску PUBG?%n%nЯкщо ні, вам доведеться щоразу вручну вмикати все в Configuration Editor.
AutoApoYes=Yes, use AutoAPO (recommended)
ru.AutoApoYes=Да, использовать AutoAPO (рекомендуется)
uk.AutoApoYes=Так, використовувати AutoAPO (рекомендовано)
AutoApoNo=No, I will turn everything on manually
ru.AutoApoNo=Нет, я буду включать всё вручную
uk.AutoApoNo=Ні, я вмикатиму все вручну
AutoApoSetupError=AutoAPO could not be set up: %1%n%nThe audio setup itself is installed. You can start AutoAPO.exe from the release folder instead.
ru.AutoApoSetupError=Не удалось настроить AutoAPO: %1%n%nСами настройки звука установлены. Вместо этого можно запустить AutoAPO.exe из папки релиза.
uk.AutoApoSetupError=Не вдалося налаштувати AutoAPO: %1%n%nСамі налаштування звуку встановлено. Натомість можна запустити AutoAPO.exe з папки релізу.
OpenEditor=Open Equalizer APO Configuration Editor
ru.OpenEditor=Открыть редактор конфигурации Equalizer APO
uk.OpenEditor=Відкрити редактор конфігурації Equalizer APO
OpenPeace=Open Peace with _pubg-config selected
ru.OpenPeace=Открыть Peace с выбранным профилем _pubg-config
uk.OpenPeace=Відкрити Peace із вибраним профілем _pubg-config

[Files]
Source: "..\payload\EqualizerAPO-x64-1.4.2.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall ignoreversion
Source: "..\payload\PeaceSetup.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall ignoreversion
Source: "..\payload\vst\FabFilter Pro-MB.dll"; DestDir: "{tmp}\vst"; Flags: deleteafterinstall ignoreversion
Source: "..\payload\vst\FabFilter Pro-C 2.dll"; DestDir: "{tmp}\vst"; Flags: deleteafterinstall ignoreversion
Source: "..\payload\vst\FabFilter Pro-C 3.dll"; DestDir: "{tmp}\vst"; Flags: deleteafterinstall ignoreversion
Source: "..\payload\vst\reacomp-standalone.dll"; DestDir: "{tmp}\vst"; Flags: deleteafterinstall ignoreversion
Source: "..\payload\config.txt"; DestDir: "{tmp}"; Flags: deleteafterinstall ignoreversion
; Kept in {tmp} (deleted when Setup exits) until the AutoAPO page decides whether to install it.
Source: "..\auto-apo-switch\build\AutoAPO.exe"; DestDir: "{tmp}"; Flags: ignoreversion
Source: "..\payload\compressor\*"; DestDir: "{tmp}\compressor"; Flags: recursesubdirs createallsubdirs deleteafterinstall ignoreversion

[Code]
const
  ProMbDll = 'FabFilter Pro-MB.dll';
  ProC3Dll = 'FabFilter Pro-C 3.dll';

var
  EqFilePage: TInputFileWizardPage;
  EqSourceFile: String;
  UsePersonalEq: Boolean;
  EapoConfigDir: String;
  AutoApoPage: TInputOptionWizardPage;

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
    SuppressibleMsgBox(FmtMessage(CustomMessage('DependencyStartError'), [ProductName]),
      mbError, MB_OK, IDOK);
    Exit;
  end;
  if ResultCode <> 0 then begin
    SuppressibleMsgBox(FmtMessage(CustomMessage('DependencyExitError'), [ProductName,
      IntToStr(ResultCode)]), mbError, MB_OK, IDOK);
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
  if CompareText(SourceFile, DestinationFile) = 0 then
    Exit;
  if not CopyFile(SourceFile, DestinationFile, False) then
    RaiseException(FmtMessage(CustomMessage('CopyError'), [ExtractFileName(SourceFile),
      DestinationFile]));
end;

procedure WriteReacompPreset(const SourceFile, DestinationFile, VstDir: String);
var
  Lines: TArrayOfString;
  I: Integer;
begin
  if not LoadStringsFromFile(SourceFile, Lines) then
    RaiseException(FmtMessage(CustomMessage('ReadError'), [SourceFile]));
  for I := 0 to GetArrayLength(Lines) - 1 do
    StringChange(Lines[I], 'C:\Program Files\VSTPlugins\ReaPlugs\reacomp-standalone.dll',
      AddBackslash(VstDir) + 'reacomp-standalone.dll');
  for I := 0 to GetArrayLength(Lines) - 1 do
    StringChange(Lines[I], 'C:\Program Files\EqualizerAPO\config\vst\reacomp-standalone.dll',
      AddBackslash(VstDir) + 'reacomp-standalone.dll');
  if not SaveStringsToFile(DestinationFile, Lines, False) then
    RaiseException(FmtMessage(CustomMessage('WriteError'), [DestinationFile]));
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
    RaiseException(FmtMessage(CustomMessage('ConfigFolderMissing'), [EapoConfigDir]));

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
  CopyRequiredFile(ExpandConstant('{tmp}\vst\') + ProMbDll, AddBackslash(VstDir) + ProMbDll);
  CopyRequiredFile(ExpandConstant('{tmp}\vst\FabFilter Pro-C 2.dll'),
    AddBackslash(VstDir) + 'FabFilter Pro-C 2.dll');
  CopyRequiredFile(ExpandConstant('{tmp}\vst\') + ProC3Dll, AddBackslash(VstDir) + ProC3Dll);
  CopyCompressorFolder(ExpandConstant('{tmp}\compressor'), CompressorDir, VstDir);

  if UsePersonalEq then begin
    if not MakePeaceConfig(EqSourceFile, AddBackslash(EapoConfigDir) + 'peace.txt') then
      RaiseException(FmtMessage(CustomMessage('WriteError'), [AddBackslash(EapoConfigDir) +
        'peace.txt']));

    PeacePreset := AddBackslash(EapoConfigDir) + '_pubg-config.peace';
    if not MakePeacePreset(EqSourceFile, PeacePreset) then
      RaiseException(FmtMessage(CustomMessage('WriteError'), [PeacePreset]));
    CopyRequiredFile(PeacePreset, AddBackslash(EapoConfigDir) + 'Last Configuration.peace');
    SetIniString('General', 'Selected Configuration', '_pubg-config',
      AddBackslash(EapoConfigDir) + 'peace.ini');
  end;

  if not WriteMainConfigFromTemplate(ExpandConstant('{tmp}\config.txt'),
    AddBackslash(EapoConfigDir) + 'config.txt', UsePersonalEq) then
    RaiseException(FmtMessage(CustomMessage('WriteError'), [AddBackslash(EapoConfigDir) +
      'config.txt']));
end;

{ AutoAPO identifies an entry by its command line without the leading '#', trimmed. }
function AutoApoKey(const Line: String): String;
begin
  Result := Trim(Line);
  if (Result <> '') and (Result[1] = '#') then
    Result := Trim(Copy(Result, 2, MaxInt));
end;

{ Returns the entries AutoAPO should switch: Pro-MB, Pro-C 2 and, with a personal EQ,
  the Peace include. Read from the config.txt that was just written, so the keys match
  its final plugin paths. }
function AutoApoRules(const ConfigFile: String): TArrayOfString;
var
  Lines: TArrayOfString;
  I, Count: Integer;
  Key: String;
begin
  Count := 0;
  SetArrayLength(Result, 0);
  if not LoadStringsFromFile(ConfigFile, Lines) then
    RaiseException(FmtMessage(CustomMessage('ReadError'), [ConfigFile]));
  for I := 0 to GetArrayLength(Lines) - 1 do begin
    Key := AutoApoKey(Lines[I]);
    if (StartsWith(Key, 'VSTPlugin:') and ((Pos(ProMbDll, Key) > 0) or
        (Pos('FabFilter Pro-C 2.dll', Key) > 0))) or
       (UsePersonalEq and (CompareText(Key, 'Include: peace.txt') = 0)) then
      AddOutputLine(Result, Count, Key);
  end;
end;

procedure SetUpAutoApo;
var
  InstallDir, Exe, SettingsDir, SettingsFile, ConfigFile: String;
  Settings, Rules: TArrayOfString;
  I, Count, ResultCode: Integer;
begin
  InstallDir := ExpandConstant('{autopf}\AutoAPO');
  Exe := AddBackslash(InstallDir) + 'AutoAPO.exe';

  { A running copy would lock the file and keep its old settings. Closing it keeps the
    current APO state, like its own Exit command. }
  Exec(ExpandConstant('{sys}\taskkill.exe'), '/F /IM AutoAPO.exe', '', SW_HIDE,
    ewWaitUntilTerminated, ResultCode);
  if ResultCode = 0 then
    Sleep(500);

  ForceDirectories(InstallDir);
  CopyRequiredFile(ExpandConstant('{tmp}\AutoAPO.exe'), Exe);

  ConfigFile := AddBackslash(GetEapoConfigDir) + 'config.txt';
  Rules := AutoApoRules(ConfigFile);
  Count := 0;
  AddOutputLine(Settings, Count, ConfigFile);
  AddOutputLine(Settings, Count, 'TslGame.exe');
  for I := 0 to GetArrayLength(Rules) - 1 do
    AddOutputLine(Settings, Count, Rules[I]);
  SettingsDir := ExpandConstant('{localappdata}\AutoAPO');
  SettingsFile := AddBackslash(SettingsDir) + 'settings.txt';
  ForceDirectories(SettingsDir);
  { AutoAPO reads its settings as UTF-8 and expects no byte-order mark. }
  if not SaveStringsToUTF8FileWithoutBOM(SettingsFile, Settings, False) then
    RaiseException(FmtMessage(CustomMessage('WriteError'), [SettingsFile]));

  { Start with Windows (same value AutoAPO's own checkbox writes) and the wizard's language. }
  RegWriteStringValue(HKCU, 'Software\Microsoft\Windows\CurrentVersion\Run', 'AutoAPO',
    '"' + Exe + '" --start-in-tray');
  RegWriteStringValue(HKCU, 'Software\AutoAPO', 'Language', ActiveLanguage);

  { Start it with the user's normal rights; AutoAPO does not need administrator mode. }
  ExecAsOriginalUser(Exe, '', InstallDir, SW_SHOWNORMAL, ewNoWait, ResultCode);
end;

procedure InitializeWizard;
begin
  EqFilePage := CreateInputFilePage(wpSelectDir,
    CustomMessage('EqTitle'), CustomMessage('EqSubtitle'), CustomMessage('EqInstructions'));
  EqFilePage.Add(CustomMessage('EqFileLabel'), CustomMessage('EqFileFilter'), '.txt');

  { Shown after the installation finishes, right before the final page. }
  AutoApoPage := CreateInputOptionPage(wpInfoAfter, CustomMessage('AutoApoCaption'),
    CustomMessage('AutoApoDescription'), CustomMessage('AutoApoQuestion'), True, False);
  AutoApoPage.Add(CustomMessage('AutoApoYes'));
  AutoApoPage.Add(CustomMessage('AutoApoNo'));
  AutoApoPage.SelectedValueIndex := 0;
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result := True;
  if CurPageID = EqFilePage.ID then begin
    EqSourceFile := Trim(EqFilePage.Values[0]);
    UsePersonalEq := EqSourceFile <> '';
    if UsePersonalEq and not FileExists(EqSourceFile) then begin
      MsgBox(CustomMessage('EqInvalidFile'), mbError, MB_OK);
      Result := False;
    end;
  end;
  if (CurPageID = AutoApoPage.ID) and (AutoApoPage.SelectedValueIndex = 0) then begin
    try
      SetUpAutoApo;
    except
      { The audio setup is already installed; report the problem and let the user finish. }
      MsgBox(FmtMessage(CustomMessage('AutoApoSetupError'), [GetExceptionMessage]),
        mbError, MB_OK);
    end;
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep <> ssPostInstall then
    Exit;

  if not IsEapoInstalled then begin
    if not RunRequiredInstaller(ExpandConstant('{tmp}\EqualizerAPO-x64-1.4.2.exe'), 'Equalizer APO') then
      Abort;
  end;

  EapoConfigDir := GetEapoConfigDir;
  if not FileExists(AddBackslash(EapoConfigDir) + 'Peace.exe') then begin
    if not RunRequiredInstaller(ExpandConstant('{tmp}\PeaceSetup.exe'), 'Peace') then
      Abort;
  end;

  DeployConfiguration;
end;

[Run]
Filename: "{code:ReadEditorExe}"; Description: "{cm:OpenEditor}"; Flags: postinstall nowait skipifsilent unchecked
Filename: "{code:ReadPeaceExe}"; Parameters: "_pubg-config"; Description: "{cm:OpenPeace}"; Flags: postinstall nowait skipifsilent unchecked; Check: ShouldOpenPeace
