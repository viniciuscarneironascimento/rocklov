# require "httparty"
# require_relative "routes/sessions"

# O rspec puro não sabe consumir uma API, então vamos baixar outra gem "httparty"
# O HTTParty é uma gem utilizada para realizar requisições de verbos HTTP (Post, Get, Put e Delete) de forma simples em web services.
describe "POST /sessions" do

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

  #   --------------------------------------------------------------------------------------------------
  # Cada "IT" deve validar um expect. Para melhorar o código, podemos fazer um "contexto" e fazer as chamadas do login
  context "login com sucesso" do

    # Before é um gancho para implementar a "PRÉ-CONDIÇÃO" do meu contexto
    before (:all) do

      # Vou comentar o código abaixo e copiá-lo para o método login na classe

      # # Este trecho será comentado para implementá-lo no arquivo "sessions.rb"
      # # Monto o payload em uma variável
      #   payload = { email: "betao@yahoo.com.br", password: "12345" }

      #   # Realizanao POST: passa a URL, o corpo o payload no formato JSON e o cabeçalho
      #   @result = HTTParty.post(
      #     "http://rocklov-api:3333/sessions",
      #     body: payload.to_json,
      #     headers: {
      #       "Content-Type": "application/json",
      #     },
      #   )
      #    # Este trecho será comentado para implementá-lo no arquivo "sessions.rb"

      # OBSERVAÇÃO: foi incluído no topo do código "require_relative "routes/sessions", ou seja, para fazer a chamada da classe "Sessions".
      # O BEFORE vai ficar agora assim:
      #   @result = Sessions.new.login("betao@yahoo.com.br", "12345")

      # Com a implementação da linha abaixo, a linha acima será comentada
      payload = { email: "betao@yahoo.com.br", password: "12345" }

      # Com a implementação da linha acima, a linha abaixo ficará:
      @result = Sessions.new.login(payload)
    end
    # --------------------------------------------------------------------------------------------------
    # Cada "IT" abaixo é um teste independente
    # Neste eu valido o status code
    it "valida status code" do
      expect(@result.code).to eql 200
    end

    # Neste eu valido o ID do usuário logado, ou seja, o valor apresentado no Preview do Isomnia
    it "valida id do usuário" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end
  # --------------------------------------------------------------------------------------------------

  # Copiando todo o contexto acima para criar novo teste. Neste cenário coloco senha inválida
  #   context "senha invalida" do
  #     before (:all) do
  #       # A linha abaixo será substituída pelas linhasa seguir:
  #       #   @result = Sessions.new.login("betao@yahoo.com.br", "errada1234")
  #       payload = { email: "betao@yahoo.com.br", password: "errada1234" }
  #       @result = Sessions.new.login(payload)
  #     end

  #     it "valida status code" do
  #       expect(@result.code).to eql 401
  #     end

  #     it "valida mensagem" do
  #       expect(@result.parsed_response["error"]).to eql "Unauthorized"
  #     end
  #   end

  # Copiando todo o contexto acima para criar novo teste. Neste cenário coloco senha inválida
  #   context "usuario nao existe" do
  #     before (:all) do
  #       # A linha abaixo será substituída pelas linhasa seguir:
  #       #   @result = Sessions.new.login("betao@yahoo.com.br", "errada1234")
  #       payload = { email: "404@yahoo.com.br", password: "errada1234" }
  #       @result = Sessions.new.login(payload)
  #     end

  #     it "valida status code" do
  #       expect(@result.code).to eql 401
  #     end

  #     it "valida mensagem" do
  #       expect(@result.parsed_response["error"]).to eql "Unauthorized"
  #     end
  #   end
  #   --------------------------------------------------------------------------------------------------
  # Nova implementação otimizando o código e substituindo os CONTEXTOS
  # Criamos um ARRAY de HASH contendo os possíveis cenários de teste
  examples = [
    {
      title: "senha incorreta",
      payload: { email: "betao@yahoo.com.br", password: "errada1234" },
      code: 401,
      error: "Unauthorized",
    },
    {
      title: "usuario nao existe",
      payload: { email: "404@yahoo.com.br", password: "errada1234" },
      code: 401,
      error: "Unauthorized",
    },
    {
      title: "email em branco",
      payload: { email: "", password: "12345" },
      code: 412,
      error: "required email",
    },
    {
      title: "sem campo email",
      payload: { password: "12345" },
      code: 412,
      error: "required email",
    },
    {
      title: "senha em branco",
      payload: { email: "betao@yahoo.com.br", password: "" },
      code: 412,
      error: "required password",
    },
    {
      title: "sem campo senha",
      payload: { email: "betao@yahoo.com.br" },
      code: 412,
      error: "required password",
    },
  ]

  # Como a variável "examples" é um ARRAY, farei um "for each" para percorrer cada elemento
  # O argumento "e" é o índice do array
  examples.each do |e|
    context "#{e[:title]}" do
      before (:all) do
        # A linha abaixo será substituída pelas linhasa seguir:
        #   @result = Sessions.new.login("betao@yahoo.com.br", "errada1234")
        @result = Sessions.new.login(e[:payload])
      end

      it "valida status code #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end

      it "valida mensagem" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end
end
