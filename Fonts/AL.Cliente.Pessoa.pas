unit AL.Cliente.Pessoa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  AL.Cliente.Padrao, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.MongoDBDataSet, FMX.TabControl, System.Actions, FMX.ActnList,
  FMX.Edit, FMX.SearchBox, FMX.ListBox, FMX.Layouts, FMX.Controls.Presentation,
  FMX.DateTimeCtrls , AL.Classe.Pessoa, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, FireDAC.Phys.MongoDBWrapper, Fmx.Bind.Grid, Data.Bind.Grid,
  FMX.Grid, FMX.ScrollBox, FMX.Memo, AL.Componente.TEdit, FMX.Grid.Style,
  AL.Componente.TDateEdit, AL.Componente.TComboBox, FMX.Objects,
  AL.Componente.TLabel;

type
  TFrmALClientePessoa = class(TFrmALClientePadrao)
    tabEndereco: TTabItem;
    tabUsuario: TTabItem;
    gUsuario: TGroupBox;
    edtusuario_login: TALEdit;
    edtusuario_senha: TALEdit;
    gEndereco: TGroupBox;
    edtuf_cep: TEdit;
    Label10: TLabel;
    edtcodigo_cep: TALEdit;
    SearchEditButton2: TSearchEditButton;
    edtcidade_nome_cep: TALEdit;
    edtcidade_codigo_cep: TALEdit;
    edtbairro_cep: TALEdit;
    edtrua_cep: TALEdit;
    edtnumero_cep: TALEdit;
    edtcomplemento_cep: TALEdit;
    gPrincipal: TGroupBox;
    cmbtipo_pes: TALComboBox;
    edt_id: TALEdit;
    edtcpf_cnpj_pes: TALEdit;
    edtdt_cadastro_pes: TALDateEdit;
    edtrazao_social_pes: TALEdit;
    chkCliente: TSwitch;
    ALLabel6: TALLabel;
    chkFornecedor: TSwitch;
    ALLabel7: TALLabel;
    chkUsuario: TSwitch;
    ALLabel8: TALLabel;
    procedure cmbvtipo_pesChange(Sender: TObject);
    procedure SearchEditButton2Click(Sender: TObject);
    procedure rUsuarioChange(Sender: TObject);
  private
    { Private declarations }
    Pessoa : TPessoa;
  public
    function SalvarBefore: Boolean; override;
    function Salvar: Boolean; override;
    function Criar: Boolean; override;
    function Fechar: Boolean; override;
    function FocoInicial: Boolean; override;
    function Editar(Json: string): Boolean; override;
    function FocoNovo: Boolean; override;
    function FocoEditar: Boolean; override;
    function NovoBefore: Boolean; override;
    function Novo: Boolean; override;
    function ListaAoCriar: Boolean; override;
    function Filtrar(Value: string): Boolean; override;






    { Public declarations }

  end;

var
  FrmALClientePessoa: TFrmALClientePessoa;

implementation

{$R *.fmx}

uses AL.Cliente.DmDados, AL.Cliente.Menu, Rest.Json, AL.Cliente.CEP,
  AL.Classe.Endereco, AL.Helper.Edit;


procedure TFrmALClientePessoa.cmbvtipo_pesChange(Sender: TObject);
begin
  inherited;
  if cmbtipo_pes.ItemIndex =0 then
     edtcpf_cnpj_pes.ALTextLabel := 'CPF'
  else
     edtcpf_cnpj_pes.ALTextLabel := 'CNPJ';
end;

function TFrmALClientePessoa.Criar: Boolean;
begin
  Pessoa               := TPessoa.Create;
  Persistencia.Tabela  := 'PESSOA';
  FieldText            := 'razao_social_pes';
  FieldID              := '_id';
  chkUsuario.IsChecked := False;
end;

function TFrmALClientePessoa.Editar(Json: string): Boolean;
begin
  Pessoa := TJson.JsonToObject<TPessoa>(Json);

  edt_id.Text              := Pessoa._id.ToString;
  edtrazao_social_pes.Text := Pessoa.razao_social_pes;
  edtdt_cadastro_pes.Date  := Pessoa.dt_cadastro_pes;
  cmbtipo_pes.ItemIndex    := Pessoa.tipo_pes.ToInteger;
  edtcpf_cnpj_pes.Text     := Pessoa.cpf_cnpj_pes;
  chkUsuario.IsChecked     := Pessoa.usuario;
  edtusuario_login.Text    := Pessoa.usuario_login;
  edtusuario_senha.Text    := Pessoa.usuario_senha;



  edtuf_cep.Text            :=  Pessoa.endereco_principal.uf_cep;
  edtcodigo_cep.Text        :=  Pessoa.endereco_principal.codigo_cep;
  edtcidade_codigo_cep.Text :=  Pessoa.endereco_principal.cidade_codigo_cep;
  edtcidade_nome_cep.Text   :=  Pessoa.endereco_principal.cidade_nome_cep;
  edtrua_cep.Text           :=  Pessoa.endereco_principal.rua_cep;
  edtnumero_cep.Text        :=  Pessoa.endereco_principal.numero_cep;
  edtbairro_cep.Text        :=  Pessoa.endereco_principal.bairro_cep ;
  edtcomplemento_cep.Text   :=  Pessoa.endereco_principal.complemento_cep;



  Result := True;
end;

