require "httparty"

# A pasta "routes" foi criada para guardar as rotas assim como fazemos com PageObject

class Sessions
  include HTTParty

  # Inclusão da linha abaixo que é uma propiedade do HTTParty que recebe a URL da API. Desta forma, a rota "http://rocklov-api:3333/sessions" utilizada no post linha 20 será substituída apenas poe "/sessions"
  base_uri "http://rocklov-api:3333"

  def login(email, pass)
    # Monto o payload em uma variável
    payload = { email: email, password: pass }

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
