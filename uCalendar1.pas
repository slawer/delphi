unit uCalendar1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TcCalendar1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    MonthCalendar1: TMonthCalendar;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Edit1: TEdit;
    Label1: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure MonthCalendar1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    bFinish: Boolean;
  end;

var
  cCalendar1: TcCalendar1;

implementation

{$R *.dfm}

procedure TcCalendar1.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TcCalendar1.FormCreate(Sender: TObject);
begin
  bFinish := false;
end;

procedure TcCalendar1.BitBtn1Click(Sender: TObject);
begin
  bFinish := true;
  Close;
end;

procedure TcCalendar1.BitBtn3Click(Sender: TObject);
begin
  self.MonthCalendar1.Date := Date;
  self.Edit1.Text := DateToStr(self.MonthCalendar1.Date);
end;

procedure TcCalendar1.FormActivate(Sender: TObject);
begin
  self.Edit1.Text := DateToStr(self.MonthCalendar1.Date);
end;

procedure TcCalendar1.MonthCalendar1Click(Sender: TObject);
begin
  self.Edit1.Text := DateToStr(self.MonthCalendar1.Date);
end;

end.
