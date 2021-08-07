#language: pt

Funcionalidade: Cadastro de Anúncios
    Sendo um usuário cadastrado no Rocklov que possui equipamentos musicais
    Quero cadastrar meus equipamentos
    Para que eu possa disponibilizá-los para locação

    Cenario: Novo equipo

        Dado que estou logado como "betao@yahoo.com.br" e "12345"
            E que acesso o formulário de cadastro de anúncios
            E que eu tenho os seguintes equipamentos:
            | thumb     | fender-sb.jpg |
            | nome      | Fender Strato |
            | categoria | Cordas        |
            | preco     | 200           |
        Quando submeto o cadastro deste item
        Então devo ver este item no meu Dashboard