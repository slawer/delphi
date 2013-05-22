unit uShowDEPparam2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uShowDEPparam1, StdCtrls, Buttons, Grids, ExtCtrls;

type
  TcShowDEPparam2 = class(TcShowDEPparam1)
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    selectDEP: Integer;
  end;

implementation

{$R *.dfm}

procedure TcShowDEPparam2.FormCreate(Sender: TObject);
begin
  inherited;

  selectDEP := -1;
end;

procedure TcShowDEPparam2.BitBtn2Click(Sender: TObject);
begin
  inherited;
  try
    selectDEP := StrToInt(self.StringGrid1.Cells[0, self.StringGrid1.Selection.Top]);
  except
    selectDEP := -1;
  end;
  Close;
end;

end.
