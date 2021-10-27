# API - By: Daniel Fernandes
Exemplo de aplicação do padrão de projeto "Controller -> Services -> Model -> DAO -> BD"

- Interface para padronização de methodos e utilização do garbage Collection nas pontas das interfaces, com factory, para evitar criação de objetos para cada requisição, evitando vazamento de memoria.

- Apenas um objeto de conexão ao BD, e as DAOs compartilham desta conexão, alimenta um Clientdataset para trabalhar em memoria, e fecha a conexao, evitando processamento de banco desnecessarios. Só abre novamente para CRUD, atualizando o CDS e fecha na sequencia. os CDS se "trasformam" em classes Model, onde é implementado a logica relacionada ao BD.

- A controller cuida apenas das requisições.

- A Services cuida da logica das requisições passadas pela controller, monta os JSONs.

- Implementação de segurança com bearer token. 

#####################################################################################################################################################################
Configuração Search Path
- Para Utilizar, provavelmente ira precisar alterar o search path do projeto, apontando para as pastas Dao, Controller, helper, Model, services, comum e conexaoPadrao.

- Libis externas para apontar na search path: 
    JoseJWT todas as patas dentro da Source, incluindo a Source
    dataset-serialize-master\src

#####################################################################################################################################################################
Configuração DB
- Após compilado, precisa apontar o banco, para apontar, tera que utilizar um exe que desenvolvi para apontar para o ini de configuração, pois o ini é criptografado.
para logar no Setupbanco.exe, irei passar a senha individualmente. 

o ini de configuração, terá o nome da aplicação e ficara no mesmo diretorio. 

Após configurado o ini da API,
deve fazer a mesma configuração para o microserviço Authorization, pode copiar e colar e renomear o ini para o Authorization. 

###################################################################################################################################################################
Segurança da API

*****Nessa etapa valida qual empresa está logada para controle de visualização*****

- Utilizando o postman, ira definir basic auth, colocar o usuario(User_id) ta tabela tb_empresas do banco, a senha irei passar a logica individualmente.

Fazendo a requisição get no Microserviço, ira gerar um bearer token,
 Link para gerar o token http://localhost:8080/ms/auth/TSMAuthentication/Token

Colar o beare token na requisição da API
 link para API: http://localhost:91/api/v1/TsmAgendamentos/Agendamentos/     
    

