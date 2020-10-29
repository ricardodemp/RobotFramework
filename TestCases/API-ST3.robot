#ST3: Retornar apenas um livro

*** Settings ***
Library           Collections
Library           RequestsLibrary

*** Variables ***
${base_url}=        https://fakerestapi.azurewebsites.net
${book}=  1

*** Test Cases ***

Return one Book
    Create Session  newsession  ${base_url}

    ${response}=  get request  newsession  /api/Books/${book}
    log to console  ${response.status_code}

    ${status_code}=  convert to string  ${response.status_code}
    Should Be Equal  ${status_code}  200

