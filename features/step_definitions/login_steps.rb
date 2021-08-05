Dado('que acesso a página principal') do
    visit "http://rocklov-web:3000"
  end
  
  Quando('submeto minhas credenciais com {string} e {string}') do |email, password|
    find("input[placeholder='Seu e-email']").set email
    find("input[type=password").set password
    click_button "Entrar"
  end

  Quando('submeto o seguinte formulario de login:') do |table|
    user = table.hashes.first

    # Substitui os valor antes passados por string por hashes:     user[:chave]
        find("#email").set user[:email]
        find("#password").set user[:senha]
        click_button "Entrar"
  end
  
  Então('vejo a mensagem de alerta: {string}') do |string|
    alert = find(".alert-dark")
    expect(alert.text).to eql expected_alert
  end