unit uBoardSize;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TOKBottomDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    LEditWidth: TLabeledEdit;
    LEditHeight: TLabeledEdit;
    LEditMinesCount: TLabeledEdit;
    procedure CancelBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OKBottomDlg: TOKBottomDlg;

implementation

{$R *.dfm}

{function GetValues: array of Integer;
var
  ValuesArray: array of Integer;
begin

end;   }


procedure TOKBottomDlg.CancelBtnClick(Sender: TObject);
begin
  Close;
end;

end.
