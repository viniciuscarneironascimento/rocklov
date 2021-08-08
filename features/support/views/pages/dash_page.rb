class DashPage
    include Capybara::DSL

    def goto_equipo_form
    click_button "Criar anúncio"
    end

    def equipo_list
        return find(".equipo-list")
    end

    # Este meétodo retorna true ou false pois utilizo ponto de interrogação
    def on_dash?
        return page.has_css?(".dashboard")
    end

end