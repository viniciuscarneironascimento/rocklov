#language: pt

Funcionalidade: Cadastro
    Sendo um músico que possui equipamentos musicais
    Quero fazer o meu cadastro no RockLov
    Para que eu possa disponibilizá-los para locação

    @cadastro
    Cenario: Fazer cadastro

        Dado que acesso a página de cadastro
        Quando submeto o seguinte formulário de cadastro:
            | nome     | email                      | senha |
            | Vinicius | contato.vinicius@gmail.com | 12345 |
        Então sou redirecionado para o Dashboard

    @esquema_cenario_tentativa_cadastro
    Esquema do Cenario: Tentativa de cadastro

        Dado que acesso a página de cadastro
        Quando submeto o seguinte formulário de cadastro:
            | nome         | email         | senha         |
            | <nome_input> | <email_input> | <senha_input> |
        Então vejo a mensagem de alerta: "<mensagem_output>"

        Exemplos:
            | nome_input | email_input                | senha_input | mensagem_output                    |
            |            | contato.vinicius@gmail.com | 12345       | "Oops. Informe seu nome completo!" |
            | Vinicius   |                            | 12345       | "Oops. Informe um email válido!"   |
            | Vinicius   | contato*gmail.com          | 12345       | "Oops. Informe um email válido!"   |
            | Vinicius   | contato#gmail.com          | 12345       | "Oops. Informe um email válido!"   |
            | Vinicius   | contato.vinicius@gmail.com |             | "Oops. Informe sua senha secreta!" |
            | Vinicius   | contato.vinicius@gmail.com | 12345       | "🤭 Email já cadastrado."          |