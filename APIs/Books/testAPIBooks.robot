*** Settings ***
Documentation   Documentação da API: https://fakerestapi.azurewebsites.net/api/v1/
Resource        ResourceAPI.robot
Suite Setup     Conectar à API

*** Variable ***
${URL_API}  https://fakerestapi.azurewebsites.net/api/v1


*** Test Case ***
Buscar listagem de todos os livros
    Requisitar todos os livros
    Conferir status code    200
    Conferir reason     OK
    Conferir se retorna lista com "200" Livros

Buscar um livro apenas
    Requisitar o Livro "15"
    Conferir status code    200
    Conferir reason     OK
    Conferir todos os dados do livro 15

Cadastrar um novo Livro (POST)
    Cadastrar um novo livro
    Conferir status code    200
    Conferir reason     OK
    Conferir se retorna todos os dados alterados do livro "201"

Alterar um livro (PUT)
    Alterar o livro "150"
    Conferir status code    200
    Conferir reason     OK
    Conferir se retorna todos os dados alterados do livro "150"

Deletar um livro (DELETE)
    Excluir o livro "200"
    Conferir status code    200
    Conferir reason   OK
    Conferir se excluiu o livro "200"