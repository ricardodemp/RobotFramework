*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${URL}      http://qualidade.focco.com.br/vm-clone-12/erp/app/Comercial/Expedicao/FPLC0253
${BROWSER}  chrome
${USUARIO}  teste06
${SENHA}    teste18
${ROTA}     10


*** Keywords ***
### Setup e Teardown

Login
    Open Browser            ${URL}          ${BROWSER}
    Maximize Browser Window
    Input Text              id=txtUser      ${USUARIO}
    Input Text              id=txtPassword  ${SENHA}
    Click Element           id=btnSignin

Logout
    Click Element           xpath=//*[@class="erp-user-dropdown"]
    #Close Browser

Clicar no botão Nova Carga
    Wait Until Element Is Visible   xpath=//*[@class="ffbutton__text"][contains(text(),"NOVA CARGA")]
    Click Element                   xpath=//*[@class="ffbutton__text"][contains(text(),"NOVA CARGA")]

Informar todos os campos do formulário
#campoRota
    Wait Until Element Is Visible   xpath=//input[@id='Descricao']
    Click Element                   xpath=//input[@id='Descricao']
    Input Text              id=RotaID      ${ROTA}
    Press Keys              id=RotaID       ENTER

    ${numbers}=    Evaluate    random.sample(range(1, 11), 1)    random
    Input Text              id=Descricao      Rota ${numbers}
    Click Element           xpath=//span[contains(text(),'Salvar')]
