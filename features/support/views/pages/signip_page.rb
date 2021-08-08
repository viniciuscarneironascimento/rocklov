

class SignupPage
include Capybara::DSL

    def open
        visit "/signup"
    end

    # Este método recebe um objeto lista inteiro e é desmembrado dentro do método
    def create(user) 
        MongoDB.new.remove_user(user[:email])
        find("#fullName").set user[:nome]
        find("#email").set user[:email]
        find("#password").set user[:senha]
        click_button "Cadastrar"
    end
end