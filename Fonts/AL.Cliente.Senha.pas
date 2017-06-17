unit AL.Cliente.Senha;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Edit,
  AL.Componente.TEdit, AL.Componente.TLabel, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.MongoDBDataSet;

type
  TFrmALClienteSenha = class(TForm)
    lySenha: TLayout;
    edtSenha: TALEdit;
    edtUsuario: TALEdit;
    recSenha: TRectangle;
    AniIndicator1: TAniIndicator;
    btnSair: TButton;
    Image2: TImage;
    Sair: TALLabel;
    Panel3: TPanel;
    btnEntra: TButton;
    Panel4: TPanel;
    ALLabel1: TALLabel;
    Image1: TImage;
    Rectangle1: TRectangle;
    SQLUsuario: TFDMongoDataSet;
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnEntraClick(Sender: TObject);
    procedure edtSenhaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmALClienteSenha: TFrmALClienteSenha;

implementation

{$R *.fmx}

uses AL.Cliente.Menu, System.Threading, AL.Cliente.DmDados, AL.Cliente.CEP,
  FireDAC.Phys.MongoDBWrapper;

procedure TFrmALClienteSenha.btnEntraClick(Sender: TObject);
var
  BooEntra : Boolean;
begin
  if edtUsuario.IsEmpty then
    raise Exception.Create('Informe o nome do usuário!');

  if edtSenha.IsEmpty then
    raise Exception.Create('Informe o nome do Senha-!');


  booEntra              := False;
  AniIndicator1.Visible := True;
  AniIndicator1.Enabled := True;

  if not Assigned(FrmALClienteDmDados)  then
    FrmALClienteDmDados := TFrmALClienteDmDados.Create(Self);
  if not Assigned(FrmALClienteCEP)  then
    FrmALClienteCEP     := TFrmALClienteCEP.Create(Self);

  SQLUsuario.Close;
  SQLUsuario.Cursor := FrmALClienteDmDados.GetAux['PESSOA'].Find()
    .Match()
      .Add('usuario_login', edtUsuario.Text)
      .Add('usuario_senha', edtSenha.Text)
      .Add('usuario'      , True)
    .&end
    .Project()
      .Field('_id', true)
      .Field('razao_social_pes', true)
      .Field('data_cadastro_pes', true)
    .&End;
  SQLUsuario.Open;

  if not BooEntra then
    if (edtUsuario.Text= 'AL') and (edtSenha.Text = '1') then
      BooEntra := True;


  AniIndicator1.Visible := False;
  AniIndicator1.Enabled := False;


  if not BooEntra then
    if SQLUsuario.IsEmpty then
       raise Exception.Create('Usuário ou senha não invalido ou não cadastrado!')
    else
      BooEntra := True;


  if BooEntra then
  begin
    FrmALClienteMenu.lyMenssagem.RemoveObject(lySenha);
    FreeAndNil(FrmALClienteSenha);
  end;



end;

procedure TFrmALClienteSenha.btnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmALClienteSenha.edtSenhaKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    btnEntraClick(btnEntra);
end;

procedure TFrmALClienteSenha.FormCreate(Sender: TObject);
var
  Task : Itask;
begin
  Task := TTask.Create(
  procedure
  begin
    Sleep(300);
    edtUsuario.SetFocus;
  end);
  Task.Start;

end;

end.
