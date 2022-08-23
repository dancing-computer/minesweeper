unit uMinerClasses;

{$RANGECHECKS OFF}

interface

uses Windows, Graphics, Classes, Controls, ExtCtrls;

type

	TCellKind = ( ckEmpty, ckBomb );
	TCellValue = ( cvEmpty, cvHint, cvBomb, cvExplosion, cvMistake, cvButton, cvFlag, cvDoubt );

	PMinerKinds = ^TMinerKinds;
	TMinerKinds = array[0..0] of TCellKind;

	PMinerValues = ^TMinerValues;
	TMinerValues = array[0..0] of TCellValue;

	PMinerHints = ^TMinerHints;
	TMinerHints = array[0..0] of Byte;

	TMinerBoard = class( TPanel )
	private
		FRows: Byte;
		FColumns: Byte;
		FFinished: Boolean;
		FWinner: Boolean;
		FOnFinish: TNotifyEvent;

		Bitmap: TBitmap;
		MinerKinds: PMinerKinds;
		MinerHints: PMinerHints;
		MinerValues: PMinerValues;

		IsLeftDown: Boolean;
		IsRightDown: Boolean;

		MouseDownIndex: Integer;
		PaintMouseDown: Boolean;

	protected
		procedure MouseDown( Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer ); override;
		procedure MouseMove( Shift: TShiftState; X, Y: Integer ); override;
		procedure MouseUp( Button: TMouseButton; Shift: TShiftState;
			X, Y: Integer ); override;

		procedure Paint; override;

		procedure ClearBoard;
		procedure UpdateHints;
		function CheckWinner: Boolean;

		procedure ClickCell( Index: Integer );
		procedure RightClickCell( Index: Integer );
		procedure InvalidateCell( Index: Integer );

		function XYToRect( X, Y: Integer ): TRect;
		function XYToIndex( X, Y: Integer ): Integer;
		function IndexToRect( Index: Integer ): TRect;
		procedure IndexToRC( Index: Integer; var Row, Col: Integer );
		function Neighbors( Index1, Index2: Integer ): Boolean;

		property Columns: Byte
						 read FColumns default 8;
		property Rows: Byte
						 read FRows default 8;

	public
		destructor Destroy; override;
		constructor Create( AOwner: TComponent ); override;

		procedure Finish;
		procedure InitBoard( ARows, AColumns: Byte; AMines: Word );

		property Finished: Boolean
						 read FFinished;
		property Winner: Boolean
						 read FWinner;
		property OnFinish: TNotifyEvent
						 read FOnFinish write FOnFinish;

	end;

implementation

uses uImages, Forms, SysUtils;

constructor TMinerBoard.Create( AOwner: TComponent );
begin
	inherited Create( AOwner );
	BorderWidth := 0;
	BorderStyle := bsNone;
	BevelInner := bvNone;
	BevelOuter := bvNone;
	MinerKinds := nil;
	MinerHints := nil;
	MinerValues := nil;
	IsLeftDown := false;
	IsRightDown := false;
	MouseDownIndex := -1;
	PaintMouseDown := false;
	Bitmap := TBitmap.Create;
end;

destructor TMinerBoard.Destroy;
begin
	ClearBoard;
	Bitmap.Free;
	inherited Destroy;
end;

procedure TMinerBoard.InitBoard( ARows, AColumns: Byte; AMines: Word );
var
	i,
	ix: Integer;
begin
	Invalidate;
	FWinner := false;
	FFinished := false;
	if ( ARows < 8 ) then
		raise Exception.Create( 'select at least 8 lines!' );
	if ( AColumns < 8 ) then
		raise Exception.Create( 'select at least 8 columns!' );
	if ( AMines < 8 ) then
		raise Exception.Create( 'too few mines!' );
	if ( AMines > ( ( ARows * AColumns ) div 6 ) ) then
		raise Exception.Create( 'too many mines!' );

{ clean last board }
	if ( MinerKinds <> nil ) or ( MinerValues <> nil ) or ( MinerHints <> nil ) then
		ClearBoard;

