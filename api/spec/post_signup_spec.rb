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
end
