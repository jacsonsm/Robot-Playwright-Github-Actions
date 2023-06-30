*** Settings ***
Resource    ../resources/serve-rest-front.resource

Test Setup     Run Keywords       Abri o navegador     AND
...                               Abrir o site da Server Rest      AND
...                               Criar um usuário de teste
Suite Teardown    Close Browser    ALL
*** Test Cases ***

Login com sucesso Server Rest Front

    Preencher os dados do usuário e cadastrar
    Validar a mensagem de boas vindas para um usuário logado

    [Teardown]    Realizar logout do usuário

Validar se o usuário está visível na tela de listagem de usuários após o cadastro

    Realizar o cadastro de um novo usuário
    Acessar a tela de listagem de usuarios
    Validar se o usuário está visivel na tabela de usuários

    [Teardown]    Realizar logout do usuário


Arquivo de resources:

*** Settings ***
Library    Browser
Library    FakerLibrary
Library    Collections

*** Variables ***
${BROWSER}      chromium
${HEADLESS}     ${FALSE}
${VIEWPORT}     {'width': 1280, 'height': 720}
${URL}          https://front.serverest.dev/login


*** Keywords ***
Abri o navegador
    New Browser     browser=${BROWSER}      headless=${HEADLESS}
    New Context     viewport=${VIEWPORT}

Abrir o site da Server Rest
    New Page              ${URL}
    Get Title    ==       Front - ServeRest

Criar um usuário de teste

    ${NAME}                 FakerLibrary.Name
    ${EMAIL}                FakerLibrary.Email
    ${PASSWORD}             FakerLibrary.Password

    ${user}=    Create Dictionary    nome=${NAME}       email=${EMAIL}      password=${PASSWORD}
    Set Test Variable    ${USER}    ${user}

Preencher os dados do usuário e cadastrar
    Click                   text="Cadastre-se"

    Fill Text               input[data-testid="nome"]               ${USER.nome}
    Fill Text               input[data-testid="email"]              ${USER.email}
    Fill Text               input[data-testid="password"]           ${USER.password}
    Check Checkbox          input[data-testid="checkbox"]
    Click                   button[data-testid="cadastrar"]

Validar a mensagem de boas vindas para um usuário logado

    Get Text    h1   ==     Bem Vindo ${USER.nome}

Realizar logout do usuário
    Click   button[data-testid="logout"]
    Wait For Elements State    button[data-testid="entrar"]     visible

Acessar a tela de listagem de usuarios
    Click    a[data-testid="listarUsuarios"]
    Get Text    h1   ==     Lista dos usuários

Validar um item na tabela de usuários
    [Arguments]    ${column}    ${row_data}    ${value}

    ${elemento}     Get Table Cell Element    css=.table   "${column}"    "${row_data}"
    Get Text     ${elemento}  ==  ${value}

Validar se o usuário está visivel na tabela de usuários

    Validar um item na tabela de usuários     Nome        ${USER.email}   ${USER.nome}
    Validar um item na tabela de usuários     Email       ${USER.nome}    ${USER.email}
    Validar um item na tabela de usuários     Senha       ${USER.nome}    ${USER.password}

Realizar o cadastro de um novo usuário

    Preencher os dados do usuário e cadastrar
    Validar a mensagem de boas vindas para um usuário logado