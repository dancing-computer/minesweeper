unit uImports;

interface

uses Windows, Graphics;

type
	TBitmapKind = ( bkSmiley01, bkSmiley02, bkSmiley03, bkSmiley04, bkBomb01, bkBomb02,
	  bkFlag, bkQuestion, bkMistake );

procedure LoadBitmap( Bitmap: TBitmap; Kind: TBitmapKind );

var
	HImageLib: THandle;

implementation

const
	SImageLib = 'imagelib.dll';

const
	BitmapNames: array[TBitmapKind] of ShortString =
	(
		'SMILEY01',  // 21x21
		'SMILEY02',  // 21x21
		'SMILEY03',  // 21x21
		'SMILEY04',  // 21x21
		'BOMB01',    // 15x15
		'BOMB02',    // 15x15
		'FLAG',      // 12x12
		'QUESTION',  // 12x12
		'MISTAKE'    // 15x15
	);

procedure LoadBitmap( Bitmap: TBitmap; Kind: TBitmapKind );
begin
	if ( Bitmap = nil ) then
		Exit;
	Bitmap.LoadFromResourceName( HImageLib, BitmapNames[Kind] );
end;

initialization
	HImageLib := LoadLibrary( SImageLib );

finalization
	FreeLibrary( HImageLib );

end.
