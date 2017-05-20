unit AL.Componente.TEdit;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls,
  FMX.Controls.Presentation, FMX.Edit, System.UITypes,
  System.Variants, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.StdCtrls, AL.Componente.TLabel, AL.Tipo, FMX.Text;

type
  TALEdit = class(TEdit)
  private
    FALlabel: TALlabel;
    FALTipo: TALTipo;
    FALOnValidate: TValidateTextEvent;
    FALOnValidating: TValidateTextEvent;
    procedure SetALTextLabel(const Value: String);
    function GetALTextLabel: String;
    procedure SetALTipo(const Value: TALTipo);
    procedure SetALOnValidate(const Value: TValidateTextEvent);
    procedure SetALOnValidating(const Value: TValidateTextEvent);
  protected
    procedure SetName(const NewName: TComponentName); override;
    procedure InternalValidate(Sender: TObject; var Text: string);
    procedure InternalValidating(Sender: TObject;  var Text: string);



  public
    procedure AfterConstruction; override;

  published
    property ALTextLabel: String read GetALTextLabel write SetALTextLabel;
    property ALTipo: TALTipo read FALTipo write SetALTipo;
    property ALOnValidating: TValidateTextEvent  read FALOnValidating write SetALOnValidating;
    property ALOnValidate: TValidateTextEvent  read FALOnValidate write SetALOnValidate;
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

  OnValidate   := InternalValidate;
  OnValidating := InternalValidating;


  CharCase := TEditCharCase.ecUpperCase;

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


function TALEdit.GetALTextLabel: String;
begin
  if Assigned(FALlabel) then
    Result := FALlabel.Text;
end;

procedure TALEdit.InternalValidate(Sender: TObject; var Text: string);
begin
  if Assigned(FALOnValidate) then
    FALOnValidate(Sender,Text);
end;

procedure TALEdit.InternalValidating(Sender: TObject; var Text: string);
begin
  if Assigned(FALOnValidating) then
    FALOnValidating(Sender,Text);
end;

procedure TALEdit.SetALOnValidate(const Value: TValidateTextEvent);
begin
  FALOnValidate := Value;
end;

procedure TALEdit.SetALOnValidating(const Value: TValidateTextEvent);
begin
  FALOnValidating := Value;
end;

procedure TALEdit.SetALTextLabel(const Value: String);
begin
  if Assigned(FALlabel) then
  begin
    FALlabel.AutoSize := False;
    FALlabel.Text := Value;
    FALlabel.AutoSize := True;
  end;
end;

procedure TALEdit.SetALTipo(const Value: TALTipo);
begin
  FALTipo := Value;

  if (FALTipo = Pessoa) then
  begin
    FilterChar := '0123456789';
  end;

end;

procedure TALEdit.SetName(const NewName: TComponentName);
begin
  inherited;
  if Assigned(FALlabel) then
    FALlabel.Name := Name + 'lbl';
end;

end.
