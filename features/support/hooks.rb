# Usando PAGE OBJECT. A instância criada abaixo será utilizada globalmente
Before do
  @alert = Alert.new
  @login_page = LoginPage.new
  @signip_page = SignupPage.new
  @dash_page = DashPage.new
  @equipos_page = EquiposPage.new
end
