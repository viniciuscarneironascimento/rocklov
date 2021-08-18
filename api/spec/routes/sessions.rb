# require_relative "base_api"

# A pasta "routes" foi criada para guardar as rotas assim como fazemos com PageObject

class Sessions < BaseApi
  # include HTTParty

  # # Inclusão da linha abaixo que é uma propiedade do HTTParty que recebe a URL da API. Desta forma, a rota "http://rocklov-api:3333/sessions" utilizada no post linha 20 será substituída apenas poe "/sessions"
  # base_uri "http://rocklov-api:3333"

  # As linhas acima serão comentadas e implementadas no novo arquivo "BASE_API.RB". A classe irá herdar desta nova classe ficando assim "class Sessions < BaseApi"



  # O meétodo abaixo será refatorado e receberá um objeto "payload" inteiro, ou seja, de "def login(email, pass)" para:
  #   def login(email, pass)
  def login(payload)
    # Monto o payload em uma variável.
    # Devido a alteração na passagem de parâmetro do metódo acima,, a linha abaixo passará a ser usada no script de teste, ou seja, no arquivo "post_session_spec.rb"
    # payload = { email: email, password: pass }

    # Realizanao POST: passa a URL, o corpo o payload no formato JSON e o cabeçalho
    #   @result = HTTParty.post(
    # A alinha acima será substituída pela linha abaixo, ou seja, o trecho "HTTParty" será substituído por "self.class" para ter acesso aos objetos da prória classe

    return self.class.post(
             "/sessions",
             body: payload.to_json,
             headers: {
               "Content-Type": "application/json",
             },
           )
  end
end
