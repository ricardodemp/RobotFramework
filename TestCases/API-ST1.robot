#ST1: Permitir o cadastro de livros

*** Settings ***
Library           Collections
Library           RequestsLibrary

*** Variables ***
${base_url}=        https://fakerestapi.azurewebsites.net

*** Test Cases ***
Insert Book
    Create Session  newsession  ${base_url}

    ${body}=  create dictionary  ID=1  Title=Gog  Description="Gog, milionarul extravagant, vrea sa incerce orice experienta care i-ar putea alunga plictiseala si isi petrece viata calatorind prin lume si ascultind istoriile cele mai absurde si mai nebunesti. Prin tot ceea ce face Gog, Papini insira prin fata ochilor nostri o galerie impresionanta de personaje, de la personalitati ilustre din domeniul literaturii, stiintei si politicii la sarlatani marunti si grotesti, strinsi in jurul celebrului protagonist in speranta unui cistig. „Cind sint intrebat ce m-a impresionat cel mai mult la intoarcerea in Italia, raspund fara nici o ezitare: Papini. Este lucrul cel mai grandios pe care l-am gasit aici.”  PageCount=119  Excerpt="I fogli di questo nuovo diario appartengono quasi tutti a una delle più nere età della storia umana, cioè agli anni dell'ultima guerra e del dopoguerra."  PageCount=195  PublishDate=2020-10-20T20:01:05
    ${header}=  create dictionary  Content-Type=application/JSON
    ${response}=  post request  newsession  /api/Books  data=${body}  headers=${header}

    log to console  ${response.status_code}

    ${status_code}=  convert to string  ${response.status_code}
    Should Be Equal  ${status_code}  200

