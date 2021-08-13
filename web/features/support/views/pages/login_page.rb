# Aqui será criada uma Classe que representará a Página de LOGIN, seuw campos, elementos, ações de click em botões etc.
class LoginPage

  # Esta classe não consegue ter acesso aos recursos do CAPYBARA eo Cucumber não sabe que dentro desta classe o Capybara precisa funcionar. Então iremos implementar a linha abaixo:
  # Este recurso de parece com heranaça, ou seja, estamos falando para o Ruby que a classe LoginPage deve conhecer todos os recursos do Capybara
  include Capybara::DSL

  def open
    visit "/"
  end

  # TODOS os métodos abaixo serão resumidos apenas ao método "WITH":
  # def campo_email
  #     return find("input[placeholder='Seu email']")
  # end

  # def campo_nome
  #     return find("input[type=password")
  # end

  # def botao_entrar
  #     click_button "Entrar"
  # end

  # TODOS os métodos acima serão resumidos apenas ao método abaixo:
  def with(email, password)
    find("input[placeholder='Seu email']").set email
    find("input[type=password").set password
    click_button "Entrar"
  end
end
