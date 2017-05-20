unit AL.Componente.TComboBox;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.ListBox,
  AL.Componente.TLabel;

type
  TALComboBox = class(TComboBox)
  private
    FALlabel: TALlabel;
    function GetALTextLabel: String;
    procedure SetALTextLabel(const Value: String);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure AfterConstruction; override;
  published
    property ALTextLabel: String read GetALTextLabel write SetALTextLabel;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('AL', [TALComboBox]);
end;

{ TALComboBox }

procedure TALComboBox.AfterConstruction;
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

function TALComboBox.GetALTextLabel: String;
begin
  if Assigned(FALlabel) then
    Result := FALlabel.Text;
end;

procedure TALComboBox.SetALTextLabel(const Value: String);
begin
  if Assigned(FALlabel) then
    FALlabel.Text := Value;
end;

end.
