*** Settings ***
Library    Browser
...        enable_presenter_mode=${true}
...        timeout=00:00:10
Library    FakerLibrary
Library    DateTime

*** Variables ***
${BROWSER}             chromium
${HEADLESS}            ${false}
${SITE_SERVER_REST}    https://front.serverest.dev/

*** Keywords ***
Abrir o navegador
    New Browser    browser=${BROWSER}
    ...            headless=${HEADLESS}
   ${TRACE_NAME}  FakerLibrary.Uuid 4
    ${NOW}         Get Current Date  result_format=%d-%m-%Y_%H%M%S
    New Context    viewport={'width': 1920, 'height': 1080}
    ...            tracing=${OUTPUT_DIR}/evidencies/traces/${NOW}/${TRACE_NAME}.zip
    ...            recordVideo={'dir':'${OUTPUT_DIR}/evidencies/videos/${NOW}'}
Acessar o site Rest Front
    New Page        url=${SITE_SERVER_REST}
    ${title}        Get Title    ==    Front - ServeRest
    Log  ${title} 
Evidenciar teste
    Take Screenshot       fullPage=${true}
Dado que acesso o site "front.serverest.dev"
    Abrir o navegador
    Acessar o site Rest Front
Quando seleciono a opção "Cadastre-se"
    Click    css=a[data-testid='cadastrar']
E preencho os dados obrigatórios
    ${EMAIL}    FakerLibrary.Email
    Set Test Variable    ${EMAIL}
    Log To Console    ${EMAIL}
    Fill Text    css=input[data-testid='nome']    Jacsonsm
    Fill Text    css=input[data-testid='email']    ${EMAIL}
    Fill Text    css=input[data-testid='password']    123456
    Check Checkbox    css=input[data-testid='checkbox']
E clico em "Cadastrar"
    Click    css=button[data-testid='cadastrar']
Então o cadastro é efetuado com sucesso
    Wait For Elements State    h1    visible
    Get Text    h1  ==  Bem Vindo Jacsonsm
    Get Element States    css=button[data-testid='logout']    validate    value & visible
Preencher os dados do usuario e cadastrar
    #Record Selector
    Click    css=a[data-testid='cadastrar']
    ${EMAIL}    FakerLibrary.Email
    Set Test Variable    ${EMAIL}
    Log To Console    ${EMAIL}
    Fill Text    css=input[data-testid='nome']    Jacsonsm
    Fill Text    css=input[data-testid='email']    ${EMAIL}
    Fill Text    css=input[data-testid='password']    123456
    Check Checkbox    css=input[data-testid='checkbox']
    #Click    css=button[data-testid='cadastrar']
    Click    xpath=//*[@id="root"]//button >> text="Cadastrar"
    Sleep    5

Conferir usuário cadastrado com sucesso
    Wait For Elements State    h1    visible
    Get Text    h1  ==  Bem Vindo Jacsonsm
    Get Element States    css=button[data-testid='logout']    validate    value & visible

Cadastrar novo usuário
    Dado que acesso o site "front.serverest.dev"
    Quando seleciono a opção "Cadastre-se"
    E preencho os dados obrigatórios
    E clico em "Cadastrar"
    Então o cadastro é efetuado com sucesso
Dado que realizo o cadastro de um usuário
    Cadastrar novo usuário
Quando acesso a lista de usuários cadastrados
    Click        css=a[data-testid='listarUsuarios']
Então é possível visualizar o usuário na listagem
    ${elemento}      Get Table Cell Element    css=table    "Nome"    "${EMAIL}"
    ${usuario_nome}  Get Text  ${elemento}  ==  Jacsonsm
    Highlight Elements    ${elemento}
    Take Screenshot       fullPage=${true}
Acessar a Lista de usuários
    Click        css=a[data-testid='listarUsuarios']

Conferir que o usuário aparece na listagem
    ${elemento}      Get Table Cell Element    css=table    "Nome"    "${EMAIL}"
    ${usuario_nome}  Get Text  ${elemento}  ==  Jacsonsm
    Highlight Elements    ${elemento}
    Take Screenshot       fullPage=${true}    