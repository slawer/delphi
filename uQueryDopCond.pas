unit uQueryDopCond;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, upf2, StdCtrls, CheckLst, Buttons, ExtCtrls,
  uQueryDopCondConst, uSGTlibDB1, uDEPgrafJob2;

type
  TcQueryDopCond = class(Tpf2)
    Panel1: TPanel;
    Panel8: TPanel;
    Panel14: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    Panel15: TPanel;
    CheckListBox1: TCheckListBox;
    Panel16: TPanel;
    CheckListBox2: TCheckListBox;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
    fDEPgrafJob:  TDEPgrafJob1;
//    fReisList: TSGTReisList;
    procedure clearList(chl: TCheckListBox);
    procedure setList(chl: TCheckListBox);
  public
    { Public declarations }
    procedure CreateIMG(DEPgrafJob:  TDEPgrafJob1);
    function  saveDBaseList: Integer;
  end;

var
  cQueryDopCond: TcQueryDopCond;

implementation

{$R *.dfm}

procedure TcQueryDopCond.FormCreate(Sender: TObject);
begin
  inherited;
  jUniType   := pc006_109_jMain;
  Caption    := pc006_109_Caption;
  fDEPgrafJob := nil;
//  fReisList := TSGTReisList.Create();
end;

procedure TcQueryDopCond.BitBtn3Click(Sender: TObject);
begin
  inherited;

  // ��������� ������ ��
  // ===============================
  if saveDBaseList = 0 then
  begin
    ShowMessage(pc006_109_0001);
    Exit;
  end;

  self.Close;
end;

function TcQueryDopCond.saveDBaseList: Integer;
var
  jWrk, j1, jC1: integer;
//  dt1, dt2: TDateTime;
  rc1: rcdSGTReisList;
  sGUIDwrk, s1: string;
begin
  // ��������� ������ ��
  // ===============================
  self.fDEPgrafJob.QueryList.Count := 0;
  result := 0;
  try

    // ��������� ������ �� �������
    if self.CheckBox1.Checked then
    begin
      // ������� ���������� �����
      j1 := 0;
      for jC1 := 1 to self.CheckListBox1.Items.Count do
      begin
        if Pos(pc006_109_0008, self.CheckListBox1.Items[jC1-1]) <> 1 then
        begin
          continue;
        end;
        Inc(j1);
        if self.CheckListBox1.Checked[jC1-1] then
        begin
          self.fDEPgrafJob.ReisList[j1].include := true;
          self.fDEPgrafJob.QueryList.Append(self.fDEPgrafJob.ReisList[j1]);
          self.fDEPgrafJob.ReisList[j1].include := true;
        end
        else
        begin
          self.fDEPgrafJob.ReisList[j1].include := false;
        end;
      end;
    end
    else
    begin
      // ������� ������� �������
      jWrk := self.fDEPgrafJob.WorkList.GetActiveWork();
      if jWrk > 0 then
      begin
        sGUIDwrk := self.fDEPgrafJob.WorkList[jWrk].guid;
        for jC1 := 1 to self.fDEPgrafJob.ReisList.Count do
        begin
          if self.fDEPgrafJob.ReisList[jC1].GUIDwrk = sGUIDwrk then
          begin
            self.fDEPgrafJob.QueryList.Append(self.fDEPgrafJob.ReisList[jC1]);
            self.fDEPgrafJob.QueryList[self.fDEPgrafJob.QueryList.Count].include := false;
          end;
        end;
      end;
    end;

    self.fDEPgrafJob.QueryList.Sort(3);

    // ��������� ������ �������������� ��
    if self.CheckBox2.Checked then
    begin
      rc1.numbReis := -1;
      rc1.dtCreate := 0;
      rc1.GUIDwrk := '';
      rc1.include := true;
      for jC1 := 1 to self.CheckListBox2.Items.Count do
      begin
        if self.CheckListBox2.Checked[jC1-1] then
        begin
          rc1.DBaseName := self.CheckListBox2.Items[jC1-1];
          self.fDEPgrafJob.QueryList.Append(@rc1);
        end;
      end;
    end;

    result := self.fDEPgrafJob.QueryList.Count;
  except
  end;
end;

procedure TcQueryDopCond.CreateIMG(DEPgrafJob: TDEPgrafJob1);
var
  j1, jWrk, jC1: integer;
  sGUIDwrk, sGUIDcrt, s1: string;
