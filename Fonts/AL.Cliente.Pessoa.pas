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




    { Public declarations }

  end;

var
  FrmALClientePessoa: TFrmALClientePessoa;

implementation

{$R *.fmx}

uses AL.Cliente.DmDados, FireDAC.Phys.MongoDBWrapper, AL.Cliente.Menu;


function TFrmALClientePessoa.Criar: Boolean;
begin
  Pessoa              := TPessoa.Create;
  Persistencia.Tabela := 'PESSOA';

  FieldText := 'razao_social_pes';
  FieldID   := '_id';

end;

function TFrmALClientePessoa.Editar(Json: string): Boolean;
begin
  Pessoa := Pessoa.FromJSON(Json);

  edt_id.Text               := Pessoa._id.ToString;
  edtrazao_social_pes.Text  := Pessoa.razao_social_pes;
  edtdt_cadastro_pes.Date   := Pessoa.dt_cadastro_pes;
  cmbvtipo_pes.ItemIndex    := Pessoa.tipo_pes.ToInteger;




end;

function TFrmALClientePessoa.Fechar: Boolean;
begin
  FrmALClientePessoa.lyCliente.RemoveObject(FrmALClientePessoa.lyCliente);
  FrmALClientePessoa := nil;
  Result := FrmALClientePessoa= nil;
end;


function TFrmALClientePessoa.FocoInicial: Boolean;
begin
  edtBusca.SetFocus
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
