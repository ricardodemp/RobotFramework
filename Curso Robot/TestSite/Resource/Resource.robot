*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${URL}      http://automationpractice.com
${BROWSER}  chrome
${PRODUTO}  Blouse

*** Keywords ***
### Setup e Teardown
Abrir Navegador
    Open Browser  ${URL}  ${BROWSER}

Fechar Navegador
    Close Browser

### Passo a Passo
Acessar a página home do site
    Title Should Be  My Store

Digitar o nome do preoduto "${PRODUTO}" na pesquisa
    Input Text  id=search_query_top  ${PRODUTO}

Clicar no botão pesquisar
    Click Element  submit_search

    #robot -d ./results TestSite\Tests\SuiteTeste.robot