require 'mongo'

# Aqui estarei criando uma configuração para armazenar os logs gerados na execução do cucumber devido ao acesso ao banco de dados. Desta forma, a execução do Cucumber pelo prompt ficará mais limpa e os logs serão armazenados neste arquivo "mongo.log"
Mongo::Logger.logger = Logger.new("./logs/mongo.log")


# A criação desta classe permite chamá-la em qualquer parte do código, basta instanciá-la
class MongoDB

    def remove_user(email)
    client = Mongo::Client.new('mongodb://rocklov-db:27017/rocklov')
    users = client[:users]
    users.delete_many({email: email})
    end
end