*** Settings ***
Documentation   Documentação da API: https://fakerestapi.azurewebsites.net/api/v1
Library         RequestsLibrary
Library         Collections

*** Variable ***
${URL_API}  https://fakerestapi.azurewebsites.net/api/v1
&{BOOK_15}      id=15
...             title=Book 15
...             description=Lorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\n
...             pageCount=1500
...             excerpt=Lorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\nLorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\nLorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\nLorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\nLorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\n
&{BOOK_201}     id=201
...             title=Meu novo Book
...             description=Meu novo livro conta coisas fantásticas
...             pageCount=523
...             excerpt=Meu Novo livro é massa
...             publishDate=2018-04-26T17:58:14.765Z
&{BOOK_150}     id=150
...             title=Book 150 alterado
...             description=Descrição do book 150 alteada
...             pageCount=600
...             excerpt=Resumo do book 150 alteado
...             publishDate=2017-04-26T15:58:14.765Z

*** Keywords ***
#SETUP E TEARDOWN
Conectar à API
    Create Session  fakeAPI     ${URL_API}
    ${HEADERS}     Create Dictionary    content-type=application/json
    Set Suite Variable    ${HEADERS}

#AÇÕES
Requisitar todos os livros
    ${RESPOSTA}     Get Request     fakeAPI     Books
    Log     ${RESPOSTA.text}    #Equivalente ao ResponseBody
    Set Test Variable       ${RESPOSTA}     #setar a variável

Conferir status code
    [Arguments]     ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings      ${RESPOSTA.status_code}     ${STATUSCODE_DESEJADO}
    #Set Test Variable       ${RESPOSTA}

Conferir reason
    [Arguments]     ${REASON_DESEJADO}
    Should Be Equal As Strings      ${RESPOSTA.reason}      ${REASON_DESEJADO}

Conferir se retorna lista com "${QDADE_LIVROS}" Livros
    Length Should Be      ${RESPOSTA.json()}      ${QDADE_LIVROS}

Requisitar o Livro "${ID_LIVRO}"
    ${RESPOSTA}     Get Request     fakeAPI     Books/${ID_LIVRO}
    Log     ${RESPOSTA.text}    #Equivalente ao ResponseBody
    Set Test Variable       ${RESPOSTA}     #setar a variável

Conferir todos os dados do livro 15
    Dictionary Should Contain Item  ${RESPOSTA.json()}    id            ${BOOK_15.id}     #dictionary   #Key #value
    Dictionary Should Contain Item  ${RESPOSTA.json()}    title         ${BOOK_15.title}
    Dictionary Should Contain Item  ${RESPOSTA.json()}    description   ${BOOK_15.description}
    Dictionary Should Contain Item  ${RESPOSTA.json()}    pageCount     ${BOOK_15.pageCount}
    Dictionary Should Contain Item  ${RESPOSTA.json()}    excerpt       ${BOOK_15.excerpt}
    #Dictionary Should Contain Item  ${RESPOSTA.json()}    publishDate   ${BOOK_15.publishDate}     #valor é variável a cada requisição
    Should not be Empty             ${RESPOSTA.json()["publishDate"]}                               #por isso, valida apenas se não é nulo

#Se necessário conferir headers ${RESPOSTA.headers}
#Para usar log usar formato texto RESPOSTA.text
#Para navegar entre os registros usar o RESPOSTA.json

Cadastrar um novo livro
    ${Body}=         Create Dictionary   id=${BOOK_201.id}  title=${BOOK_201.title}     description=${BOOK_201.description}     pageCount=${BOOK_201.pageCount}     excerpt=${BOOK_201.excerpt}     publishDate=${BOOK_201.publishDate}
    ${HEADER}=       Create Dictionary   Content-Type=application/json
    ${RESPOSTA}=     Post Request        fakeAPI     Books      data=${BODY}     headers=${HEADER}

    ${status_code}     convert to string  ${RESPOSTA.status_code}
    should be equal     ${status_code}  200
    Set Test Variable       ${RESPOSTA}     #setar a variável

Conferir se retorna todos os dados cadastrados do livro "${ID_LIVRO}"
    Conferir livro    ${ID_LIVRO}

Conferir se retorna todos os dados alterados do livro "${ID_LIVRO}"
    Conferir livro    ${ID_LIVRO}

Conferir livro
    [Arguments]     ${ID_LIVRO}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    id              ${BOOK_${ID_LIVRO}.id}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    title           ${BOOK_${ID_LIVRO}.title}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    description     ${BOOK_${ID_LIVRO}.description}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    pageCount       ${BOOK_${ID_LIVRO}.pageCount}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    excerpt         ${BOOK_${ID_LIVRO}.excerpt}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    publishDate     ${BOOK_${ID_LIVRO}.publishDate}

Excluir o livro "${ID_LIVRO}"
    ${RESPOSTA}    Delete Request    fakeAPI    Books/${ID_LIVRO}
    Log            ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Conferir se excluiu o livro "${ID_LIVRO}"
    Should Be Empty     ${RESPOSTA.content}

Alterar o livro "${ID_LIVRO}"
    ${RESPOSTA}    Put Request    fakeAPI    Books/${ID_LIVRO}
    ...                           data={"ID": ${BOOK_150.id},"Title": "${BOOK_150.title}","Description": "${BOOK_150.description}","PageCount": ${BOOK_150.pageCount},"Excerpt": "${BOOK_150.excerpt}","PublishDate": "${BOOK_150.publishDate}"}
    ...                           headers=${HEADERS}
    Log            ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}


#http://qualidade.focco.com.br/vm-clone-12/api/docs/index.html

#robot -d ./results -L trace books/testAPIBooks.robot