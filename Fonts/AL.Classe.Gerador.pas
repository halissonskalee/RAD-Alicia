unit AL.Classe.Gerador;

interface

Uses AL.Tipo, AL.Classe.Padrao, System.JSON, FMX.Dialogs;

type
  TGerador = class(TPadrao)
  public
    function Pessoa : Integer;
    function GetTabela: string; override;
    function CriarGerador : Boolean;
end;

implementation

uses
  FireDAC.Phys.MongoDBWrapper, REST.Json, FireDAC.Phys.MongoDBDataSet;

{ TGeradore }


{ TGerador }

function TGerador.CriarGerador: Boolean;
var
  SQL : TFDMongoDataSet;
  oDoc : TMongoDocument;
begin
  try
    SQL            := TFDMongoDataSet.Create(nil);
    SQL.Connection := GetFDCon;

    SQL.Close;
    SQL.Cursor  := GetConMongo[GetBanco][GetTabela].Find();
    SQL.Open;


    if SQL.IsEmpty then
    begin
      oDoc := GetEnv.NewDoc;
      oDoc.Add('_id',0);
      GetConMongo[GetBanco][GetTabela].Insert(oDoc);
      Exit;
    end;


    if SQL.FindField('PESSOA') = nil then
    begin
       GetConMongo[GetBanco][GetTabela].Update()
        .Match
          .Add('_id', 0)
        .&End
        .Modify
          .&Set()
            .Field('PESSOA', 0)
          .&End
        .&End
        .Exec;
    end;

  finally
    SQL.Free;
  end;
end;

function TGerador.GetTabela: string;
begin
  Result := 'GERADOR';
end;

function TGerador.Pessoa: Integer;
var
  SQL : TFDMongoDataSet;
begin
  try
    GetConMongo[GetBanco][GetTabela].Update()
      .Match
        .Add('_id', 0)
      .&End
      .Modify
        .Inc()
          .Field('PESSOA', 1)
        .&end
      .&End
      .Exec;


    SQL            := TFDMongoDataSet.Create(nil);
    SQL.Connection := GetFDCon;
    SQL.Close;
    SQL.Cursor  := GetConMongo[GetBanco][GetTabela].Find();
    SQL.Open;
    Result := SQL.FieldByName('PESSOA').AsInteger;
  finally
    SQL.Free;
  end;
end;

end.
