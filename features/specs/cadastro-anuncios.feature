#language: pt

Funcionalidade: Cadastro de Anúncios
    Sendo um usuário cadastrado no Rocklov que possui equipamentos musicais
    Quero cadastrar meus equipamentos
    Para que eu possa disponibilizá-los para locação

    Contexto: Login
        * Login como "betao@yahoo.com.br" e "12345"

    @novo_equipo
    Cenario: Novo equipo

        Dado que acesso o formulário de cadastro de anúncios
            E que eu tenho os seguintes equipamentos:
            | thumb     | fender-sb.jpg |
            | nome      | Fender Strato |
            | categoria | Cordas        |
            | preco     | 200           |
        Quando submeto o cadastro deste item
        Então devo ver este item no meu Dashboard

    @temp
    Esquema do Cenario: Tentativa de cadastro de anúncios

        Dado que acesso o formulário de cadastro de anúncios
            E que eu tenho os seguintes equipamentos:
            | thumb     | <foto_input>      |
            | nome      | <nome_input>      |
            | categoria | <categoria_input> |
            | preco     | <preco_input>     |
        Quando submeto o cadastro deste item
        Então deve conter a mensagem de alerta: "<mensagem_output>"

        Exemplos:
            | foto_input    | nome_input        | categoria_input | preco_input | mensagem_output                      |
            |               | Fender Strato     | Cordas          | 100         | Adicione uma foto no seu anúncio!    |
            | amp.jpg       |                   | Outros          | 400         | Informe a descrição do anúncio!      |
            | clarinete.jpg | Clarinete Yamaha  |                 | 300         | Informe a categoria                  |
            | sanfona.jpg   | Sanfona Scandalli | Teclas          |             | Informe o valor da diária            |
            | conga.jpg     | Conga             | Outros          | abc         | O valor da diária deve ser numérico! |
            | conga.jpg     | Conga             | Outros          | 100a        | O valor da diária deve ser numérico! |

