#Step compartilhado entre os arquivos cadastro e login, pois utilizam a mesma regra
Então('sou redirecionado para o Dashboard') do
    #Posso usar a validação nativa abaixo, sem instalar o Rspec
    # expect(page).to have_current_path('http://rocklov-web:3000/dashboard')

    #Outra opção sem Rspec seria validar apenas um trecho da URL
    # expect(page).to have_current_path('/dashboard')

    # Utilizando o comando do RSPEC para busca por um objeto CSS na página fim.
    expect(page).to have_css ".dashboard"

    # O sleep deve ser retirado no final, pois só é usado para dar uma noção na etapa de desenv
    # sleep 5
end

#Step compartilhado entre os arquivos cadastro e login, pois utilizam a mesma regra
Então('vejo a mensagem de alerta: "{string}"') do |expected_alert|
    # alert = find(".alert-dark")
    # expect(alert.text).to eql expected_alert

    # expect(page).to have_content (expected_alert)

    # alert = find(".alert-dark")
    
    if (find(".alert-dark"))
        expect(find(".alert-dark").text).to eql expected_alert
        # expect(alert.text).to eql expected_alert
    elsif(find(".alert-error"))

        expect(find(".alert-errork").text).to eql expected_alert
        # alert2 = find(".alert-error")
        # expect(alert2.text).to eql expected_alert
    end
end