#ST2: Retornar livros cadastrados

*** Settings ***
Library           Collections
Library           RequestsLibrary

*** Variables ***
${base_url}=        https://fakerestapi.azurewebsites.net


*** Test Cases ***
Return All Books
    Create Session  newsession  ${base_url}

    ${response}=  get request  newsession  /api/Books
    log to console  ${response.status_code}

    ${status_code}=  convert to string  ${response.status_code}
    Should Be Equal  ${status_code}  200

    #Run: robot -L trace TestCases\API-ST2.robot