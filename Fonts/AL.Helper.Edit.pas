unit AL.Helper.Edit;

interface

uses FMX.Edit;

type
  THelperEdit = class helper for TEdit
  private

    procedure SetAsInteger(const Value: integer);
    function GetInteger: integer;
    function GetLeitura: Boolean;
    procedure SetLeitura(const Value: Boolean);

  public
  procedure Clear;
  property AsInteger : integer read GetInteger write SetAsInteger;
  property Leitura   : Boolean read GetLeitura write SetLeitura;


end;


implementation

uses
  System.SysUtils;

{ THelperEdit }

procedure THelperEdit.Clear;
begin
  Self.Text := '';
end;

function THelperEdit.GetInteger: integer;
begin
  Result := StrToIntDef(Self.Text,0)
end;

function THelperEdit.GetLeitura: Boolean;
begin
  Result := (ReadOnly= True) and (Enabled = False)
end;

procedure THelperEdit.SetAsInteger(const Value: integer);
begin
  Self.Text := Value.ToString;
end;

procedure THelperEdit.SetLeitura(const Value: Boolean);
begin
  if Value then
  begin
    Self.Enabled  := False;
    Self.ReadOnly := True;
  end
  else
  begin
    Self.Enabled  := True;
    Self.ReadOnly := False;
  end;
end;

end.
