Dado('que acesso a página principal') do
  # A linha abaixo será substituída pela URL padrão definida no arquivo env.rb
  # visit "http://rocklov-web:3000"

  # Agora basta colocar "/caminho" que vem após a URL padrão que é "http://rocklov-web:3000"
  # Basta colocar "/" pois a URL de destino é a mesma URL padrão, ou seja, "http://rocklov-web:3000"
  # visit "/"

  # Usando PAGE OBJECT a partir daqui. Todo o código anterior deve ser comentado.
  login_page = LoginPage.new
  login_page.open

end
  
Quando('submeto minhas credenciais com {string} e {string}') do |email, password|
  # find("input[placeholder='Seu email']").set email
  # find("input[type=password").set password
  # click_button "Entrar"


  # Usando PAGE OBJECT a partir daqui. Todo o código anterior deve ser comentado.
  login_page = LoginPage.new
  # login_page.campo_email.set email
  # login_page.campo_nome.set password
  # login_page.botao_entrar

  # Melhorando ainda mais o PageObject, farei a chamada abaixo que reduz as linhas de código. O método do PageObject já realiza todas estas ações de "set" e "click"
  login_page.with(email, password)
end

Quando('submeto o seguinte formulario de login:') do |table|
  user = table.hashes.first

  # Substitui os valor antes passados por string por hashes:     user[:chave]
  find("#user_email").set user[:email]
  find("#user_password").set user[:senha]
  click_button "Entrar"
end
  
Então('vejo a mensagem de alerta: {string}') do |string|
  alert = find(".alert-dark")
  expect(alert.text).to eql expected_alert
end