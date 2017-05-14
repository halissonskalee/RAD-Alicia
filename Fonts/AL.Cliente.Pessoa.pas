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
  Data.Bind.DBScope, FireDAC.Phys.MongoDBWrapper;

type
  TFrmALClientePessoa = class(TFrmALClientePadrao)
    edt_id: TEdit;
    Label2: TLabel;
    edtrazao_social_pes: TEdit;
    edtdt_cadastro_pes: TDateEdit;
    Cadastro: TLabel;
    cmbvtipo_pes: TComboBox;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    Label3: TLabel;
    Label4: TLabel;
    lCpfCnpj: TLabel;
    edtcpf_cnpj_pes: TEdit;
    GroupBox1: TGroupBox;
    edtcodigo_cep: TEdit;
    Label5: TLabel;
    edtcidade_nome_cep: TEdit;
    Label6: TLabel;
    edtcidade_codigo_cep: TEdit;
    edtbairro_cep: TEdit;
    Label7: TLabel;
    edtrua_cep: TEdit;
    Label8: TLabel;
    edtnumero_cep: TEdit;
    Label9: TLabel;
    edtuf_cep: TEdit;
    Label10: TLabel;
    edtcomplemento_cep: TEdit;
    Label11: TLabel;
    SearchEditButton2: TSearchEditButton;
    procedure cmbvtipo_pesChange(Sender: TObject);
    procedure SearchEditButton2Click(Sender: TObject);
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
  if cmbvtipo_pes.ItemIndex =0 then
     lCpfCnpj.Text := 'CPF'
  else
     lCpfCnpj.Text := 'CNPJ';
end;

function TFrmALClientePessoa.Criar: Boolean;
begin
  Pessoa              := TPessoa.Create;

  Persistencia.Tabela := 'PESSOA';

  FieldText := 'razao_social_pes';
  FieldID   := '_id';

end;

function TFrmALClientePessoa.Editar(Json: string): Boolean;
begin
  Pessoa := TJson.JsonToObject<TPessoa>(Json);

  edt_id.Text               := Pessoa._id.ToString;
  edtrazao_social_pes.Text  := Pessoa.razao_social_pes;
  edtdt_cadastro_pes.Date   := Pessoa.dt_cadastro_pes;
  cmbvtipo_pes.ItemIndex    := Pessoa.tipo_pes.ToInteger;
  edtcpf_cnpj_pes.Text      := Pessoa.cpf_cnpj_pes;



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


function TFrmALClientePessoa.Novo: Boolean;
begin
  edt_id.AsInteger          :=0;
  edt_id.Leitura            :=True;
  edtrazao_social_pes.Clear;
  edtdt_cadastro_pes.Date   := Now;
  cmbvtipo_pes.ItemIndex    := 0;
  edtcpf_cnpj_pes.Clear     ;

  Result := True;
end;

function TFrmALClientePessoa.NovoBefore: Boolean;
begin
  Result := True;
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
    edt_id.AsInteger := FrmALClienteDmDados.Gen_pessoa;

  Pessoa._id              := StrToIntDef(edt_id.Text,0) ;
  Pessoa.razao_social_pes := edtrazao_social_pes.Text;
  Pessoa.dt_cadastro_pes  := edtdt_cadastro_pes.Date;
  Pessoa.tipo_pes         := cmbvtipo_pes.ItemIndex.ToString;
  Pessoa.cpf_cnpj_pes     := edtcpf_cnpj_pes.Text;

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