function TFrmALClientePessoa.Fechar: Boolean;
begin
  FrmALClientePessoa.lyCliente.RemoveObject(FrmALClientePessoa.lyCliente);
  FreeAndNil(FrmALClientePessoa);
  Result := FrmALClientePessoa= nil;
end;


function TFrmALClientePessoa.Filtrar(Value: string): Boolean;
begin
  SQLListar.Close;
  SQLListar.Cursor := GetCon.Find()
                              .Match()
                                .Exp('razao_social_pes', '{ "$regex" : "'+Value+'" }')
                              .&End
                              .Project()
                                .Field('_id', true)
                                .Field('razao_social_pes', true)
                                .Field('data_cadastro_pes', true)
                              .&End;
  SQLListar.Open;
end;

function TFrmALClientePessoa.FocoEditar: Boolean;
begin
  edtrazao_social_pes.SetFocus;
end;

function TFrmALClientePessoa.FocoInicial: Boolean;
begin
  edtBusca.SetFocus
end;

function TFrmALClientePessoa.FocoNovo: Boolean;
begin
  edtrazao_social_pes.SetFocus;
end;

function TFrmALClientePessoa.ListaAoCriar: Boolean;
begin
  SQLListar.Close;
  SQLListar.Cursor := GetCon.Find()
                              .Project()
                                .Field('_id', true)
                                .Field('razao_social_pes', true)
                                .Field('data_cadastro_pes', true)
                              .&End;
  SQLListar.Open;
end;

function TFrmALClientePessoa.Novo: Boolean;
begin
  edt_id.AsInteger           := 0;
  edt_id.Leitura             := True;
  edtrazao_social_pes.Clear;
  edtdt_cadastro_pes.Date    := Now;
  cmbtipo_pes.ItemIndex      := 0;
  edtcpf_cnpj_pes.Clear;
  chkUsuario.IsChecked       := False;

  Result := True;
end;

function TFrmALClientePessoa.NovoBefore: Boolean;
begin
  Result := True;
end;

procedure TFrmALClientePessoa.rUsuarioChange(Sender: TObject);
begin
  inherited;
  gUsuario.Visible := not chkUsuario.IsChecked;
end;

function TFrmALClientePessoa.Salvar: Boolean;
{var
  s : String;
  oDoc: TMongoDocument;}
begin
  Pessoa.GetEnv       := FrmALClienteDmDados.GetEnv;
  Pessoa.GetConMongo  := FrmALClienteDmDados.GetConMongo;
  Pessoa.GetBanco     := FrmALClienteDmDados.GetBanco;



  if Acao = tpInsert  then
    edt_id.AsInteger :=  FrmALClienteDmDados.vGerador.Pessoa;

  Pessoa._id              := StrToIntDef(edt_id.Text,0) ;
  Pessoa.razao_social_pes := edtrazao_social_pes.Text;
  Pessoa.dt_cadastro_pes  := edtdt_cadastro_pes.Date;
  Pessoa.tipo_pes         := cmbtipo_pes.ItemIndex.ToString;
  Pessoa.cpf_cnpj_pes     := edtcpf_cnpj_pes.Text;

  Pessoa.usuario        := chkUsuario.IsChecked;
  Pessoa.usuario_login  := edtusuario_login.Text;
  Pessoa.usuario_senha  := edtusuario_senha.Text;


  Pessoa.endereco_principal.uf_cep            := edtuf_cep.Text;
  Pessoa.endereco_principal.codigo_cep        := edtcodigo_cep.Text;
  Pessoa.endereco_principal.cidade_codigo_cep := edtcidade_codigo_cep.Text;
  Pessoa.endereco_principal.cidade_nome_cep   := edtcidade_nome_cep.Text;
  Pessoa.endereco_principal.rua_cep           := edtrua_cep.Text;
  Pessoa.endereco_principal.numero_cep        := edtnumero_cep.Text;
  Pessoa.endereco_principal.bairro_cep        := edtbairro_cep.Text;
  Pessoa.endereco_principal.complemento_cep   := edtcomplemento_cep.Text;

{  s := TJson.ObjectToJsonString(Pessoa,[joDateFormatMongo]);

  oDoc := FrmALClienteDmDados.FEnv.NewDoc;
  oDoc.AsJSON := s;

  FrmALClienteDmDados.FConMongo['BANCO']['TESTE'].Insert(oDoc);}


 if Acao = tpInsert  then
    Pessoa.Insert;
  if Acao = tpUpdate then
    Pessoa.Update;

  Result := True;
end;

function TFrmALClientePessoa.SalvarBefore: Boolean;
begin
  Result := True;
end;

procedure TFrmALClientePessoa.SearchEditButton2Click(Sender: TObject);
var
  vEndereco :TEndereco;
begin
  inherited;
  vEndereco := FrmALClienteCEP.BuscarCEP(edtcodigo_cep.Text);
  edtcodigo_cep.Text                := vEndereco.codigo_cep;
  edtuf_cep.Text                    := vEndereco.uf_cep;
  edtcidade_nome_cep.Text           := vEndereco.cidade_nome_cep;
  edtcidade_codigo_cep.Text         := vEndereco.cidade_codigo_cep;
  edtbairro_cep.Text                := vEndereco.bairro_cep;
  edtrua_cep.Text                   := vEndereco.rua_cep;
//  edtnumero_cep.Text                := vEndereco.numero_cep;
  edtcomplemento_cep.Text           := vEndereco.complemento_cep;
end;

end.
