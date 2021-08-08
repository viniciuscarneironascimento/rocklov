


class EquiposPage
    include Capybara::DSL
    
    def create(equipo)
        # A primeira validação é saber se estou no formulário de Equipamentos, ou seja, no "expect(page).to have_css "#equipoForm". porém É PROIBIDO COLOCAR "expect" dentro da classe.
        # A estratégia é validar se o Capybara encontra o elemento na tela. Um método que possui "?" interrogação retorna verdadeiro ou falso.
        # Timeout com checkpoint explícito
        page.has_css?("#equipoForm")


        find("input[placeholder$=equipamento]").set equipo[:nome]
        find("#category").find('option', text: equipo[:categoria]).select_option
        find("input[placeholder^=Valor]").set equipo[:preco]
        thumb = Dir.pwd + "/features/support/fixtures/images/" + equipo[:thumb]
        find("#thumbnail input[type=file]", visible: false).set thumb
        click_button "Cadastrar"
    end
end