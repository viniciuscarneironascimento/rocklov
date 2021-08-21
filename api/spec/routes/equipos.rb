require_relative "base_api"

# A pasta "routes" foi criada para guardar as rotas assim como fazemos com PageObject

class Equipos < BaseApi
  # include HTTParty

  # # Inclusão da linha abaixo que é uma propiedade do HTTParty que recebe a URL da API. Desta forma, a rota "http://rocklov-api:3333/sessions" utilizada no post linha 20 será substituída apenas poe "/signup"
  # base_uri "http://rocklov-api:3333"

  # As linhas acima serão comentadas e implementadas no novo arquivo "BASE_API.RB". A classe irá herdar desta nova classe ficando assim "class Sessions < BaseApi"

  # O meétodo abaixo fará o POST do payload na rota "/signup":
  # Incluí o parâmetro "User_id" para identificar o usuário . Então a linha do headrs ficou assim: " headers: "user_id": user_id".
  def create(payload, user_id)
    # Realizanao POST: passa a URL, o corpo o payload no formato JSON e o cabeçalho

    # 1- Ao verificar no inspetor, foram identificados que os tipos de requisição do cabeçalho "Request Headers" não é do tipo JSON, é do tipo "Content-Type: multipart/form-data;". Então a linha " body: payload.to_json," será substituída por "body: payload,"

    # 2- O outro erro foi no "Form Data" que retornou "thumbnail: (binary)", sendo que passamos string conforme a documentação que não estava atualizada. Farei o ajuste no arquivo "post_equipo_spec.rb"
    return self.class.post(
             "/equipos",
             body: payload,
             headers: {
               "user_id": user_id,
             },
           )
  end
end
