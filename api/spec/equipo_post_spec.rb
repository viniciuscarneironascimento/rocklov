# os require_relative abaixo serão comentados e colocados em um único arquivo, o "spec_helper.rb"
# require_relative "routes/sessions"
# require_relative "routes/equipos"
# require "spec_helper"

# Monta-se toda estqa estrutura e precisa fazer o envio destas informações para a API
describe "POST /equipos" do

  # É necessário fazer outro before referente a rota session, ou seja, deve haver um login antes de cadastrar o equipamento
  before(:all) do
    # Crio um payload para logar na rota session
    payload = { email: "to@mate.com", password: "12345" }

    # Faço a chamado da classe Sessions para realizar o login que é PRÉ-CONDIÇÃO para o cadastro abaixo.
    # Este retorno vai me fornecer o "ID" do usuário onde poderia usar no HEADRS do before seguinte.
    # result = Sessions.new.login(payload)
    result = Sessions.new.login(payload)
    # Desta forma o método "create" da classe "Equipos" passará a receber també o "ID" como parâmetro
    @user_id = result.parsed_response["_id"]
  end

  context "novo equipo" do
    before(:all) do

      # O outro erro foi no "Form Data" que retornou "thumbnail: (binary)", sendo que passamos string conforme a documentação que não estava atualizada. A linha abaixo será implementada:

      # **** basta acrecentar o argumento "rb" no final para corrrigir erro de exibição da imagem
      thumbnail = File.open(File.join(Dir.pwd, "spec/fixtures/images", "kramer.jpg"), "rb")

      # A linha " thumbnail: "kramer.jpg" será substituída por "thumbnail: thumbnail,"

      payload = {
        thumbnail: thumbnail,
        name: "Karmer Eddie Van Hallen",
        category: "Cordas",
        price: 299,
      }
      # puts thumbnail.class
      # puts thumbnail

      # Necessário ajustar a classe MongoDB
      MongoDB.new.remove_equipo(payload[:name], @user_id)

      # O método abaixo passou a receber um novo argumento, o "user_id" para identificar o usuário logado ao qual irei cadastrar o equipamento
      @result = Equipos.new.create(payload, @user_id)
      # puts @result
    end

    # De acordo com a documentação da API, o código de sucesso deveria ser "200", porém ao executar o rspec no terminal, o sistema apresentou código "412". Vamos colocar um "puts @result" dentro do before para ver o que retorna. Retornou esta mensagem "{"error":"Error Data :(","stacktrace":{}}". Para identificar este erro é necessário realizar teste manual com auxílio do inspetor do Chrome
    # Ao verificar no inspetor, foram identificados que os tipos de requisição do cabeçalho "Request Headers" não é do tipo JSON, é do tipo "Content-Type: multipart/form-data;". O outro erro foi no "Form Data" que retornou "thumbnail: (binary)", sendo que passamos string.
    it "deve retornar 200" do
      expect(@result.code).to eql 200
    end
  end

  context "nao autorizado" do
    before(:all) do

      # **** basta acrecentar o argumento "rb" no final para corrrigir erro de exibição da imagem
      thumbnail = File.open(File.join(Dir.pwd, "spec/fixtures/images", "baixo2.jpg"), "rb")

      payload = {
        thumbnail: thumbnail,
        name: "Contra Baixo",
        category: "Cordas",
        price: 59,
      }
      @result = Equipos.new.create(payload, nil)
      # puts @result
    end

    it "deve retornar 401" do
      expect(@result.code).to eql 401
    end
  end
end
