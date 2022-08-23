unit dlldemo;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, StdCtrls, Menus, uAbout, uSettings;

type
  TMainForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    MainMenu1: TMainMenu;
    H1: TMenuItem;
    G1: TMenuItem;
    N1: TMenuItem;
    S1: TMenuItem;
    N2: TMenuItem;
    E1: TMenuItem;
    A1: TMenuItem;
    TopPanel: TPanel;
    SpeedButton1: TSpeedButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    BottomPanel: TPanel;
    WinnerImage: TImage;
    LoserImage: TImage;
    Timer: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FinishGame(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure S1Click(Sender: TObject);
    procedure E1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure LoserImageClick(Sender: TObject);
	private
		{ Private declarations }
	public
		{ Public declarations }
	end;


var
	MainForm: TMainForm;

implementation

uses uImages, uMinerClasses, uBoardSize;

{$R *.DFM}

var
  mn: TMinerBoard;
  setfile: TextFile;

procedure StartGame(Row, Column, Mines: Byte);
begin
  mn.InitBoard( 9, 9, 10 );
  MainForm.WinnerImage.Hide;
  MainForm.LoserImage.Hide;
  MainForm.Timer.Enabled:= True;
  MainForm.Label2.Caption:= '0';
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
	StartGame( 9, 9, 10 );
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
	if not mn.Finished then
		mn.Finish;
end;

procedure TMainForm.FinishGame(Sender: TObject);
begin
	if TMinerBoard( Sender ).Winner then
		//ShowMessage( 'winner!!!' )
    WinnerImage.Show   { Do something when game wins }
	else
		//ShowMessage( 'you suck!!!' );
    LoserImage.Show;    { Loses here }
  Timer.Enabled:= false;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
	mn := TMinerBoard.Create( Self );
	with mn do
	begin
		OnFinish := FinishGame;
		Parent := Self;
		Left := 12;
		Top := 60;
    Width := 0;
    Height := 0;
	end;


  TopPanel.Caption:= '';
  BottomPanel.Caption:= '';
  Bevel1.Left:= 8; Label1.Left:= 8;
  Bevel2.Left:= TopPanel.Width - 8 - Bevel2.Width;
  Label2.Left:= TopPanel.Width - 8 - Bevel2.Width;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
	mn.Free;
end;

procedure TMainForm.A1Click(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TMainForm.N1Click(Sender: TObject);
begin
  StartGame( 9, 9, 10 );
end;

procedure TMainForm.S1Click(Sender: TObject);
begin
  OKBottomDlg.Show;
end;

procedure TMainForm.E1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
  StartGame( 9, 9, 10 );
end;


procedure TMainForm.TimerTimer(Sender: TObject);
begin
  Label2.Caption:= IntToStr(StrToInt(Label2.Caption) + 1)
end;

procedure TMainForm.LoserImageClick(Sender: TObject);
begin
  StartGame( 9, 9, 10 );
end;

end.
