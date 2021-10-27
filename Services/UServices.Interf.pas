unit UServices.Interf;

interface

uses
  System.JSON, System.Classes, System.SysUtils, Generics.Collections,System.Generics.Defaults;

type

  IServices<T> = interface
    ['{B35EC78B-89AF-4BF2-A92D-6AA1CFE5E263}']

    procedure PaginarConsulta(var TModel: T);
    function  executeGetRequest(arrayParams : array of string): TjsonObject;
    function  executePutRequest(AParams: TjsonObject = nil): TjsonObject;
    function  executePostRequest(AParams: TjsonObject = nil): TjsonObject;
    function  executeDeleteRequest(Aid: string): TjsonObject;
    function  NewInstance: IServices<T>;
  end;

  IToken<T> = interface
    ['{4C30EFA0-E2F8-421E-9C67-1EBB00BF4B39}']

    function  validateToken(AToken : string) : Boolean;
    function  getUserID : string;
    function  NewInstance: IToken<T>;
  end;

implementation

end.
