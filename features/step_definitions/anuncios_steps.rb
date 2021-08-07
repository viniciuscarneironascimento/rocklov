# Criando o step "Dado" seguido dos "e" para dar acesso a tela de cadastro. Os "E" são criados como "DADO".
Dado('que estou logado como {string} e {string}') do |email, password|
  visit "/"
  find("input[placeholder='Seu e-email']").set email
  find("input[type=password").set password

  # Outras formas de localizar um botão. Se buscar pelo parâmetro "CSS" basta colocar um ponto"." antes da descrição Exemplo:
  find('.btn-primary').click
  # find('button.btn-primary').click

  # Abaixo o modo tradicional de click no botão:
  # click_button "Entrar"
end
 
Dado('que acesso o formulário de cadastro de anúncios') do
  # Outras formas de localizar um botão. Se buscar pelo parâmetro "CSS" basta colocar um ponto"." antes da descrição Exemplo:
  find('.btn-primary').click
  # click_button " Criar anúncio"

  # Criar um checkpoint para garantir que fui redirecionado para a página correta
  # expect(page).to have_css "#equipoForm"

  # Outra opção seria
  expect(page).to have_current_path('/equipos')
end

Dado('que eu tenho os seguintes equipamentos:') do |table|                        
  @anuncio = table.rows_hash   

# Este é o ponto onde devo adicionar a exclusão do equipamento do banco, pois dessa forma o meu teste ficará sempre válido, ele sempre vai passar porque antes de submeter o cadastro ele sempre vai garantir que a massa de teste é válida e não vai deixar repetir.
MongoDB.new.remove_equipo(@anuncio[:nome])

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
  find("input[placeholder$=equipamento]").set @anuncio[:nome]
   
  # O campo abaixo não é um "input", é um combo do tipo "SELECT", portando os dados serão informados de outra forma. Primeiro usa um "find" para buscar o elemento "select" (combo), depois usa outro "find" para buscar o elemento filho "option". Porfim, adiciona a seleção do item do combo com ".select_option"
  find("#category").find('option', text: @anuncio[:categoria]).select_option

  # Usarei a primeira palavra da descrição, SEM aspas simples e usando '^' circunflexo: 
  #      "input[placeholder^=Valor]"
  # A forma mais simples seria pelo ID:   find("#price").set @anuncio[:preco]
  find("input[placeholder^=Valor]").set @anuncio[:preco]

  #  Primeiramente temos que identificar o caminho da imagem na pasta local usando "Dir.pwd" e concatena com o caminho das pastas onde a imagem está, por fim concatena com o parâmetro que é o nome do produto.
  thumb = Dir.pwd + "/features/support/fixtures/images/" + @anuncio[:thumb]

  # Log para ver o conteúdo retornado
  # log thumb

  # Depois localizar o elemento na tela e associar. Mas deu ERRO!!!!!
  # O capybara não identificou o elemento pois está com propriedade CSS "display = none"
  # find("#thumbnail input[type=file]").set thumb
  # Neste caso, adicionamos mais uma informação na linha abaixo ficando assim:
  find("#thumbnail input[type=file]", visible: false).set thumb
    
  click_button "Cadastrar"
  # find('.btn-success').click
end                                                                               
                                                                                    
Então('devo ver este item no meu Dashboard') do                                   
  # Busca a lista de equipamentos cadastrados
  anuncios = find(".equipo-list")

  # Espero que / na lista de anúncios / contenha / o equipamento de nome X
  expect(anuncios).to have_content @anuncio[:nome]

  # Validando outros elemntos na tela
  expect(anuncios).to have_content   "R$"+@anuncio[:preco]+"/dia"
end                                                                               