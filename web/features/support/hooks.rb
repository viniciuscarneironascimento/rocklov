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

After do
  # Depois (After) da execução do último step de um cenário, ou seja, no step "ENTÃO", obtenho um print do resultado com o comando abaixo. Este print será salvo com a extensão ".png" conforme definido, em seguida guardo na pasta LOGS "logs/tem_screenshot.png". Salvo o print desta evidência em uma variável.
  temp_shot = page.save_screenshot("logs/tem_screenshot.png")

  # Anexo o print desta evidência no relatório Allure atrvés dos comandos abaixo
  Allure.add_attachment(
    name: "Screenshot",
    type: Allure::ContentType::PNG,
    source: File.open(temp_shot),
  )
end
