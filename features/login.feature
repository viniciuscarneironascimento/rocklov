#language: pt

Funcionalidade: Login
    Sendo um usuário cadastrado
    Quero acessar o sistema da Rocklov
    Para que eu possa anunciar meus equipamentos musicais

    Contexto:
        Dado que acesso a página principal

    @temp
    Cenario: Login do usuário

        # Dado que acesso a página principal
        Quando submeto minhas credenciais com "contato.vinicius@gmail.com" e "12345"
        Então sou redirecionado para o Dashboard


    @tentar_logar
    Esquema do Cenario: Tentar logar

        Quando submeto o seguinte formulario de login:
            | email         | senha         |
            | <email_input> | <senha_input> |
        Então vejo a mensagem de alerta: "<mensagem_output>"

        Exemplos:
            | email_input                | senha_input | mensagem_output                    |
            | contato.vinicius@gmail.com | 1234        | "Usuário e/ou senha inválidos."    |
            | contato@gmail.com          | 12345       | "Usuário e/ou senha inválidos."    |
            | contato.vinicius*gmail.com | 12345       | "Oops. Informe um email válido!"   |
            |                            | 12345       | "Oops. Informe um email válido!"   |
            | contato.vinicius@gmail.com |             | "Oops. Informe sua senha secreta!" |
            |                            |             | "Oops. Informe um email válido!"   |
            | contato@gmail.com          | 1234        | "Usuário e/ou senha inválidos."    |

