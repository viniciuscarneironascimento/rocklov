require_relative "base_api"

# A pasta "routes" foi criada para guardar as rotas assim como fazemos com PageObject

class Signup < BaseApi
  # include HTTParty

  # # Inclusão da linha abaixo que é uma propiedade do HTTParty que recebe a URL da API. Desta forma, a rota "http://rocklov-api:3333/sessions" utilizada no post linha 20 será substituída apenas poe "/signup"
  # base_uri "http://rocklov-api:3333"

    # As linhas acima serão comentadas e implementadas no novo arquivo "BASE_API.RB". A classe irá herdar desta nova classe ficando assim "class Sessions < BaseApi"

  # O meétodo abaixo fará o POST do payload na rota "/signup":
  def create(payload)
    # Realizanao POST: passa a URL, o corpo o payload no formato JSON e o cabeçalho
    return self.class.post(
             "/signup",
             body: payload.to_json,
             headers: {
               "Content-Type": "application/json",
             },
           )
  end
end
