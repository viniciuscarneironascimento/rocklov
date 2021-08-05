# 20/07/2021 2º- Esta "require" complementa a chamada da linha que instancia a conexaão com o banco de dados " client = Mongo::Client.new('mongodb://rocklov-db:27017/rocklov')"
# require 'mongo'

# @cadastro
Dado('que acesso a página de cadastro') do
    # A linha abaixo será substituída pela URL padrão definida no arquivo env.rb
    # visit "http://rocklov-web:3000/signup"

    # Agora basta colocar "/caminho" que vem após a URL padrão que é "http://rocklov-web:3000"
    visit "/signup"
end
  
# Quando('submeto o meu cadastro completo') do
#     # 20/07/2021 1º- Depois de ter criado todo o código anteriormente, hoje adicionarei um comando para realizar operação no banco de dados MongoDB conforme abaixo. Mas para isto funcionar é necessário importar a biblioteca gem do mongo no topo da página.
#     # client = Mongo::Client.new('mongodb://rocklov-db:27017/rocklov')

#  # 20/07/2021 3º- Ainda seguindo a documentação do mongo, para acessar uma collection (mesmo que tabela do BD), será necessário adicionar o comando abaixo epassar o nome da tabela do mongo, ou seja "users":
#     # collection = client[:users]
#     # users = client[:users]
#     # 20/07/2021 4º- Agora usaremos um métodos para DELETAR dados desta tabela "users":
#     # Desta forma não precisaremos usar "Faker::Internet.free_email", porém o dado a ser deletado deve ser EXATAMENTE igual ao que usaremos no comando "find("#email").set "contato.vinicius@gmail.com":
#     # users.delete_many({email: "contato.vinicius@gmail.com"})
#     # 20/07/2021 5º- Por fim, usaremos todos estes recursos em um outro arquivo Ruby, específico para tratar acesso ao banco de dados. Criaremos uma pasta "libs" dentro da pasta "suporte" onde copiaremos estes códigos em uma classe que será chamada aqui embaixo encapsulada. Instancio a classe MongoDb: 
#     MongoDB.new.remove_user("contato.vinicius@gmail.com")
#     # A execução da classe MongoDB acaba gerando LOG na execução do cucumber pelo terminal do prompt. Então faremos o seguinte: na pasta principal criarei uma nova pasta chamada "logs"


#     find("#fullName").set "Vinicius"
#     # Vou substituir a linha abaixo por dados dinâmicos usando FAKER. Desta forma não haverá validação de e-mail existente e perdermos nossa massa de teste ou até ter que reconstruir o BD no Docker. Mas esta solução é "macgyver" e deverá ser substituída no futuro por algo mais moderno.
#     find("#email").set "contato.vinicius@gmail.com"
#     # find("#email").set Faker::Internet.free_email
#     find("#password").set "12345"
#     click_button "Cadastrar"
# end


# 04/08/2021 Fatoração do step "Quando" utilizando Especificação por Exemplo
Quando('submeto o seguinte formulário de cadastro:') do |table|
# Transformar meu formulário em objeto Ruby
# Criar variável que recebe "tabela" passada por argumento e criar um "HASHES" do Ruby. Poderia usar também user = table.hashes[0]
    user = table.hashes.first

# Substitui os valor antes passados por string por hashes:     user[:chave]

# Para limpar os dados do banco MongoDB usamos a linha abaixo. Comentei para poder executar a regressão total sem falhas.
    # MongoDB.new.remove_user(user[:email])

    find("#fullName").set user[:nome]
    find("#email").set user[:email]
    find("#password").set user[:senha]
    click_button "Cadastrar"
end



# #04/08/2021 Removi este método e colei no arquivo shared_steps.rb
# Então('sou redirecionado para o Dashboard') do
#     #Posso usar a validação nativa abaixo, sem instalar o Rspec
#     # expect(page).to have_current_path('http://rocklov-web:3000/dashboard')

#     #Outra opção sem Rspec seria validar apenas um trecho da URL
#     # expect(page).to have_current_path('/dashboard')

#     # Utilizando o comando do RSPEC para busca por um objeto CSS na página fim.
#     expect(page).to have_css ".dashboard"

#     # O sleep deve ser retirado no final, pois só é usado para dar uma noção na etapa de desenv
#     # sleep 5
# end





