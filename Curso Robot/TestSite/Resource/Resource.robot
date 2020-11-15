*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${URL}      http://automationpractice.com
${BROWSER}  chrome


*** Keywords ***
### Setup e Teardown
Abrir Navegador
    Open Browser  ${URL}  ${BROWSER}

Fechar Navegador
    Close Browser

### Passo a Passo
Acessar a página home do site
    Title Should Be  My Store

Digitar o nome do produto "${PRODUTO}" na pesquisa
    Input Text  id=search_query_top  ${PRODUTO}

Clicar no botão pesquisar
    Click Element  submit_search

Conferir se o produto "Blouse" foi listado no site
    Wait Until Element is Visible   css=#center_column > h1
    Title Should Be                 Search - My Store
    Page Should Contain Image       xpath=//*[@id="center_column"]//*[@src="http://automationpractice.com/img/p/7/7-home_default.jpg"]
    Page Should Contain Link        xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(),"Blouse")]

Conferir mensagem de erro "${MENSAGEM}"
    Wait Until Element is Visible   css=#center_column > p
    Element Should Contain          css=#center_column > p   ${MENSAGEM}

    #xpath=//*[@id="center_column"]//p[@class="alert alert-warning"]

    #rodar todos os casos especificando o deretório dos resultados
    #robot -d ./results TestSite\Tests\SuiteTeste.robot

    #rodar só um teste especifico
    #robot -t "TC 01 - Produto existente" TestSite\Tests

    #Passar variáveis globais
    #robot -v BROWNSER:Firefox TestSite\Tests\SuiteTeste.robot

    #rodar todos os casos com trace completo
    #robot -d ./results -L trace TestSite\Tests\SuiteTeste.robot