begin
  self.fDEPgrafJob := DEPgrafJob;

  self.CheckListBox1.Items.Clear;

  if self.CheckBox1.Checked then
  begin
    // ������������ ������ �� ��������������� ���������
    sGUIDcrt := '';
    j1 := -1;
    for jC1 := 1 to self.fDEPgrafJob.ReisList.Count do
    begin
      if sGUIDcrt <> self.fDEPgrafJob.ReisList[jC1].GUIDwrk then
      begin
        sGUIDcrt := self.fDEPgrafJob.ReisList[jC1].GUIDwrk;
        s1 := format(pc006_109_0009, [self.fDEPgrafJob.WorkList.GetDescriptFromGuid(sGUIDcrt)]);
        self.CheckListBox1.Items.Add(s1);
        Inc(j1);
      end;

      s1 := format(pc006_109_0006, [self.fDEPgrafJob.ReisList[jC1].numbReis, self.fDEPgrafJob.ReisList[jC1].DBaseName]);
      self.CheckListBox1.Items.Add(s1);
      Inc(j1);
      if self.fDEPgrafJob.ReisList[jC1].include then
      begin
        self.CheckListBox1.Checked[j1] := true;
      end
      else
      begin
        self.CheckListBox1.Checked[j1] := false;
      end;
    end;
  end
  else
  begin
    // ������������ ������ �� ���������
    jWrk := self.fDEPgrafJob.WorkList.GetActiveWork();
    if jWrk > 0 then
    begin
      sGUIDwrk := self.fDEPgrafJob.WorkList[jWrk].guid;
      j1 := -1;
      sGUIDcrt := '';
      for jC1 := 1 to self.fDEPgrafJob.ReisList.Count do
      begin
        if sGUIDcrt <> self.fDEPgrafJob.ReisList[jC1].GUIDwrk then
        begin
          sGUIDcrt := self.fDEPgrafJob.ReisList[jC1].GUIDwrk;
          s1 := format(pc006_109_0009, [self.fDEPgrafJob.WorkList.GetDescriptFromGuid(sGUIDcrt)]);
          self.CheckListBox1.Items.Add(s1);
          Inc(j1);
        end;

        s1 := format(pc006_109_0006, [self.fDEPgrafJob.ReisList[jC1].numbReis, self.fDEPgrafJob.ReisList[jC1].DBaseName]);
        self.CheckListBox1.Items.Add(s1);
        Inc(j1);
        if self.fDEPgrafJob.ReisList[jC1].GUIDwrk = sGUIDwrk then
        begin
          self.fDEPgrafJob.ReisList[jC1].include := true;
          self.CheckListBox1.Checked[j1] := true;
        end
        else
        begin
          self.fDEPgrafJob.ReisList[jC1].include := false;
          self.CheckListBox1.Checked[j1] := false;
        end;
      end;
    end;
  end;
end;

procedure TcQueryDopCond.BitBtn1Click(Sender: TObject);
begin
  inherited;
  self.setList(self.CheckListBox1);
end;

procedure TcQueryDopCond.BitBtn2Click(Sender: TObject);
begin
  inherited;
  self.clearList(self.CheckListBox1);
end;

procedure TcQueryDopCond.BitBtn10Click(Sender: TObject);
begin
  inherited;
  self.setList(self.CheckListBox2);
end;

procedure TcQueryDopCond.BitBtn11Click(Sender: TObject);
begin
  inherited;
  self.clearList(self.CheckListBox2);
end;

procedure TcQueryDopCond.BitBtn12Click(Sender: TObject);
var
  s1: string;
begin
  inherited;
  s1 := InputBox(pc006_109_0003, pc006_109_0004, pc006_109_0005);
  self.CheckListBox2.Items.Add(s1);
end;

procedure TcQueryDopCond.BitBtn13Click(Sender: TObject);
begin
  inherited;
  if self.CheckListBox2.ItemIndex >= 0 then
  begin
    self.CheckListBox2.Items.Delete(self.CheckListBox2.ItemIndex);
  end
  else
  begin
    ShowMessage(pc006_109_0002);
  end;
end;

procedure TcQueryDopCond.clearList(chl: TCheckListBox);
var
  jC1: integer;
begin
  for jC1 := 1 to chl.Count do
  begin
    chl.Checked[jC1-1] := false;
  end;
end;

procedure TcQueryDopCond.setList(chl: TCheckListBox);
var
  jC1: integer;
begin
  for jC1 := 1 to chl.Count do
  begin
    chl.Checked[jC1-1] := true;
  end;
end;

procedure TcQueryDopCond.BitBtn4Click(Sender: TObject);
begin
  inherited;
  self.Close();
end;

end.
