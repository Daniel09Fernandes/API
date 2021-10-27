unit UModel.Agenda;

interface

uses
  FireDAC.Comp.Client;

type
  TmodelAgenda = class

  protected
    Flimit: integer;
    FNumPagina: integer;
    FqtdReg: integer;
    FPaginado: boolean;

    function countRegistro(qry: TFDQuery; ParamName, paramValue: variant): integer;
    function GetTotalPagina: integer;

  public
    property qtdReg: integer         read FqtdReg           write FqtdReg;
    property limit: integer          read Flimit            write Flimit;
    property NumPagina: integer      read FNumPagina        write FNumPagina;
    property paginado: boolean       read FPaginado         write FPaginado;
    property TotalPaginas: integer   read GetTotalPagina;
end;

implementation

function TmodelAgenda.countRegistro(qry: TFDQuery;ParamName, paramValue: variant): integer;
begin
  try
    qry.Open;
    Result := qry.Fields[0].AsInteger;
    qtdReg := Result +1; //todas as +1 da matriz

    // Maximo de registro em uma consulta
    if (qtdReg > 1000) then
      limit := 1000;

  finally
    qry.Close;
  end;
end;

function TmodelAgenda.GetTotalPagina: integer;
begin
  Result := 0;
  if limit > 0 then
    Result := Trunc((qtdReg / limit) + 1);
end;

end.