# # 04/08/2021 Excluir todos os steps "Quando" de tentativas de cadastro pois refatorei o arquivo feature que recebe a massa de teste diretamente na especificação por exemplo. O Cucumber vai utilizar o mesmo método "Quando('submeto o seguinte formulário de cadastro:') do |table|" da linha 34
# # @sem_nome
# # Dando sequência no cógido, adiciono abaixo os novos STEPS do segundo Cenário
# # Não inicio com "DADO QUE" pois o cucumber já identificou que a linha 1 deste código já atende este step.
# Quando('submeto o meu cadastro sem o nome') do
#     find("#email").set Faker::Internet.free_email
#     find("#password").set "12345"
#     click_button "Cadastrar"
# end
  
# # Então('vejo a mensagem de alerta: Oops. Informe seu nome completo!') do
# #     # Primeira opção de validação: verifico se a tela exibe o texto "Oops. Informe seu nome completo!". Esta é a validação mais simples e vai passar.
# #     # expect(text).to have_text "Oops. Informe seu nome completo!"

# #     # Segunda opção de validação: verifico se a tela apresenta um elemento CSS contendo ".alert-dark". O sistema encontra, porém não valida a mensagem "Oops. Informe seu nome completo!" que é o objetivo deste step.
# #     # expect(page).to have_css ".alert-dark"

# #     # Terceira opção de validação: procuro um elemento CSS específico, ou seja, que possui style do tipo ".alert-dark", em seguida verifico se o texto apresentado neste style possui o texto deste step "Oops. Informe seu nome completo!".
# #     alert = find(".alert-dark")
# #     expect(alert.text).to eql "Oops. Informe seu nome completo!"
# # end


# # @sem_email
# #Vamos automatizar agora os três últimos Cenário de uma só vez.....
# # Não inicio com "DADO QUE" pois o cucumber já identificou que a linha 1 deste código já atende este step.
# Quando('submeto o meu cadastro sem o email') do
#     find("#fullName").set "Vinicius"
#     find("#password").set "12345"
#     click_button "Cadastrar"
# end

# # @email_inv
# # Ao executar "cucumber -t @email_inv" o cucumber identifica que tanto o "DADO QUE" como "ENTÃO" possuem o mesmo conteúdo, desta forma o CMDER apresentou apenas o "QUANDO".
# Quando('submeto o meu cadastro com email incorreto') do
#     find("#fullName").set "Vinicius"
#     find("#email").set "Faker::Internet.free_email"
#     find("#password").set "12345"
#     click_button "Cadastrar"
# end

# # antes de implementar isto vamos realizar um teste manual para mapear o elemento na tela
# # Então('vejo a mensagem de alerta: Oops. Informe um email válido!') do
# #     alert = find(".alert-dark")
# #     expect(alert.text).to eql "Oops. Informe um email válido!"
# # end

# # @sem_senha
# Quando('submeto o meu cadastro sem a senha') do
#     find("#fullName").set "Vinicius"
#     find("#email").set Faker::Internet.free_email
#     click_button "Cadastrar"
# end
  
# # Então('vejo a mensagem de alerta: Oops. Informe sua senha secreta!') do
# #     alert = find(".alert-dark")
# #     expect(alert.text).to eql "Oops. Informe sua senha secreta!"
# # end






# Estudo em 26/07/2021. Com a inclusão do step abaixo que recebe o arqgumento com as mensagens de alerta, os códigos das linhas 56, 88 e 100 não serão mais utilizados. O argumento passado por parâmetro vem de onde?????? Vem da documentação .FEATURE, ou seja, onde tiver escrito o step "Então vejo a mensagem de alerta: "mensagem"" o cucumber vai chamar este método. Atenção: este método só é válido pois as mensagens de validação são wxibidas em um mesmo componente da página HTML, só muda o texto apresentado.
# Então('vejo a mensagem de alerta: {string}') do |expected_alert|
#     alert = find(".alert-dark")
#     expect(alert.text).to eql expected_alert
#   end


# O cucumber modificou a linha de "Então('vejo a mensagem de alerta: {string}') do |expected_alert|" para a linha abaixo
# 04/08/2021 método movido para arquivo shared_steps.rb
# Então('vejo a mensagem de alerta: "{string}"') do |expected_alert|
#     alert = find(".alert-dark")
#     expect(alert.text).to eql expected_alert
# end
