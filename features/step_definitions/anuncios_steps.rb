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

   
    find("#thumbnail").set @anuncio[:thumb]
    # sleep 3
    # click_button "Cadastrar"
    # find('.btn-success').click
    sleep 3
       
end                                                                               
                                                                                    
Então('devo ver este item no meu Dashboard') do                                   
    pending # Write code here that turns the phrase above into concrete actions     
end                                                                               