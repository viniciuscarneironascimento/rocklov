require "httparty"

# O rspec puro não sabe consumir uma API, então vamos baixar outra gem "httparty"
# O HTTParty é uma gem utilizada para realizar requisições de verbos HTTP (Post, Get, Put e Delete) de forma simples em web services.
describe "POST/sessions" do

  #   # Cada "IT" deve validar um expect. Para melhorar o código, podemos fazer um "contexto" e fazer as chamadas do login
  #   it "login com sucesso" do

  #     # Monto o payload em uma variável
  #     payload = { email: "betao@yahoo.com.br", password: "12345" }

  #     # Realizanao POST: passa a URL, o corpo o payload no formato JSON e o cabeçalho
  #     result = HTTParty.post(
  #       "http://rocklov-api:3333/sessions",
  #       body: payload.to_json,
  #       headers: {
  #         "Content-Type": "application/json",
  #       },
  #     )

  #     # Validando o status code
  #     expect(result.code).to eql 200
  #     expect(result.parsed_response["_id"].length).to eql 24

  #     # # Verificando o retorno que é exibido no Preview do isomnia
  #     # puts result
  #     # # Verificando o retorno que é exibido no Preview do isomnia e transformando em um objeto HASH reconhecidso pelo Ruby
  #     # puts result.parsed_response
  #     # puts result.parsed_response.class

  #   end

  # Cada "IT" deve validar um expect. Para melhorar o código, podemos fazer um "contexto" e fazer as chamadas do login
  context "login com sucesso" do

    # Before é um gancho para implementar a "PRÉ-CONDIÇÃO" do meu contexto
    before (:all) do
      # Monto o payload em uma variável
      payload = { email: "betao@yahoo.com.br", password: "12345" }

      # Realizanao POST: passa a URL, o corpo o payload no formato JSON e o cabeçalho
      @result = HTTParty.post(
        "http://rocklov-api:3333/sessions",
        body: payload.to_json,
        headers: {
          "Content-Type": "application/json",
        },
      )
    end

    # Cada "IT" abaixo é um teste independente
    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuário" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end
end
