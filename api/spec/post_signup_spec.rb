require_relative "routes/signup"
require_relative "libs/mongo"

describe "POST /signup" do
  context "novo usuario" do
    before (:all) do
      payload = { name: "Pitty", email: "pitty2@gmail.com", password: "12345" }
      MongoDB.new.remove_user(payload[:email])
      @result = Signup.new.create(payload)
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida mensagem" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end

    # it "valida status code #{e[:code]}" do
    #     expect(@result.code).to eql e[:code]
    #   end

    # it "valida mensagem" do
    #     expect(@result.parsed_response["error"]).to eql e[:error]
    # end

  end

  context "usuario ja existe" do
    before(:all) do

      # DADO que eu tenha um novo usuário
      payload = { name: "João da Silva", email: "joao@ig.com", password: "12345" }
      MongoDB.new.remove_user(payload[:email])

      # E o email desse usuario ja foi cadastrado no sistema
      # Chama a Classe Signup para criar um novo registro com os dados do payload acima
      Signup.new.create(payload)

      # QUANDO faço uma requisição para a rota /signup
      # Depois executa novamente a mesma linha acima, sendo que o sistema vai ucusar o erro e retornar o código que eu espero: 409
      @result = Signup.new.create(payload)
    end
    it "deve retornar 409" do
      # ENTAO deve retornar 409
      expect(@result.code).to eql 409
    end
    it "valida mensagem" do
      expect(@result.parsed_response["error"]).to eql "Email already exists :("
    end

    # DESAFIO: implementar os cenários nome, email e senha obrigatórios

    context "nome e obrigatorio" do
      before(:all) do
        payload = { name: "", email: "nome@ig.com", password: "12345" }
        @result = Signup.new.create(payload)
      end
      it "deve retornar 412" do
        # ENTAO deve retornar 409
        expect(@result.code).to eql 412
      end
      it "valida mensagem" do
        expect(@result.parsed_response["error"]).to eql "required name"
      end
    end

    context "email e obrigatorio" do
      before(:all) do
        payload = { name: "João da Silva", email: "", password: "12345" }
        @result = Signup.new.create(payload)
      end
      it "deve retornar 412" do
        # ENTAO deve retornar 409
        expect(@result.code).to eql 412
      end
      it "valida mensagem" do
        expect(@result.parsed_response["error"]).to eql "required email"
      end
    end

    context "senha e obrigatoria" do
      before(:all) do
        payload = { name: "João da Silva", email: "nome@ig.com.br", password: "" }
        @result = Signup.new.create(payload)
      end
      it "deve retornar 412" do
        # ENTAO deve retornar 409
        expect(@result.code).to eql 412
      end
      it "valida mensagem" do
        expect(@result.parsed_response["error"]).to eql "required password"
      end
    end
  end
end
