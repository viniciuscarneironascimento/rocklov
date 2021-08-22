describe "GET /equipos/{equipo_id}" do
  context "obter unico equipo" do
    before(:all) do
      # Crio um payload para logar na rota session
      payload = { email: "to@mate.com", password: "12345" }
      result = Sessions.new.login(payload)
      @user_id = result.parsed_response["_id"]
    end

    before(:all) do
      # DADO que eu tenho um novo equipamento
      thumbnail = File.open(File.join(Dir.pwd, "spec/fixtures/images", "sanfona.jpg"), "rb")
      payload = {
        thumbnail: thumbnail,
        name: "Sanfona",
        category: "Outros",
        price: 499,
      }

      MongoDB.new.remove_equipo(payload[:name], @user_id)
      equipo = Equipos.new.create(payload, @user_id)
      @equipo_id = equipo.parsed_response["_id"]

      # QUANDO faço uma requisição GET por ID
      @result = Equipos.new.find_by_id(@equipo_id, @user_id)
    end

    it "deve retornar 200" do
      expect(@result.code).to eql 200
    end
  end
end
