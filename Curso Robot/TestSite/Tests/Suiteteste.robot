*** Settings ***
Resource        ../Resource/Resource.robot
Test Setup      Abrir Navegador
Test Teardown   Fechar Navegador

### SETUP roda keyword antes da suite e do teste
### TEARDOWN roda keyword depois de uma siute ou um teste

#*** Variables ***

*** Test Case ***
TC 01 - Produto existente
    #[Setup] Fechar navegador y -> use isso para a necessidade de um setup específico
    Acessar a página home do site
    Digitar o nome do preoduto "Blouse" na pesquisa
    Clicar no botão pesquisar
    #Conferir se o produto "Blouse" foi listado no site
#TC 02 - Produto não existente
    #Acessar a págna home do site
    #Digitar o nome do preduto "iteminexistente" na pesquisa
    #Clicar no botão pesquisar
    #Conferir mensagem de erro "No results were found for your search "iteminexistente""

*** Keywords ***