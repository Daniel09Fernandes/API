unit Connection;

interface

uses
  IniFiles, FireDAC.Stan.Def, FireDAC.Stan.Intf, FireDAC.Phys.fb,
  FireDAC.Phys.FBdef,
  SqlExpr,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, Vcl.Dialogs, FireDAC.Comp.UI, System.UITypes,
  FireDAC.DAPT, System.SysUtils;

type
  TConn = class
  private

  public
    Conn: TFDConnection;
    constructor create;
  end;

implementation

{ TConn }

constructor TConn.create;
var
  connINI: TINIfile;
begin
  try

    // Verifica a existencia do diretorio
    if not FileExists ('C:\Program Files (x86)\store\Config\Connections.ini')then
    begin
      ForceDirectories('C:\Program Files (x86)\store\Config\');
    end;

    //Cria a conexão
    connINI := TINIfile.create
      ('C:\Program Files (x86)\store\Config\Connections.ini');
    Conn := TFDConnection.create(nil);
    Conn.Params.Clear;

    Conn.DriverName := connINI.ReadString('SQLConn', 'Protocol',
      'Não leu os dados de protocol da Zconections');

    Conn.Params.Values['DriverID'] := connINI.ReadString('SQLConn', 'Protocol',
      'Erro no VendorLib  ');
    Conn.Params.Values['Server'] := connINI.ReadString('SQLConn', 'Hostname',
      'Erro ao ler o Hostname');
    Conn.Params.Values['Database'] := connINI.ReadString('SQLConn', 'Database',
      'Erro ao ler o caminho do banco de dados');
    Conn.Params.Values['User_Name'] := connINI.ReadString('SQLConn',
      'Username', 'Erro ao ler o usuario de acesso ao banco de dados');
    Conn.Params.Values['Password'] := connINI.ReadString('SQLConn', 'Password',
      'Erro ao ler a senha do banco de dados');
    Conn.Connected := true;
  //  Conn.ConnectionName := 'Sqlconn';
  finally
    connINI.Free;
  end;

end;

end.
