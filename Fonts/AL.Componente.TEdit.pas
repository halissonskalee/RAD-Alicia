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
    ALMenssagem : TStringList;
    FALlabel: TALlabel;
    FALPath : TPath;

    FALTipo: TALTipo;
    FALOnValidate: TValidateTextEvent;
    FALOnValidating: TValidateTextEvent;
    FALValido: Boolean;
    FALObrigatorio: Boolean;

    procedure SetALTextLabel(const Value: String);
    function GetALTextLabel: String;
    procedure SetALTipo(const Value: TALTipo);
    procedure SetALOnValidate(const Value: TValidateTextEvent);
    procedure SetALOnValidating(const Value: TValidateTextEvent);
    procedure SetALValido(const Value: Boolean);
    procedure SetALObrigatorio(const Value: Boolean);

  protected
    procedure SetName(const NewName: TComponentName); override;
    procedure InternalValidate(Sender: TObject; var Text: string);
    procedure InternalValidating(Sender: TObject;  var Text: string);
    procedure Path1Click(Sender: TObject);



  public
    procedure AfterConstruction; override;
    constructor Create(AOwner: TComponent); override;
    procedure Erro(msg:String);
    function IsEmpty : Boolean;

    function Validar : Boolean;

  published
    property ALTextLabel: String read GetALTextLabel write SetALTextLabel;
    property ALTipo: TALTipo read FALTipo write SetALTipo;
    property ALOnValidating: TValidateTextEvent  read FALOnValidating write SetALOnValidating;
    property ALOnValidate: TValidateTextEvent  read FALOnValidate write SetALOnValidate;
    property ALValido :Boolean read FALValido write SetALValido;
    property ALObrigatorio :Boolean  read FALObrigatorio write SetALObrigatorio;
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
  CharCase     := TEditCharCase.ecUpperCase;

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


constructor TALEdit.Create(AOwner: TComponent);
begin
  inherited;
  ALMenssagem := TStringList.Create;
end;

procedure TALEdit.Erro(msg: String);
begin
  ALMenssagem.Add(msg);
  ALValido := False;
end;

function TALEdit.GetALTextLabel: String;
begin
  if Assigned(FALlabel) then
    Result := FALlabel.Text;
end;

procedure TALEdit.InternalValidate(Sender: TObject; var Text: string);
begin
  ALValido := True;
  ALMenssagem.Clear;

  if Assigned(FALOnValidate) then
    FALOnValidate(Sender,Text);

  if ALObrigatorio then
  begin
    case ALTipo of
      Nada: begin
              if Text.IsEmpty then
                Erro('Campo obrigatorio e não pode ser vazio');
            end;

      Cep,Pessoa :begin
                    if RemoverNumeros(Text).IsEmpty then
                      Erro('Campo obrigatorio e não pode ser vazio');
                  end;
      Valor,Inteiro:begin
                      if StrToFloatDef(Text,-1) = -1 then
                        Erro('Campo obrigatorio e não pode ser vazio!');
                    end;

    end;
  end;

  if ALTipo = Pessoa then
  begin
    if not ValidarCpf(Text) then
      Erro('CPF informado esta errado');
  end;


end;

procedure TALEdit.InternalValidating(Sender: TObject; var Text: string);
begin
  if Assigned(FALOnValidating) then
    FALOnValidating(Sender,Text);
end;

function TALEdit.IsEmpty: Boolean;
begin
  Result :=  Trim((Text)) = EmptyStr;
end;

procedure TALEdit.Path1Click(Sender: TObject);
begin
  ShowMessage(ALMenssagem.Text);
end;



procedure TALEdit.SetALObrigatorio(const Value: Boolean);
begin
  FALObrigatorio := Value;
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
  FALTipo    := Value;
  FilterChar := '';

  if (FALTipo = Pessoa) then
    FilterChar := '0123456789';

  if (FALTipo = Cep) then
    FilterChar := '0123456789-';

  if (FALTipo = Valor) then
    FilterChar := '0123456789,';

  if (FALTipo = Inteiro) then
    FilterChar := '0123456789';

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
    FALPath.OnClick    := Path1Click;
  end
  else
    if Assigned(FALPath) then
    begin
      FALPath.Destroy;
      FALPath := nil;
    end;
end;

procedure TALEdit.SetName(const NewName: TComponentName);
begin
  inherited;
  if Assigned(FALlabel) then
    FALlabel.Name := Name + 'lbl';
end;

function TALEdit.Validar: Boolean;
var
  sText:String;
begin
  sText := Self.Text;
  InternalValidate(Self, sText);
  Result := ALValido;
end;

end.
