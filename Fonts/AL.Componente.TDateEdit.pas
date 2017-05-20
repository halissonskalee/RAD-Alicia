unit AL.Componente.TDateEdit;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.DateTimeCtrls,
  FMX.StdCtrls, AL.Componente.TLabel;

type
  TALDateEdit = class(TDateEdit)
  private
    FALlabel: TALlabel;
    function GetALTextLabel: String;
    procedure SetALTextLabel(const Value: String);
  protected
  public
    procedure AfterConstruction; override;
  published
    property ALTextLabel: String read GetALTextLabel write SetALTextLabel;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('AL', [TALDateEdit]);
end;

{ TALDateEdit }

procedure TALDateEdit.AfterConstruction;
begin
  inherited;
  DisableFocusEffect := True;
  FALlabel := TALlabel.Create(nil);
  FALlabel.Text := 'label';
  FALlabel.Name := 'lb' + Name;
  FALlabel.Position.X := 0;
  FALlabel.Position.Y := -17;
  FALlabel.AutoSize := True;
  FALlabel.Stored := False;
  FALlabel.Lock;
  FALlabel.Parent := Self;
end;

function TALDateEdit.GetALTextLabel: String;
begin
  if Assigned(FALlabel) then
    Result := FALlabel.Text;
end;

procedure TALDateEdit.SetALTextLabel(const Value: String);
begin
  if Assigned(FALlabel) then
    FALlabel.Text := Value;
end;

end.
