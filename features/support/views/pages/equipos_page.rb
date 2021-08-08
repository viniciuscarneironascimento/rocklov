class EquiposPage
  include Capybara::DSL

  def create(equipo)
    # A primeira validação é saber se estou no formulário de Equipamentos, ou seja, no "expect(page).to have_css "#equipoForm". porém É PROIBIDO COLOCAR "expect" dentro da classe.
    # A estratégia é validar se o Capybara encontra o elemento na tela. Um método que possui "?" interrogação retorna verdadeiro ou falso.
    # Timeout com checkpoint explícito
    page.has_css?("#equipoForm")

    # As linhas logo abaixo serão comentadas, pois utilizarei ENCAPSULAMENTO, ou seja, criarei um método aqui na própria classe e farei a chamada aqui dentro para representar estes comandos:
    # thumb = Dir.pwd + "/features/support/fixtures/images/" + equipo[:thumb]
    # find("#thumbnail input[type=file]", visible: false).set thumb
    # Só chama esta opção se houver foto selecionada, ou seja, se houver texto do caminho da foto selecionada
    upload(equipo[:thumb]) if equipo[:thumb].length > 0

    find("input[placeholder$=equipamento]").set equipo[:nome]

    # A linha abaixo será substituída pela chamado do método interno "select_cat", pois não existe uma categoria em "branco". Só chama esta opção se houver valores no combo "Categoria"
    # find("#category").find('option', text: equipo[:categoria]).select_option
    select_cat(equipo[:categoria]) if equipo[:categoria].length > 0

    find("input[placeholder^=Valor]").set equipo[:preco]

    click_button "Cadastrar"
  end

  # Método criado pois não existe uma categoria em "branco" e deverá ser validada acima
  def select_cat(categoria)
    find("#category").find("option", text: categoria).select_option
  end

  def upload(file_name)
    thumb = Dir.pwd + "/features/support/fixtures/images/" + file_name
    find("#thumbnail input[type=file]", visible: false).set thumb
  end
end
