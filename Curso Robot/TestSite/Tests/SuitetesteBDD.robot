*** Settings ***
Resource        ../Resource/Resource.robot
Test Setup      Abrir Navegador
#Test Teardown   Fechar Navegador

*** Variables ***
${URL}      http://automationpractice.com
${BROWSER}  chrome

*** Test Case ***
Cenário 01 - Produto existente
    Dado que estou na página home do site
    Quando eu pesquisar pelo produto "Blouse"
    Então o produto "Blouse" deve ser listado na página de resultado da busca

Cenário 02 - Produto não existente
    Dado que estou na página home do site
    Quando eu pesquisar pelo produto "iteminexistente"
    Então a página deve exibir a mensagem "No results were found for your search "iteminexistente""

*** Keywords ***
Dado que estou na página home do site
    Acessar a página home do site

Quando eu pesquisar pelo produto "${PRODUTO}"
    Digitar o nome do produto "${PRODUTO}" na pesquisa
    Clicar no botão pesquisar

Então o produto "${PRODUTO}" deve ser listado na página de resultado da busca
    Conferir se o produto "${PRODUTO}" foi listado no site

Então a página deve exibir a mensagem "${MENSAGEM}"
    Conferir mensagem de erro "${MENSAGEM}"
