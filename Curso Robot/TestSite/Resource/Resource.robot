*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${URL}      http://automationpractice.com
${BROWSER}  chrome

*** Keywords ***
### Setup e Teardown
Abrir Navegador
    Open Browser  ${URL}  ${BROWSER}
    Maximize Browser Window

Fechar Navegador
    Close Browser

### Passo a Passo - Ações
Acessar a página home do site
    Title Should Be  My Store

Digitar o nome do produto "${PRODUTO}" na pesquisa
    Input Text  id=search_query_top  ${PRODUTO}

Clicar no botão pesquisar
    Click Element  submit_search

Conferir se o produto "${PRODUTO}" foi listado no site
    Wait Until Element is Visible   css=#center_column > h1
    Title Should Be                 Search - My Store
    Page Should Contain Image       xpath=//*[@id="center_column"]//*[@src="http://automationpractice.com/img/p/7/7-home_default.jpg"]
    Page Should Contain Link        xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(),"Blouse")]

Conferir mensagem de erro "${MENSAGEM}"
    Wait Until Element is Visible   css=#center_column > p
    Element Should Contain          css=#center_column > p   ${MENSAGEM}

Passar o mouse por cima da categoria "${CATEGORIA}" no menu principal superior de categorias.
    Mouse Over                      xpath=//*[@class="sf-with-ul"][contains(text(),"Women")]

Clicar na sub categoria "${SUBCATEGORIA}"
    Click Element                    xpath=//*[@id="block_top_menu"]//*[contains(text(),"Summer Dresses")]


Clicar no botão "${BOTAOCARRINHO}" do produto
   Mouse Over                       xpath=//*[@id="center_column"]//*[@src="http://automationpractice.com/img/p/1/1-home_default.jpg"]
   Click Element                    xpath=//*[@class="button ajax_add_to_cart_button btn btn-default"]//*[contains(text(),"Add to cart")]
    #//*[@id="center_column"]/ul/li/div/div[2]/div[2]/a[1]

Clicar no botão "${BOTAOCHECKOUT}"
   #Click Element                    xpath=//*[@class="btn btn-default button button-medium"]//*[contains(text(),"Proceed to checkout")]
    Click Element                    xpath://header/div[3]/div[1]/div[1]/div[4]/div[1]/div[2]/div[4]/a[1]
    #rodar todos os casos especificando o deretório dos resultados
    #robot -d ./results TestSite\Tests\SuiteTeste.robot
    #robot -d ./results "TC 04 - Adicionar Produtos no Carrinho" TestSite\Tests\SuiteTeste.robot

    #rodar só um teste especifico
    #robot -t "TC 01 - Produto existente" TestSite\Tests

    #Passar variáveis globais
    #robot -v BROWNSER:Firefox TestSite\Tests\SuiteTeste.robot

    #rodar todos os casos com trace completo
    #robot -d ./results -L trace TestSite\Tests\SuiteTeste.robot
