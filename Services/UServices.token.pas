unit Uservices.token;

interface

uses
  System.SysUtils,
  Uservices.interf,
  JOSE.Core.Builder,
  JOSE.Core.JWT,
  JOSE.Core.JWK;

const
  key = 'You_may_say_Im_a_dreamer_But_Im_not_the_only_one_I_hope_someday_you_ll_join_us_And_the_world_will_be_as_one_';

type

  TTokenService = class(TInterfacedObject, IToken<TTokenService>)
  private
    FIssuer: string;
    FSubject: string;
    FExpiration: TDateTime;
    FUserId: string;
  public
    property UserId: string read FUserId write FUserId;
    property Issuer: string read FIssuer write FIssuer;
    property Subject: string read FSubject write FSubject;
    property Expiration: TDateTime read FExpiration write FExpiration;

    procedure clear;
    function  gerenateToken: string;
    function  unpackToken(AToken: string) : boolean;
    function  validateToken(AToken : string) : Boolean;
    function  getUserID : string;
    function  NewInstance: IToken<TTokenService>;

  end;


implementation

{ TTokenService }

procedure TTokenService.clear;
begin
  FSubject    := '';
  FIssuer     := '';
  FExpiration := 0;
end;

function TTokenService.NewInstance: IToken<TTokenService>;
begin
  if not Assigned(Result) then
    Result :=  TTokenService.Create;
end;

function TTokenService.gerenateToken: string;
var
  LToken: TJWT;
begin
  LToken := TJWT.Create;
  try
    // Token claims
    LToken.Claims.Issuer     := FIssuer;
    LToken.Claims.Subject    := FSubject;
    LToken.Claims.Expiration := FExpiration;
    LToken.Claims.JWTId      := FUserId;

    // Signing and Compact format creation
    result := TJOSE.SHA256CompactToken(key, LToken);
  finally
    LToken.Free;
  end;
end;

function TTokenService.getUserID: string;
begin
  Result := FuserID;
end;

function TTokenService.unpackToken(AToken: string): boolean;
var
  LKey: TJWK;
  LToken: TJWT;
begin
  Result  := false;

  clear;
  LKey    := TJWK.Create(key);
  LToken  := TJOSE.Verify(LKey, AToken);

  if Assigned(LToken) then
  begin
    try
      result := LToken.Verified;

      if Result then
      begin
        FSubject    := LToken.Claims.Subject;
        FIssuer     := LToken.Claims.Issuer;
        FExpiration := LToken.Claims.Expiration;
        FUserId     := LToken.Claims.JWTId;
      end;
    finally
      LToken.Free;
    end;
  end;
end;

function TTokenService.validateToken(AToken: string): Boolean;
begin
  Result := unpackToken(AToken);
end;

end.