{ memory allocation for board }
	FRows := ARows;
	FColumns := AColumns;
	GetMem( MinerKinds, FRows * FColumns * SizeOf( TCellKind ) );
	GetMem( MinerHints, FRows * FColumns * SizeOf( Byte ) );
	GetMem( MinerValues, FRows * FColumns * SizeOf( TCellValue ) );

{ mine distribution }
	for i := 0 to FRows * FColumns - 1 do
		MinerKinds^[i] := ckEmpty;
	Randomize;
	for i := 1 to AMines do
	begin
		ix := Trunc( Random( FRows * FColumns ) );
		while ( MinerKinds^[ix] = ckBomb ) do
			ix := Trunc( Random( FRows * FColumns ) );
		MinerKinds^[ix] := ckBomb;
	end;

{ distribute hints }
	for i := 0 to FRows * FColumns - 1 do
		MinerHints^[i] := 0;
	UpdateHints;

{ define initial board display }
	Height := Rows * 15 + ( Rows - 1 );
	Width := Columns * 15 + ( Columns - 1 );
	for i := 0 to FRows * FColumns - 1 do
		MinerValues^[i] := cvButton;

{ start game }
	FFinished := false;
end;

procedure TMinerBoard.ClearBoard;
begin
	FreeMem( MinerKinds, FRows * FColumns * SizeOf( TCellKind ) );
	FreeMem( MinerHints, FRows * FColumns * SizeOf( Byte ) );
	FreeMem( MinerValues, FRows * FColumns * SizeOf( TCellValue ) );
	MinerKinds := nil;
	MinerValues := nil;
end;

function TMinerBoard.CheckWinner: Boolean;
var
	i: Integer;
begin
  CheckWinner := true;
	for i := 0 to FRows * FColumns - 1 do
		if ( ( MinerValues^[i] in [cvButton, cvFlag, cvDoubt] ) and
			 ( MinerKinds^[i] <> ckBomb ) ) then
			CheckWinner := false
		else if ( MinerValues^[i] = cvExplosion ) then
			CheckWinner := false;
end;

procedure TMinerBoard.Finish;
var
	i: Integer;
begin
	FWinner := CheckWinner;
	FFinished := true;
{ show all cells }
	for i := 0 to FRows * FColumns - 1 do
		if ( MinerKinds^[i] = ckEmpty ) then
		begin
			if ( MinerHints^[i] > 0 ) then
				MinerValues^[i] := cvHint
			else
				MinerValues^[i] := cvEmpty;
		end
		else if ( MinerValues^[i] <> cvExplosion ) and ( not FWinner ) then
			MinerValues^[i] := cvBomb;
	Invalidate;
	if Assigned( FOnFinish ) then
		FOnFinish( Self );
end;

function TMinerBoard.Neighbors( Index1, Index2: Integer ): Boolean;
{ determine if cells at these indexes are neighbor cells }
var
	r1, c1, r2, c2: Integer;
begin
	IndexToRC( Index1, r1, c1 );
	IndexToRC( Index2, r2, c2 );
	Result := ( Abs( r1 - r2 ) <= 1 ) and ( Abs( c1 - c2 ) <= 1 );
end;

procedure TMinerBoard.UpdateHints;
{ determine hint values for all cells }
var
	i,
	j: Integer;
begin
	for i := 0 to FRows * FColumns - 1 do
		if ( MinerKinds^[i] = ckBomb ) then
			for j := 0 to FRows * FColumns - 1 do
				if ( i <> j ) and ( MinerKinds^[j] <> ckBomb ) and Neighbors( i, j ) then
					MinerHints^[j] := MinerHints^[j] + 1;
end;

procedure TMinerBoard.ClickCell( Index: Integer );
{ determines click behaviour }
var
	i: Integer;
