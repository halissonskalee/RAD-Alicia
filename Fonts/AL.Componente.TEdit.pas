unit AL.Componente.TEdit;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls,
  FMX.Controls.Presentation, FMX.Edit, System.UITypes,
  System.Variants, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.StdCtrls, AL.Componente.TLabel;

type
  TALEdit = class(TEdit)
    private
      FALlabel: TALlabel;
      procedure SetALTextLabel(const Value: String);
      function GetALTextLabel: String;
    protected
      procedure SetName(const NewName: TComponentName); override;

    public
      procedure AfterConstruction; override;

    published
      property ALTextLabel: String read GetALTextLabel write SetALTextLabel;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('AL', [TALEdit]);
end;

{ TALEdit }

procedure TALEdit.AfterConstruction;
begin
  inherited;
  FALlabel            := TALlabel.Create(nil);
  FALlabel.Text       := 'label';
  FALlabel.Name       := 'lb' + Name;
  FALlabel.Position.X := 0;
  FALlabel.Position.Y := -17;
  FALlabel.AutoSize   := True;
  FALlabel.Stored     := False;
  FALlabel.Lock;
  FALlabel.Parent := Self;
end;

function TALEdit.GetALTextLabel: String;
begin
  if Assigned(FALlabel) then
    Result := FALlabel.Text;
end;

procedure TALEdit.SetALTextLabel(const Value: String);
begin
  if Assigned(FALlabel) then
  begin
    FALlabel.AutoSize := False;
    FALlabel.Text     := Value;
    FALlabel.AutoSize := True;
  end;
end;

procedure TALEdit.SetName(const NewName: TComponentName);
begin
  inherited;
  if Assigned(FALlabel) then
    FALlabel.Name := Name + 'lbl';
end;

end.
