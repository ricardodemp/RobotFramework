*** Settings ***
Resource    ../Resource/Resource.robot
Test Setup      Login
#Test Teardown   Logout
### SETUP roda keyword antes da suite e do teste
### TEARDOWN roda keyword depois de uma siute ou um teste

#*** Variables ***

*** Test Cases ***
TC 01 - Criar nova carga manual
    Clicar no botão Nova Carga
    Informar todos os campos do formulário
   #Clicar no botão Salvar
   #Conferir dados informados

#TC 02 - Editar cargas


#TC 03 - Exclusão de cargas
