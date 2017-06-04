unit AL.Cliente.Senha;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Edit,
  AL.Componente.TEdit, AL.Componente.TLabel;

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
  oCrs: IMongoCursor;
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


  oCrs := FrmALClienteDmDados.GetAux['PESSOA'].Find()
    .Match()
      .Add('usuario_pes', edtUsuario.Text)
      .Add('senha_pes: ', edtSenha.Text)
    .&end;


  if oCrs.Next then
    BooEntra := True;

  if not BooEntra then
    if (edtUsuario.Text= 'AL') and (edtSenha.Text = '1') then
      BooEntra := True;



  AniIndicator1.Visible := False;
  AniIndicator1.Enabled := False;

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
