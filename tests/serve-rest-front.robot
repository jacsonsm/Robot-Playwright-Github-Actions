*** Settings ***
Resource    ../resources/serve-rest-front.resource
Test Teardown   Evidenciar teste
Suite Teardown    Close Browser    ALL 

*** Test Cases ***
Cenário: Login com sucesso Server Rest front
    [Documentation]    Acessa a página front.serverest.dev
    ...                Realiza o cadastro
    ...                Valida que o cadastro foi realizado com sucesso.
    [Tags]    cadastro
    Dado que acesso o site "front.serverest.dev"
    Quando seleciono a opção "Cadastre-se"
    E preencho os dados obrigatórios
    E clico em "Cadastrar"
    Então o cadastro é efetuado com sucesso
    
Cenário:Cadastrar usuário, acessar lista de usuário e conferir se o novo usuário aparece na listagem
    [Documentation]    Acessa a página front.serverest.dev
    ...                Realiza o cadastro
    ...                Acessa a lista de usuários
    ...                Valida que o novo usuário cadastrado aparece na listagem.
    [Tags]    cadastro

    Dado que realizo o cadastro de um usuário
    Quando acesso a lista de usuários cadastrados
    Então é possível visualizar o usuário na listagem
