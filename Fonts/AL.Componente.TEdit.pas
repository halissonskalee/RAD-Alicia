unit AL.Componente.TEdit;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls,
  FMX.Controls.Presentation, FMX.Edit, System.UITypes,
  System.Variants, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.StdCtrls, AL.Componente.TLabel, AL.Tipo, FMX.Text,
  FMX.Objects;

type
  TALEdit = class(TEdit)
  private
    FALlabel: TALlabel;
    FALPath : TPath;

    FALTipo: TALTipo;
    FALOnValidate: TValidateTextEvent;
    FALOnValidating: TValidateTextEvent;
    FALValido: Boolean;
    procedure SetALTextLabel(const Value: String);
    function GetALTextLabel: String;
    procedure SetALTipo(const Value: TALTipo);
    procedure SetALOnValidate(const Value: TValidateTextEvent);
    procedure SetALOnValidating(const Value: TValidateTextEvent);
    procedure SetALValido(const Value: Boolean);
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
    property ALValido :Boolean read FALValido write SetALValido;
  end;

procedure Register;

implementation

uses AL.Rotinas ;

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
  ALValido     := True;


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

  if ALTipo = Pessoa then
  begin
    ALValido := ValidarCpf(Text);
  end;


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

procedure TALEdit.SetALValido(const Value: Boolean);
begin
  FALValido := Value;

  if not Value then
  begin
    if not Assigned(FALPath) then
      FALPath := TPath.Create(nil);
    FALPath.Name := Name + 'path';
    FALPath.Data.Data  := 'M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-6h2v6zm0-8h-2V7h2v2z';
    FALPAth.Fill.Color :=  TAlphaColorRec.Red;
    FALPAth.Fill.Kind  :=  TBrushKind.Solid;
    FALPAth.Stroke.Color := TAlphaColorRec.White;
    FALPAth.Stroke.Kind  := TBrushKind.Solid;
    FALPath.Position.X := Width;
    FALPath.Position.Y := 0;
    FALPath.Height     := 22;
    FALPath.Width      := 22;
    FALPath.Stored     := False;
    FALPath.Parent     := Self;
    FALPath.Locked     := True;
  end
  else
    if Assigned(FALPath) then
      FALPath.Destroy
end;

procedure TALEdit.SetName(const NewName: TComponentName);
begin
  inherited;
  if Assigned(FALlabel) then
    FALlabel.Name := Name + 'lbl';
end;

end.
