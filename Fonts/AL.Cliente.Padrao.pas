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
  FMX.Grid.Style, FMX.Objects, AL.Componente.TLabel, AL.Componente.TEdit,
  FMX.DialogService.Sync;

type
  TAcao = (tpInsert, tpUpdate, tpLista, tpExcluir);

type
  TFrmALClientePadrao = class(TFrmALClienteModelo)
    pTooBar: TPanel;
    ActionList1: TActionList;
    acSalvar: TAction;
    acExcluir: TAction;
    acSair: TAction;
    acNovo: TAction;
    acEditar: TAction;
    lyCliente: TLayout;
    TabControlPrincipal: TTabControl;
    tabLista: TTabItem;
    tabCadastro: TTabItem;
    acVoltar: TAction;
    pTitulo: TPanel;
    lblTitulo: TLabel;
    griLista: TGrid;
    SQLListar: TFDMongoDataSet;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    tabDesenvolvedor: TTabItem;
    Button1: TButton;
    Memo1: TMemo;
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
    Rectangle1: TRectangle;
    edtBusca: TALEdit;
    procedure acNovoExecute(Sender: TObject);
    procedure acEditarExecute(Sender: TObject);
    procedure ListBox1ItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure acVoltarExecute(Sender: TObject);
    procedure acSairExecute(Sender: TObject);
    procedure edtBuscaChange(Sender: TObject);
    procedure acSalvarExecute(Sender: TObject);
    procedure SQLListarBeforeOpen(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
    procedure btnCriarClick(Sender: TObject);
    procedure btnFindIndexClick(Sender: TObject);
    procedure edtBuscaValidate(Sender: TObject; var Text: string);
    procedure griListaCellDblClick(const Column: TColumn; const Row: Integer);
    procedure acExcluirExecute(Sender: TObject);

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

    procedure SetAcao(const Value: TAcao);



    { Private declarations }
  public
    { Public declarations }
    procedure fnc_montarGrid; virtual; abstract;


    function CriarBefore : Boolean; virtual;
    function Criar       : Boolean; virtual;
    function CriarAfter  : Boolean; virtual;


    function ExcluirBefore : Boolean; virtual;
    function Excluir       : Boolean; virtual;
    function ExcluirAfter  : Boolean; virtual;


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
    property Acao         : TAcao            read FAcao write SetAcao;
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
var
  oCrs : IMongoCursor;
begin
  if SQLListar.IsEmpty then
    raise Exception.Create('Nenhum registro para editar!');

  oCrs := GetCon.Find().Match().Add(FFieldID, SQLListar.FieldByName(FFieldID).AsInteger ).&End;
  while oCrs.Next do
  begin
    if editar(oCrs.Doc.AsJSON) then
    begin
      Acao := tpUpdate;
      TabControlPrincipal.ActiveTab := tabCadastro;

      FocoEditar;
    end;
  end;


end;

procedure TFrmALClientePadrao.acExcluirExecute(Sender: TObject);
begin
  inherited;

  if TDialogServiceSync.MessageDialog('Confirmar a exclusão?',
     TMsgDlgType.mtWarning, mbYesNo, TMsgDlgBtn.mbNo, 0) = mrYes then
  begin
    Acao := tpExcluir;
    if ExcluirBefore then
      if Excluir then
        ExcluirAfter;
  end;

end;

procedure TFrmALClientePadrao.acNovoExecute(Sender: TObject);
var
  I: Integer;
begin
  if NovoBefore then
  begin
    if Novo then
    begin
      Acao := tpInsert;
      fnc_limparCampos;
      TabControlPrincipal.ActiveTab := tabCadastro;

      NovoBefore;
      FocoNovo;

    end;
  end;







end;

procedure TFrmALClientePadrao.acSairExecute(Sender: TObject);
begin
  inherited;
  Fechar;
end;

procedure TFrmALClientePadrao.acSalvarExecute(Sender: TObject);
var
  I: Integer;

begin
  inherited;
  for I := 0 to ComponentCount-1 do
    if Components[i] is TALEdit then
      TALEdit(Components[i]).Validar;

  for I := 0 to ComponentCount-1 do
    if Components[i] is TALEdit then
      if not TALEdit(Components[i]).ALValido then
        Exit;



  if SalvarBefore then
    if Salvar then
      SalvarAfter
end;

procedure TFrmALClientePadrao.acVoltarExecute(Sender: TObject);
begin
  inherited;

  if Acao = tpLista then
  begin
    acSair.Execute;
    Exit
  end
  else
  begin
    FAcao := tpLista;

    TabControlPrincipal.ActiveTab := tabLista;

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

  Acao := tpLista;
  lblTitulo.Text                   := Self.Caption;
  TabControlPrincipal.ActiveTab    := tabLista;


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

procedure TFrmALClientePadrao.griListaCellDblClick(const Column: TColumn;
  const Row: Integer);
begin
  inherited;
  acEditar.Execute;
end;

function TFrmALClientePadrao.Editar(Json:String) : Boolean;
begin

end;

procedure TFrmALClientePadrao.edtBuscaChange(Sender: TObject);
begin
  inherited;
  Filtrar(edtBusca.Text)
end;

procedure TFrmALClientePadrao.edtBuscaValidate(Sender: TObject;
  var Text: string);
begin
  inherited;
  Filtrar(Text);
end;

function TFrmALClientePadrao.Excluir: Boolean;
begin
  GetCon.Remove().Match().Add(FFieldID, SQLListar.FieldByName(FFieldID).AsInteger ).&End.Exec;
end;

function TFrmALClientePadrao.ExcluirAfter: Boolean;
var
  Task : ITask;
begin
  Acao := tpLista;
  TabControlPrincipal.ActiveTab := tabLista;

  Task := TTask.Create(
  procedure
  begin
    Sleep(200);
    FocoInicial;
    ListaAoCriar
  end);
  Task.Start;



end;

function TFrmALClientePadrao.ExcluirBefore: Boolean;
begin

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

end;

procedure TFrmALClientePadrao.ListBox1ItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
var
  i: Integer;
begin
  Self.Acao := tpUpdate;
  fnc_buscarCampoChave(i, Item);
  fnc_PreencherRegistros;
  TabControlPrincipal.ActiveTab := tabCadastro;

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
  Acao := tpLista;
  TabControlPrincipal.ActiveTab := tabLista;

  Task := TTask.Create(
  procedure
  begin
    Sleep(200);
    FocoInicial;
  end);
  Task.Start;
end;

function TFrmALClientePadrao.SalvarBefore: Boolean;
begin

end;

procedure TFrmALClientePadrao.SetAcao(const Value: TAcao);
var
  I: Integer;
begin
  if Value = tpLista then
  begin
    for I := 0 to TabControlPrincipal.TabCount-1 do
      TabControlPrincipal.Tabs[i].Visible := False;
    tabLista.Visible := True;

    btnSalvar.Visible  := false;
    btnExcluir.Visible := false;
    btnNovo.Visible    := true;
    btnEditar.Visible  := True;
  end
  else
  begin
    for I := 0 to TabControlPrincipal.TabCount-1 do
      TabControlPrincipal.Tabs[i].Visible := True;
    tabLista.Visible := False;

    btnEditar.Visible  := false;
    btnSalvar.Visible  := true;
    btnExcluir.Visible := true;
    btnNovo.Visible    := false;
  end;

  FAcao := Value;
end;

procedure TFrmALClientePadrao.SQLListarBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  SQLListar.DatabaseName   := FrmALClienteDmDados.GetBanco;
  SQLListar.CollectionName := Persistencia.Tabela;
end;

end.
