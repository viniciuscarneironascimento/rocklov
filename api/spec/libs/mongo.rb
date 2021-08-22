require "mongo"

# Aqui estarei criando uma configuração para armazenar os logs gerados na execução do cucumber devido ao acesso ao banco de dados. Desta forma, a execução do Cucumber pelo prompt ficará mais limpa e os logs serão armazenados neste arquivo "mongo.log"
Mongo::Logger.logger = Logger.new("./logs/mongo.log")

# A criação desta classe permite chamá-la em qualquer parte do código, basta instanciá-la
class MongoDB
  # Aplicando os conceitos de OO, definindo as propriedades "attr_accessor"
  # Vamos definir as propriedades do banco, ou seja, definir as coleções(tabelas)
  attr_accessor :users, :equipos

  def initialize
    # vou copiar a inicialização com o banco de dados, recortar dos métodos abaixo e colar no meu inicializador, pois trata-se de uma ação padrão. # Este endereço será substituído pela CONSTANTE
    # client = Mongo::Client.new("mongodb://rocklov-db:27017/rocklov")
    # Dentro do colchetes eu coloco o campo que eu quero carregar que foi criado no arquivo "local.yml ou hml.yml"
    client = Mongo::Client.new("mongodb://rocklov-db:27017/rocklov")

    # Farei o mesmo com as variáveis usadas nos métodos que eram "users = client[:users]" e passarão a ser "@users = client[:users]" com "@" no início para ser global
    @users = client[:users]

    # Farei o mesmo com as variáveis usadas nos métodos que eram "  equipos = client[:equipos]" e passarão a ser "@  equipos = client[:equipos]" com "@" no início para ser global
    @equipos = client[:equipos]
  end

  def remove_user(email)
    # a linha abaixo acessa todo o banco de dados. A linha abaixo será comentada pois foi adicionada no inicilaizador da classe
    # client = Mongo::Client.new('mongodb://rocklov-db:27017/rocklov')

    # a linha abaixo acessa a tabela "users". Comentando a linha abaixo pois foi incluída na initialize dda classe
    # users = client[:users]

    @users.delete_many({ email: email })
  end

  def get_user(email)
    # a linha abaixo acessa todo o banco de dados. A linha abaixo será comentada pois foi adicionada no inicilaizador da classe
    # client = Mongo::Client.new('mongodb://rocklov-db:27017/rocklov')

    # a linha abaixo grava na variável "users" os dados da tabela "users" do banco de dados.
    # Comentando a linha abaixo pois foi incluída na initialize dda classe
    # users = client[:users]

    # Obter o "ID" do usuário que possui o "e-mail" passado por parâmetro
    user_id = @users.find({ email: email }).first
    # Abaixo print no promp o ID do usuário que quero manipular, ou seja, aquele que possui o "email" passado por parâmetro
    return user_id[:_id]
  end

  # Ajustando este método para apagar APENAS o equipamento de um determinado USUÁRIO, SENÃO IRIA APAGAR TODOS OS EQUIPAMENTOS DE OUTROS CADASTROS. Para isto será necessário criar outro método para identificar o usuário.
  def remove_equipo(name, user_id)

    # No banco de dados o ID do usuário é do tipo "ObjectID", desta forma eu pego o user_id que está com o valor correto e converto para um tipo que o banco de dados aceita.
    obj_id = BSON::ObjectId.from_string(user_id)
    @equipos.delete_many(name: name, user: obj_id)
  end
end

# Usanremos a linha abaixo provisioriamente para ver no prompt de comando qual o resultado que está retornando do banco de dados. Usar no prompt a chamada "ruby features\support\libs\mongo.rb"
# MongoDB.new.get_user("contato.vinicius@gmail.com")
