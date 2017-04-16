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
  AL.Persistencia;

type
  TAcao = (tpInsert, tpUpdate, tpLista);

type
  TFrmALClientePadrao = class(TFrmALClienteModelo)
    Panel2: TPanel;
    btnNovo: TButton;
    ActionList1: TActionList;
    acSalvar: TAction;
    acExcluir: TAction;
    acSair: TAction;
    acNovo: TAction;
    acEditar: TAction;
    btnSalvar: TButton;
    btnExcluir: TButton;
    lyCliente: TLayout;
    TabControl: TTabControl;
    tabLista: TTabItem;
    tabCadastro: TTabItem;
    changeTabLista: TChangeTabAction;
    changeTabCadastro: TChangeTabAction;
    dsMongo: TFDMongoDataSet;
    acVoltar: TAction;
    btnVoltar: TButton;
    pTitulo: TPanel;
    lblTitulo: TLabel;
    lbLista: TListBox;
    ListBox2: TListBox;
    ListBoxItem1: TListBoxItem;
    edtBusca: TEdit;
    Label1: TLabel;
    ListBoxItem4: TListBoxItem;
    Panel1: TPanel;
    btnEditar: TButton;
    qyMongo: TFDMongoQuery;
    SearchEditButton1: TSearchEditButton;
    procedure acNovoExecute(Sender: TObject);
    procedure acEditarExecute(Sender: TObject);
    procedure acSalvarExecute(Sender: TObject);
    procedure ListBox1ItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure acVoltarExecute(Sender: TObject);
    procedure acSairExecute(Sender: TObject);
    procedure lbListaDblClick(Sender: TObject);
    procedure edtBuscaChange(Sender: TObject);
    procedure SearchEditButton1Click(Sender: TObject);

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
    function Lista(oCrs: IMongoCursor): Boolean;

    { Private declarations }
  public
    { Public declarations }
    procedure fnc_montarGrid; virtual; abstract;


    function CriarBefore : Boolean; virtual;
    function Criar       : Boolean; virtual;
    function CriarAfter  : Boolean; virtual;

    function Editar(Json:String) : Boolean; virtual;


    function GetCon : TMongoCollection;
    function ListaAoCriar: Boolean;

    function Fechar: Boolean; virtual;
    function FocoInicial : Boolean ; virtual;

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

uses AL.Cliente.DmDados, AL.Cliente.Menu, System.Threading;

procedure TFrmALClientePadrao.acEditarExecute(Sender: TObject);
begin
  changeTabCadastro.ExecuteTarget(Self);
  ExibirBotoes;
end;

procedure TFrmALClientePadrao.acNovoExecute(Sender: TObject);
begin
  Self.FAcao := tpInsert;
  fnc_limparCampos;
  changeTabCadastro.ExecuteTarget(Self);
  ExibirBotoes;
end;

procedure TFrmALClientePadrao.acSairExecute(Sender: TObject);
begin
  inherited;
  if Fechar then
    FrmALClienteMenu.RemoverFormulario;
end;

procedure TFrmALClientePadrao.acSalvarExecute(Sender: TObject);
begin
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

function TFrmALClientePadrao.FocoInicial: Boolean;
begin
//  edtBusca.SetFocus;
end;

procedure TFrmALClientePadrao.FormCreate(Sender: TObject);
var
  Task : ITask;

begin
  inherited;
  CriarBefore;

  lblTitulo.Text          := Self.Caption;
  TabControl.TabPosition  := TTabPosition.None;
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

  Task := TTask.Create(
  procedure
  begin
    Sleep(500);
    ListaAoCriar;
  end);
  Task.Start;

end;

function TFrmALClientePadrao.GetCon: TMongoCollection;
begin
  Result := FrmALClienteDmDados.FConMongo[Persistencia.Banco][Persistencia.Tabela];
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
var
  Cursor : IMongoCursor;
begin
  Cursor := GetCon.Find()
            .Match()
              .Exp('razao_social_pes',  '{"$regex" : "ha*"}')
            .&End;


  Lista(Cursor)
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
  Lista(GetCon.Find().Limit(100));
end;

procedure TFrmALClientePadrao.lbListaDblClick(Sender: TObject);
var
  Cursor    : IMongoCursor;
begin
  inherited;
  acEditar.Execute;

//  lbLista.Selected.Data;

  Cursor:= GetCon.Find()
          .Match()
            .Add('_id',0 )
          .&End;

  Cursor.Doc.AsJSON;
  Editar(Cursor.Doc.AsJSON);
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

function TFrmALClientePadrao.Salvar: Boolean;
begin

end;

function TFrmALClientePadrao.SalvarAfter: Boolean;
begin
  TabControl.ActiveTab := tabLista;
end;

function TFrmALClientePadrao.SalvarBefore: Boolean;
begin

end;

procedure TFrmALClientePadrao.SearchEditButton1Click(Sender: TObject);
begin
  inherited;
  Filtrar(edtBusca.Text);
end;

function TFrmALClientePadrao.Lista(oCrs :IMongoCursor): Boolean;
begin
  if not Assigned(oCrs) then
    Exit;
  if FFieldText.IsEmpty or FFieldID.IsEmpty then
    Exit;

  dsMongo.Close;
  dsMongo.Cursor := oCrs;
  dsMongo.Open;

  with dsMongo do
  begin
    First;
    lbLista.Items.Clear;
    while not Eof do
    begin
      lbLista.Items.AddObject(FieldByName(FFieldText).AsString, TObject(FieldByName(FFieldID).AsInteger));
      Next;
    end;
  end;
end;

end.
