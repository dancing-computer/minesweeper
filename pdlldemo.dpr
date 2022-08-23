program pdlldemo;

{%ToDo 'pdlldemo.todo'}

uses
  Forms,
  dlldemo in 'dlldemo.pas' {MainForm},
  uImages in 'uImages.pas',
  uMinerClasses in 'uMinerClasses.pas',
  uAbout in 'uAbout.pas' {AboutBox},
  uSettings in 'uSettings.pas' {SettingsForm},
  uBoardSize in 'uBoardSize.pas' {OKBottomDlg};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'MineSweeper';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TSettingsForm, SettingsForm);
  Application.CreateForm(TOKBottomDlg, OKBottomDlg);
  Application.Run;
end.