begin
{ cell not supposed to have been clicked- ignore! }
	if ( not ( MinerValues^[Index] in [cvButton, cvDoubt] ) ) then
	begin
		InvalidateCell( Index );
		Exit;
	end;
{ oops! blew it all! }
	if ( MinerKinds^[Index] = ckBomb ) then
	begin
		MinerValues^[Index] := cvExplosion;
		Finish;
		Exit;
	end
{ uncovered a hint cell }
	else if ( MinerHints^[Index] > 0 ) then
		MinerValues^[Index] := cvHint
	else
{ uncovere an empty cell }
	begin
		MinerValues^[Index] := cvEmpty;
{ domino effect }
		for i := 0 to FRows * FColumns - 1 do
			if ( Index <> i ) and ( MinerKinds^[i] = ckEmpty ) and Neighbors( Index, i ) and ( MinerValues^[i] in [cvButton, cvDoubt] ) then
				ClickCell( i );
	end;
{ check if this click ends the game }
	if CheckWinner then
		Finish;
	InvalidateCell( Index );
end;

procedure TMinerBoard.RightClickCell( Index: Integer );
begin
	if ( MinerValues^[Index] = cvButton ) then
		MinerValues^[Index] := cvFlag
	else if ( MinerValues^[Index] = cvFlag ) then
		MinerValues^[Index] := cvDoubt
	else if ( MinerValues^[Index] = cvDoubt ) then
		MinerValues^[Index] := cvButton;
	InvalidateCell( Index );
end;

function TMinerBoard.XYToRect( X, Y: Integer ): TRect;
begin
	Result := IndexToRect( XYToIndex( X, Y ) );
end;

function TMinerBoard.XYToIndex( X, Y: Integer ): Integer;
begin
	if ( ( Y + 1 ) mod 16 = 0 ) or ( ( X + 1 ) mod 16 = 0 ) then
		Result := -1
	else
		Result := ( Y div 16 ) * FColumns + ( X div 16 );
end;

function TMinerBoard.IndexToRect( Index: Integer ): TRect;
begin
	Result := Rect( ( Index mod FRows ) * 16, ( Index div FColumns ) * 16,
		( Index mod FRows + 1 ) * 16 - 2, ( Index div FColumns + 1 ) * 16 - 2 );
end;

procedure TMinerBoard.IndexToRC( Index: Integer; var Row, Col: Integer );
begin
	Row := ( Index div FColumns );
	Col := ( Index mod FColumns );
end;

procedure TMinerBoard.InvalidateCell( Index: Integer );
var
	r: TRect;
begin
	r := IndexToRect( Index );
	r.Right := r.Right + 2;
	r.Bottom := r.Bottom + 2;
	InvalidateRect( Handle, @r, true );
end;

procedure TMinerBoard.Paint;
const
	HINT_COLORS: array[1..8] of TColor =
	(
		clBlue,
		clGreen,
		clRed,
		clNavy,
		clMaroon,
		clTeal,
		clPurple,
		clFuchsia
	);

	procedure DrawBitmap( r: TRect; bmp: TBitmap );
	begin
		Canvas.Draw( r.Left + ( ( r.Right - r.Left - Bitmap.Width ) div 2 ),
			r.Top + ( ( r.Bottom - r.Top - Bitmap.Height ) div 2 ), bmp );
	end;

	procedure Gridlines;
	var
		i: Integer;
	begin
		for i := 1 to FColumns - 1 do
		begin
			Canvas.Pen.Color := clGray;
			Canvas.Pen.Style := psSolid;
			Canvas.MoveTo( 16 * i - 1, 0 );
			Canvas.LineTo( 16 * i - 1, ClientHeight );
		end;
		for i := 1 to FRows - 1 do
		begin
			Canvas.Pen.Color := clGray;
			Canvas.Pen.Style := psSolid;
			Canvas.MoveTo( 0, 16 * i - 1 );
			Canvas.LineTo( ClientWidth, 16 * i - 1 );
		end;
	end;

var
	r: TRect;
	i,
	iw,
	ih: Integer;
