*** Settings ***
Library         SeleniumLibrary

*** Variables ***
${URL}  http://automationpractice.com
${BROWSER}  chrome

*** Test Case ***
Cenário 01 - Produto existente
    Dado que estou na página home do site
    Quando eu pesquisar pelo produto "Blouse"
    Então o produto "Blouse" deve ser listado na página de resultado da busca

Cenário 02 - Produto não existente
    Dado que estou na página home do site
    Quando eu pesquisar pelo produto "iteminexitente"
    Então a página deve exibir a mensagem "No results were found for your search "iteminexistente""
*** Keywords ***