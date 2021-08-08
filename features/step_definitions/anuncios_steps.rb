# Criando o step "Dado" seguido dos "e" para dar acesso a tela de cadastro. Os "E" são criados como "DADO".
Dado('que estou logado como {string} e {string}') do |email, password|
  # Crio a linha abaixo para guardar o e-mail em uma variável global
  @email = email

  # Para visitar a página principal basta usar a alinha abaixo, pois a URL padrão já foi definida no arquivo env.rb
  # visit "/"

  # find("input[placeholder='Seu email']").set email
  # find("input[type=password").set password

  # Outras formas de localizar um botão. Se buscar pelo parâmetro "CSS" basta colocar um ponto"." antes da descrição Exemplo:
  # find('.btn-primary').click
  # find('button.btn-primary').click

  # Abaixo o modo tradicional de click no botão:
  # click_button "Entrar"


  # Usando PAGE OBJECT a partir daqui. Todo o código anterior deve ser comentado.
   # A instância criada abaixo será substituída pelo GANCHO ou HOOKS e criada uma variável global
  # login_page = LoginPage.new

  @login_page.open
  # login_page.campo_email.set email
  # login_page.campo_nome.set password
  # login_page.botao_entrar

  # Melhorando ainda mais o PageObject, farei a chamada abaixo que reduz as linhas de código. O método do PageObject já realiza todas estas ações de "set" e "click"
  @login_page.with(email, password)
end
 
Dado('que acesso o formulário de cadastro de anúncios') do
  # Outras formas de localizar um botão. Se buscar pelo parâmetro "CSS" basta colocar um ponto"." antes da descrição Exemplo:
  # find('.btn-primary').click
  
  # Com o PageObject da tela DASHBOARD a linha abaixo será substituída pela chamada da classe que executa o método que leva para a tela de cadastro formulário de equipamentos.
  # click_button "Criar anúncio"
  @dash_page.goto_equipo_form


  # Criar um checkpoint para garantir que fui redirecionado para a página correta
  # Com o PageObject a linha abaixo será comentada pois a validação da tela Equipo deverá ser feita na classe PageObject EQUIPOPAGE, ou seja, antes de preencher o formulário com um novo equipamento o Ruby irá validar se está na tela Equipo.
  # expect(page).to have_css "#equipoForm"
  


  # Outra opção para garantir que fui redirecionado para a página correta
  # expect(page).to have_current_path('/equipos')
end

Dado('que eu tenho os seguintes equipamentos:') do |table|                        
  # O código abaixo é feito para obter as linhas de uma tabela
  @anuncio = table.rows_hash   

# Este é o ponto onde devo adicionar a exclusão do equipamento do banco, pois dessa forma o meu teste ficará sempre válido, ele sempre vai passar porque antes de submeter o cadastro ele sempre vai garantir que a massa de teste é válida e não vai deixar repetir.
# A linha abaixo apaga do banco qualquer equipamento com o email logado passado por parâmetros. Desta forma, ao submeter o cadastro no "Quando" a seguir não haverá duplicidade de dados.
MongoDB.new.remove_equipo(@anuncio[:nome], @email)

end                                                                               


Quando('submeto o cadastro deste item') do    
    
  #1ª Forma de localizar um elemento pelo "id" 
  # find("#name").set @anuncio[:nome]

  # Outras formas de encontrar o mesmo elemento
  # Usando descrição dentro de aspas simples: 
  #    "input[placeholder='Descreva o seu equipamento']"
  # Usando última palavra da descrição, SEM aspas simples e usando '$' cifrão:
  #     "input[placeholder$=equipamento]"
  # Usando qualquer palavra da descrição, SEM aspas simples e usando '*' asterisco: 
  #     "input[placeholder*=equipamento]"
  # Usando primeira palavra da descrição, SEM aspas simples e usando '^' circunflexo: 
  #      "input[placeholder^=Descreva]"
  # find("input[placeholder$=equipamento]").set @anuncio[:nome]
   
  # O campo abaixo não é um "input", é um combo do tipo "SELECT", portando os dados serão informados de outra forma. Primeiro usa um "find" para buscar o elemento "select" (combo), depois usa outro "find" para buscar o elemento filho "option". Porfim, adiciona a seleção do item do combo com ".select_option"
  # find("#category").find('option', text: @anuncio[:categoria]).select_option

  # Usarei a primeira palavra da descrição, SEM aspas simples e usando '^' circunflexo: 
  #      "input[placeholder^=Valor]"
  # A forma mais simples seria pelo ID:   find("#price").set @anuncio[:preco]
  # find("input[placeholder^=Valor]").set @anuncio[:preco]

  #  Primeiramente temos que identificar o caminho da imagem na pasta local usando "Dir.pwd" e concatena com o caminho das pastas onde a imagem está, por fim concatena com o parâmetro que é o nome do produto.
  # thumb = Dir.pwd + "/features/support/fixtures/images/" + @anuncio[:thumb]

  # Log para ver o conteúdo retornado
  # log thumb

  # Depois localizar o elemento na tela e associar. Mas deu ERRO!!!!!
  # O capybara não identificou o elemento pois está com propriedade CSS "display = none"
  # find("#thumbnail input[type=file]").set thumb
  # Neste caso, adicionamos mais uma informação na linha abaixo ficando assim:
  # find("#thumbnail input[type=file]", visible: false).set thumb
    
  # click_button "Cadastrar"
  # find('.btn-success').click


  # Com o PageObject todo o preenchimento da tela e click do botão (linhas acima 77,80,85,88,97,99) passam para a classe EquiposPage.
 
  @equipos_page.create(@anuncio)


end                                                                               
                                                                                    
Então('devo ver este item no meu Dashboard') do                                   
  # Busca a lista de equipamentos cadastrados
  # anuncios = find(".equipo-list")

  # Espero que / na lista de anúncios / contenha / o equipamento de nome X
  # expect(anuncios).to have_content @anuncio[:nome]
  # Com o PageObject implementado, comentar a linha acima
  expect(@dash_page.equipo_list).to have_content @anuncio[:nome]


  # Validando outros elemntos na tela
  # expect(anuncios).to have_content   "R$"+@anuncio[:preco]+"/dia"
  # Com o PageObject implementado, comentar a linha acima
  expect(@dash_page.equipo_list).to have_content   "R$"+@anuncio[:preco]+"/dia"
end                                                                               