begin
	inherited Paint;
	Gridlines;
	for i := 0 to FRows * FColumns - 1 do
	begin
		r := IndexToRect( i );
		r.Right := r.Right + 2;
		r.Bottom := r.Bottom + 2;
		if ( PaintMouseDown and ( i = MouseDownIndex ) ) then
		begin
			Canvas.FillRect( r );
			if ( MinerValues^[i] = cvDoubt ) then
			begin
				uImages.LoadBitmap( Bitmap, bkQuestion );
				r.Left := r.Left + 2;
				r.Top := r.Top + 2;
				DrawBitmap( r, Bitmap );
			end;
		end
		else
			case MinerValues^[i] of
				cvHint:
				begin
					Canvas.Font.Name := 'MS Sans Serif';
					Canvas.Font.Style := [fsBold];
					Canvas.Font.Color := HINT_COLORS[MinerHints^[i]];
					iw := Canvas.TextWidth( IntToStr( MinerHints^[i] ) );
					ih := Canvas.TextHeight( IntToStr( MinerHints^[i] ) );
					Canvas.TextOut( r.Left + ( ( r.Right - r.Left - iw ) div 2 ), r.Top +
					  ( ( r.Bottom - r.Top - ih ) div 2 ), IntToStr( MinerHints^[i] ) );
				end;
				cvBomb:
				begin
					uImages.LoadBitmap( Bitmap, bkBomb01 );
					DrawBitmap( r, Bitmap );
				end;
				cvExplosion:
				begin
					uImages.LoadBitmap( Bitmap, bkBomb02 );
					Bitmap.TransparentColor := clGray;
					DrawBitmap( r, Bitmap );
				end;
				cvMistake:
				begin
					uImages.LoadBitmap( Bitmap, bkMistake );
					DrawBitmap( r, Bitmap );
				end;
				cvButton:
				begin
					DrawFrameControl( Canvas.Handle, r, DFC_BUTTON, DFCS_BUTTONPUSH or 0 );
				end;
				cvFlag:
				begin
					DrawFrameControl( Canvas.Handle, r, DFC_BUTTON, DFCS_BUTTONPUSH or 0 );
					uImages.LoadBitmap( Bitmap, bkFlag );
					DrawBitmap( r, Bitmap );
				end;
				cvDoubt:
				begin
					DrawFrameControl( Canvas.Handle, r, DFC_BUTTON, DFCS_BUTTONPUSH or 0 );
					uImages.LoadBitmap( Bitmap, bkQuestion );
					DrawBitmap( r, Bitmap );
				end;
			end;
	end;
end;

procedure TMinerBoard.MouseDown( Button: TMouseButton; Shift: TShiftState;
	X, Y: Integer );
begin
	if Finished then
	begin
		inherited MouseDown( Button, Shift, X, Y );
		Exit;
	end;
	MouseDownIndex := XYToIndex( X, Y );
	if ( Button = mbLeft ) then
	begin
		if ( MinerValues^[MouseDownIndex] = cvFlag ) then
		begin
			inherited MouseDown( Button, Shift, X, Y );
			Exit;
		end;
		IsLeftDown := true;
		PaintMouseDown := true;
		InvalidateCell( MouseDownIndex );
	end
	else
		IsRightDown := true;
	inherited MouseDown( Button, Shift, X, Y );
end;

procedure TMinerBoard.MouseMove( Shift: TShiftState; X, Y: Integer );
var
	b: Boolean;
begin
	if Finished then
	begin
		inherited MouseMove( Shift, X, Y );
		Exit;
	end;
	b := PaintMouseDown;
	PaintMouseDown := IsLeftDown and
		( MouseDownIndex = XYToIndex( X, Y ) );
	if ( b <> PaintMouseDown ) then
		InvalidateCell( MouseDownIndex );
	inherited MouseMove( Shift, X, Y );
end;

procedure TMinerBoard.MouseUp( Button: TMouseButton; Shift: TShiftState;
	X, Y: Integer );
var
	i: Integer;
begin
	if Finished or ( not ( IsLeftDown or IsRightDown ) ) then
	begin
		inherited MouseUp( Button, Shift, X, Y );
		Exit;
	end;
	i := MouseDownIndex;
	MouseDownIndex := -1;
	if ( XYToIndex( X, Y ) = i ) then
	begin
		if IsLeftDown then
			ClickCell( i )
		else
			RightClickCell( i );
	end;
	IsLeftDown := false;
	IsRightDown := false;
	inherited MouseUp( Button, Shift, X, Y );
end;

end.
