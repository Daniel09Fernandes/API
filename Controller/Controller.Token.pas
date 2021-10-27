unit Controller.Token;

interface

type
  TControllerToken = class
  private
    Fuser_ID      : string;
  public

  property user_ID : string read Fuser_ID;
  function validarTokem(Atokem : string) : Boolean;

  end;

 var
  ControllerToken : TControllerToken;

implementation

uses
  Uservices.token, UServices.Interf;


function TControllerToken.validarTokem(Atokem: string): Boolean;
var Token         : TTokenService;
    IToken        : IToken<TTokenService>;
begin
  IToken    := Token.NewInstance;
  Result    := IToken.validateToken(Atokem);

  if Result then
    Fuser_ID  := IToken.getUserID;
end;

end.
