*** Settings ***
Resource    ../resources/serve-rest-front.resource
Test Teardown   Evidenciar teste
Suite Teardown    Close Browser    ALL 

*** Test Cases ***
Cenário: Login com sucesso Server Rest front
    [Tags]    teste
    Dado que acesso o site "front.serverest.dev"
    Quando seleciono a opção "Cadastre-se"
    E preencho os dados obrigatórios
    E clico em "Cadastrar"
    Então o cadastro é efetuado com sucesso
    
    # Abrir o navegador
    # Acessar o site Rest Front
    # Preencher os dados do usuario e cadastrar
    # Conferir usuário cadastrado com sucesso
Desafio:Cadastrar usuário, acessar lista de usuário e conferir se o novo usuário aparece na listagem
    [Tags]    teste
    Dado que realizo o cadastro de um usuário
    Quando acesso a lista de usuários cadastrados
    Então é possível visualizar o usuário na listagem

    # Acessar a Lista de usuários
    # Conferir que o usuário aparece na listagem