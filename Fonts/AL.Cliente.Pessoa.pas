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
  Data.Bind.DBScope;

type
  TFrmALClientePessoa = class(TFrmALClientePadrao)
    Label1: TLabel;
    edt_id: TEdit;
    Label2: TLabel;
    edtrazao_social_pes: TEdit;
    edtdt_cadastro_pes: TDateEdit;
    Cadastro: TLabel;
    cmbvtipo_pes: TComboBox;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    Label3: TLabel;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField: TLinkFillControlToField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Pessoa : TPessoa;
  public
    function SalvarBefore: Boolean; override;
    function Salvar: Boolean; override;
    function Filtrar(Value: string): Boolean; override;

    { Public declarations }

  end;

var
  FrmALClientePessoa: TFrmALClientePessoa;

implementation

{$R *.fmx}

uses AL.Cliente.DmDados, FireDAC.Phys.MongoDBWrapper;


function TFrmALClientePessoa.Filtrar(Value: string): Boolean;
var
  oCrs: IMongoCursor;
  LBItem    : TListBoxItem;
begin
  oCrs := FrmALClienteDmDados.FConMongo[Persistencia.Banco][Persistencia.Tabela].Find();
  dsMongo.Close;
  dsMongo.Cursor := oCrs;
  dsMongo.Open;

  with dsMongo do
  begin
    First;
    ListBox1.Items.Clear;
    while not Eof do
    begin
      ListBox1.Items.AddObject(FieldByName('razao_social_pes').AsString, TObject(FieldByName('_id').AsInteger));
      Next;
    end;
  end;

end;

procedure TFrmALClientePessoa.FormCreate(Sender: TObject);
begin
  inherited;
  Pessoa              := TPessoa.Create;
  Persistencia.Tabela := 'PESSOA';
end;

function TFrmALClientePessoa.Salvar: Boolean;
begin

  Pessoa._id              := StrToIntDef(edt_id.Text,0) ;
  Pessoa.razao_social_pes := edtrazao_social_pes.Text;
  Pessoa.dt_cadastro_pes  := edtdt_cadastro_pes.Date;
  Pessoa.tipo_pes         := cmbvtipo_pes.ItemIndex.ToString;
  Persistencia.JSON       := Pessoa.AsJSON;

  Persistencia.Insert;

  Result := True;
end;

function TFrmALClientePessoa.SalvarBefore: Boolean;
begin
  Result := True;
end;

end.
