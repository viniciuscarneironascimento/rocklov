# Usando PAGE OBJECT. A instância criada abaixo será utilizada globalmente
Before do
  @alert = Alert.new
  @login_page = LoginPage.new
  @signip_page = SignupPage.new
  @dash_page = DashPage.new
  @equipos_page = EquiposPage.new

  # page.driver.browser.manage.window.maximize
  page.current_window.resize_to(1440, 900)
end
