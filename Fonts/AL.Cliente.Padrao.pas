unit AL.Cliente.Padrao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Actions,
  FMX.ActnList, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts,
  FMX.ListBox, FMX.Edit, FMX.SearchBox, FMX.TabControl,
  FireDAC.Phys.MongoDBWrapper,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.MongoDBDataSet, FireDAC.Stan.Async, FireDAC.DApt,
  AL.Cliente.Modelo,
  AL.Persistencia, System.Rtti, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.Grid, FMX.Grid, Data.Bind.DBScope, FMX.ScrollBox, FMX.Memo,
  FMX.Grid.Style, FMX.Objects, AL.Componente.TLabel;

type
  TAcao = (tpInsert, tpUpdate, tpLista);

type
  TFrmALClientePadrao = class(TFrmALClienteModelo)
    Panel2: TPanel;
    ActionList1: TActionList;
    acSalvar: TAction;
    acExcluir: TAction;
    acSair: TAction;
    acNovo: TAction;
    acEditar: TAction;
    lyCliente: TLayout;
    TabControl: TTabControl;
    tabLista: TTabItem;
    tabCadastro: TTabItem;
    changeTabLista: TChangeTabAction;
    changeTabCadastro: TChangeTabAction;
    acVoltar: TAction;
    pTitulo: TPanel;
    lblTitulo: TLabel;
    ListBox2: TListBox;
    ListBoxItem1: TListBoxItem;
    edtBusca: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    SearchEditButton1: TSearchEditButton;
    griLista: TGrid;
    SQLListar: TFDMongoDataSet;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    tabDesenvolvedor: TTabItem;
    Button1: TButton;
    Memo1: TMemo;
    vCadastro: TVertScrollBox;
    btnCriar: TButton;
    btnFindIndex: TButton;
    btnVoltar: TButton;
    Panel4: TPanel;
    ALLabel1: TALLabel;
    Image1: TImage;
    btnNovo: TButton;
    Panel3: TPanel;
    ALLabel2: TALLabel;
    Image2: TImage;
    btnEditar: TButton;
    Panel5: TPanel;
    ALLabel3: TALLabel;
    Image3: TImage;
    btnSalvar: TButton;
    Panel6: TPanel;
    ALLabel4: TALLabel;
    Image4: TImage;
    btnExcluir: TButton;
    Panel7: TPanel;
    ALLabel5: TALLabel;
    Image5: TImage;
    procedure acNovoExecute(Sender: TObject);
    procedure acEditarExecute(Sender: TObject);
    procedure ListBox1ItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure acVoltarExecute(Sender: TObject);
    procedure acSairExecute(Sender: TObject);
    procedure edtBuscaChange(Sender: TObject);
    procedure SearchEditButton1Click(Sender: TObject);
    procedure lbListaItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure acSalvarExecute(Sender: TObject);
    procedure SQLListarBeforeOpen(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
    procedure btnCriarClick(Sender: TObject);
    procedure btnFindIndexClick(Sender: TObject);

  private

    FAcao: TAcao;
    FPersistencia: TALPersistencia;
    FFieldText: String;
    FFieldID: String;

    procedure fnc_limparCampos;
    procedure fnc_atualizaLista;
    procedure fnc_gerenciarForms;
    procedure fnc_buscarCampoChave(var i: Integer; const Item: TListBoxItem);
    procedure fnc_PreencherRegistros;
    procedure ExibirBotoes;



    { Private declarations }
  public
    { Public declarations }
    procedure fnc_montarGrid; virtual; abstract;


    function CriarBefore : Boolean; virtual;
    function Criar       : Boolean; virtual;
    function CriarAfter  : Boolean; virtual;

    function Editar(Json:String) : Boolean; virtual;


    function GetCon : TMongoCollection;
    function ListaAoCriar: Boolean; virtual;

    function Fechar: Boolean; virtual;
    function FocoInicial : Boolean ; virtual;
    function FocoNovo    : Boolean ; virtual;
    function FocoEditar  : Boolean ; virtual;

    function NovoBefore: Boolean; virtual;
    function Novo: Boolean; virtual;
    function NovoAfter: Boolean; virtual;


    function SalvarBefore: Boolean; virtual;
    function Salvar: Boolean; virtual;
    function SalvarAfter: Boolean; virtual;
    function Filtrar(Value:String):Boolean ; virtual;

  published
    property Acao         : TAcao           read FAcao         write FAcao;
    property Persistencia : TALPersistencia read FPersistencia write FPersistencia;
    property FieldText    : String          read FFieldText    write FFieldText;
    property FieldID      : String          read FFieldID      write FFieldID;


  end;

var
  FrmALClientePadrao: TFrmALClientePadrao;

implementation

{$R *.fmx}

uses AL.Cliente.DmDados, AL.Cliente.Menu, System.Threading, AL.Classe.Pessoa;

procedure TFrmALClientePadrao.acEditarExecute(Sender: TObject);
begin
  changeTabCadastro.ExecuteTarget(Self);
  ExibirBotoes;
end;

procedure TFrmALClientePadrao.acNovoExecute(Sender: TObject);
begin
  if NovoBefore then
    if Novo then
    begin
      Self.FAcao := tpInsert;
      fnc_limparCampos;
      changeTabCadastro.ExecuteTarget(Self);
      ExibirBotoes;
      NovoBefore;
      FocoNovo;
    end;






end;

procedure TFrmALClientePadrao.acSairExecute(Sender: TObject);
begin
  inherited;
  Fechar;
end;

procedure TFrmALClientePadrao.acSalvarExecute(Sender: TObject);
begin
  inherited;
  if SalvarBefore then
    if Salvar then
      SalvarAfter
end;

procedure TFrmALClientePadrao.acVoltarExecute(Sender: TObject);
begin
  inherited;
  if TabControl.ActiveTab = tabLista then
  begin
    acSair.Execute;
    Exit
  end
  else
  begin
    FAcao := tpLista;
    changeTabLista.ExecuteTarget(Self);
    ExibirBotoes;
  end;

end;

procedure TFrmALClientePadrao.btnCriarClick(Sender: TObject);
var
  idx: TMongoIndex;
  oCrs: IMongoCursor;
begin
  inherited;
  idx := TMongoIndex.Create(FrmALClienteDmDados.GetEnv);
  try
      idx.Keys('{ "texto" : "text" }, { "default_language": "portuguese" }');
      idx.Options.Name := 'texto_text';


      //FrmALClienteDmDados.GetConMongo['teste']['buscafonetica'].CreateIndex(idx);
      GetCon.CreateIndex(idx);
      //oCrs := FrmALClienteDmDados.GetConMongo['teste']['buscafonetica'].ListIndexes;
      oCrs := GetCon.ListIndexes;
      while oCrs.Next do
        Memo1.Lines.Add(oCrs.Doc.AsJSON)
  finally
    idx.Free;
  end;

end;

procedure TFrmALClientePadrao.btnFindIndexClick(Sender: TObject);
var
  oCrs: IMongoCursor;
begin

//  oCrs := FConMongo['teste']['buscafonetica'].Find().Match('{ "$text" : { "$search" : "Caminho prender" } }').&End;

  oCrs := getCon.Find().Match('{ "$text" : { "$search" : "halisson" } }').&End;


  while oCrs.Next do
    Memo1.Lines.Add(oCrs.Doc.AsJSON)


end;

procedure TFrmALClientePadrao.Button1Click(Sender: TObject);
var
  oCrs: IMongoCursor;
begin
  inherited;
  oCrs := GetCon.ListIndexes;
  Memo1.Lines.Clear;
  while oCrs.Next do
    Memo1.Lines.Add(oCrs.Doc.AsJSON)
end;

procedure TFrmALClientePadrao.Button2Click(Sender: TObject);
begin
  // fnc_ExibirMensagem('Teste de Mensagem', 'Sua Mensagem foi Exibida com Sucesso', tpAlerta);
end;

function TFrmALClientePadrao.Criar: Boolean;
begin

end;

function TFrmALClientePadrao.CriarAfter: Boolean;
begin

end;

function TFrmALClientePadrao.CriarBefore: Boolean;
begin

end;

procedure TFrmALClientePadrao.fnc_atualizaLista;
begin
  fnc_montarGrid;
end;

procedure TFrmALClientePadrao.fnc_gerenciarForms;
begin
  { if Assigned(frmPrincipal.FormAtual) then
    frmPrincipal.FormAtual.Free;
    frmPrincipal.FormAtual := Self; }
end;

procedure TFrmALClientePadrao.fnc_buscarCampoChave(var i: Integer;
  const Item: TListBoxItem);
var
  Local_i: Integer;
begin
  // Pesquisar por Campo Chave e Colocar como Somente Leitura
  { for Local_i := Self.ComponentCount - 1 downto 0 do
    begin
    if (Self.Components[Local_i] is TMongoEdit) then
    begin
    if TMongoEdit(Self.Components[Local_i]).CampoChave then
    begin
    dsMongo.Locate(TMongoEdit(Self.Components[Local_i]).MongoCampo, Integer(Item.Data));

    if FAcao <> tpInsert then
    TMongoEdit(Self.Components[Local_i]).ReadOnly := true;
    end;
    end;
    end; }
end;

procedure TFrmALClientePadrao.fnc_PreencherRegistros;
var
  i: Integer;
begin
  // Buscar os Demais Campos e Preencher o Seu Valor
  { for i := Self.ComponentCount - 1 downto 0 do
    begin
    if (Self.Components[i] is TMongoEdit) then
    begin
    TMongoEdit(Self.Components[i]).Text := dsMongo.FieldByName(TMongoEdit(Self.Components[i]).MongoCampo).AsString;
    end;
    end; }
end;

function TFrmALClientePadrao.FocoEditar: Boolean;
begin

end;

function TFrmALClientePadrao.FocoInicial: Boolean;
begin

end;

function TFrmALClientePadrao.FocoNovo: Boolean;
begin

end;

procedure TFrmALClientePadrao.FormCreate(Sender: TObject);
var
  Task : ITask;
begin
  inherited;
  CriarBefore;

  lblTitulo.Text          := Self.Caption;
//  TabControl.TabPosition  := TTabPosition.None;
  TabControl.ActiveTab    := tabLista;
  ExibirBotoes;

  Persistencia := FrmALClienteDmDados.CriarPersistencia;
  Criar;
  CriarAfter;


  ListaAoCriar;

  Task := TTask.Create(
  procedure
  begin
    Sleep(200);
    FocoInicial;
  end);
  Task.Start;

end;

function TFrmALClientePadrao.GetCon: TMongoCollection;
begin
  Result := FrmALClienteDmDados.FConMongo[Persistencia.Banco][Persistencia.Tabela];
end;

procedure TFrmALClientePadrao.lbListaItemClick(const Sender: TCustomListBox;  const Item: TListBoxItem);
var
  oCrs : IMongoCursor;
begin
  oCrs := GetCon.Find().Match().Add(FFieldID,Integer(Item.Data)).&End;
  while oCrs.Next do
  begin
    if editar(oCrs.Doc.AsJSON) then
    begin
      changeTabCadastro.Execute;
      Acao := tpUpdate;
      ExibirBotoes;
      FocoEditar;
    end;
  end;
end;

function TFrmALClientePadrao.Editar(Json:String) : Boolean;
begin

end;

procedure TFrmALClientePadrao.edtBuscaChange(Sender: TObject);
begin
  inherited;
  Filtrar(edtBusca.Text)
end;

procedure TFrmALClientePadrao.ExibirBotoes;
begin
  if TabControl.ActiveTab  = tabLista then
  begin
    btnSalvar.Visible  := false;
    btnExcluir.Visible := false;
    btnNovo.Visible    := true;
    btnEditar.Visible  := True;
  end
  else
  if TabControl.ActiveTab = tabCadastro then
  begin
    btnEditar.Visible  := false;
    btnSalvar.Visible  := true;
    btnExcluir.Visible := true;
    btnNovo.Visible    := false;
  end;
end;

function TFrmALClientePadrao.Fechar: Boolean;
begin

end;

function TFrmALClientePadrao.Filtrar(Value: String): Boolean;
begin

end;


procedure TFrmALClientePadrao.fnc_limparCampos;
var
  i: Integer;
begin
  { for i := Self.ComponentCount - 1 downto 0 do
    begin
    if (Self.Components[i] is TMongoEdit) then
    begin
    TMongoEdit(Self.Components[i]).Text := '';
    end;
    end; }
end;

function TFrmALClientePadrao.ListaAoCriar: Boolean;
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

procedure TFrmALClientePadrao.ListBox1ItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
var
  i: Integer;
begin
  Self.Acao := tpUpdate;
  fnc_buscarCampoChave(i, Item);
  fnc_PreencherRegistros;
  changeTabCadastro.ExecuteTarget(Self);
  ExibirBotoes;
end;

function TFrmALClientePadrao.Novo: Boolean;
begin

end;

function TFrmALClientePadrao.NovoAfter: Boolean;
begin

end;

function TFrmALClientePadrao.NovoBefore: Boolean;
begin

end;

function TFrmALClientePadrao.Salvar: Boolean;
begin

end;

function TFrmALClientePadrao.SalvarAfter: Boolean;
var
  Task : ITask;
begin
  TabControl.ActiveTab := tabLista;

  Task := TTask.Create(
  procedure
  begin
    ListaAoCriar;
    FocoInicial;
  end);
  Task.Start;
end;

function TFrmALClientePadrao.SalvarBefore: Boolean;
begin

end;

procedure TFrmALClientePadrao.SearchEditButton1Click(Sender: TObject);
begin
  inherited;
  Filtrar(edtBusca.Text);
end;



procedure TFrmALClientePadrao.SQLListarBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  SQLListar.DatabaseName   := FrmALClienteDmDados.GetBanco;
  SQLListar.CollectionName := Persistencia.Tabela;
end;

end.
