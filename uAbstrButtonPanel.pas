unit uAbstrButtonPanel;

interface
uses
  Windows, uAbstrArray, SysUtils, Math, Classes, Dialogs, ExtCtrls, Buttons,
  Controls, uMsgDial;

type

  prqTButtonPanel = class
  private
    hPrnt: HWND;
  public
    Panel: TPanel;
    BitBtn: TBitBtn;

    id: Integer; // Ключ - идентификатор

// Установить размер и положение панели
    procedure setSizePanel(Top, Left, Width, Height: Integer; Align: TAlign);

// Размещение кнопки внутри панели
    procedure allocButton(shTop, shLeft, shBottom, shRight: Integer);


    procedure BitBtnClick(Sender: TObject);

    constructor Create(AOwner: HWND; idVal: Integer); overload;
    constructor Create(AOwner: HWND; idVal: Integer;
                       Top, Left, Width, Height: Integer; Align: TAlign;
                       Shift: Integer); overload;
    destructor Destroy; override;
  end;



implementation

{ prqTButtonPanel }

constructor prqTButtonPanel.Create(AOwner: HWND; idVal: Integer);
begin
  Panel         := TPanel.Create(nil);
  BitBtn        := TBitBtn.Create(nil);
  id := idVal;
  hPrnt := AOwner;
  BitBtn.OnClick := BitBtnClick;
end;

constructor prqTButtonPanel.Create(AOwner: HWND; idVal: Integer;
  Top, Left, Width, Height: Integer; Align: TAlign; Shift: Integer);
begin
  Create(AOwner, idVal);
  setSizePanel(Top, Left, Width, Height, Align);
  allocButton(Shift, Shift, Shift, Shift);
end;

destructor prqTButtonPanel.Destroy;
begin
  BitBtn.Free;
  Panel.Free;
  inherited;
end;

procedure prqTButtonPanel.setSizePanel(Top, Left, Width, Height: Integer;
  Align: TAlign);
begin
  Panel.Width  := Width;
  Panel.Height := Height;
  Panel.Align  := Align;
  if Align = alNone then
  begin
    Panel.Top  := Top;
    Panel.Left := Left;
  end;
end;

procedure prqTButtonPanel.allocButton(shTop, shLeft, shBottom,
  shRight: Integer);
begin
  BitBtn.Top := shTop;
  BitBtn.Left := shLeft;
  BitBtn.Width := Panel.{Client}Width - shLeft - shRight;
  BitBtn.Height := Panel.{Client}Height - shTop - shBottom;
end;

procedure prqTButtonPanel.BitBtnClick(Sender: TObject);
begin
  PostMessage(hPrnt, WM_User_Dialog, 101, id);
end;

end.
