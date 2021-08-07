require 'mongo'

# Aqui estarei criando uma configuração para armazenar os logs gerados na execução do cucumber devido ao acesso ao banco de dados. Desta forma, a execução do Cucumber pelo prompt ficará mais limpa e os logs serão armazenados neste arquivo "mongo.log"
Mongo::Logger.logger = Logger.new("./logs/mongo.log")


# A criação desta classe permite chamá-la em qualquer parte do código, basta instanciá-la
class MongoDB

    def remove_user(email)
        # a linha abaixo acessa todo o banco de dados
        client = Mongo::Client.new('mongodb://rocklov-db:27017/rocklov')
        # a linha abaixo acessa a tabela "users"
        users = client[:users]
        users.delete_many({email: email})
    end

    def get_user(email)
        # a linha abaixo acessa todo o banco de dados
        client = Mongo::Client.new('mongodb://rocklov-db:27017/rocklov')
        # a linha abaixo grava na variável "users" os dados da tabela "users" do banco de dados.
        users = client[:users]
        # Obter o "ID" do usuário que possui o "e-mail" passado por parâmetro
        user_id = users.find({email: email}).first
        # Abaixo print no promp o ID do usuário que quero manipular, ou seja, aquele que possui o "email" passado por parâmetro
        return user_id[:_id]
    end

    # Ajustando este método para apagar APENAS o equipamento de um determinado USUÁRIO, SENÃO IRIA APAGAR TODOS OS EQUIPAMENTOS DE OUTROS CADASTROS. Para isto será necessário criar outro método para identificar o usuário.
    def remove_equipo(name, email)
        # Irei chamar o método criado acima "get_user" para obter o ID do usuário, guardo em uma variável.
        user_id = get_user(email)

        client = Mongo::Client.new('mongodb://rocklov-db:27017/rocklov')
        # a linha abaixo acessa a tabela "equipos"
        equipos = client[:equipos]
        equipos.delete_many(name: name, user: user_id) 
    end
end

# Usanremos a linha abaixo provisioriamente para ver no prompt de comando qual o resultado que está retornando do banco de dados. Usar no prompt a chamada "ruby features\support\libs\mongo.rb"
# MongoDB.new.get_user("contato.vinicius@gmail.com")