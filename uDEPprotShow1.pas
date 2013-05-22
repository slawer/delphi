unit uDEPprotShow1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, upf2, uDEPprotShow1const, StdCtrls;

type
  TcDEPprotShow1 = class(Tpf2)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cDEPprotShow1: TcDEPprotShow1;

implementation

{$R *.dfm}

procedure TcDEPprotShow1.FormCreate(Sender: TObject);
begin
  inherited;
  jUniType   := pc005_108_jMain;
  Caption    := pc005_108_Caption;
end;

end.
