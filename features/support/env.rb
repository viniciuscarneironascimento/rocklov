require "allure-cucumber"
require "capybara"
require "capybara/cucumber"
require "faker"
require "pry"

# Criando CONSTANTES que é uma espécie de variável que não muda seu valor
# Se a linha abixo estivesse configurada como "CONFIG = YAML.load_file(File.join(Dir.pwd, "feature/support/config/local.yml"))" estaria executando o ambiente definido no arquivo "local.yml". Porém iremos adotar uma estratéfia para mudar apenas o arquivo da pasta config que pode ser "local.yml ou hml.yml", ou seja, ambiente local ou de homologação.
# Neste caso o recurso será como na linha abaixo onde o caminho é concatenado com "#{ENV["CONFIG"]}"
# Agora vamos aplicar na linha 17
CONFIG = YAML.load_file(File.join(Dir.pwd, "features/support/config/#{ENV["CONFIG"]}"))

Capybara.configure do |config|
  # definindo navegador padrão Chrome
  # config.default_driver = :selenium_chrome
  # definindo navegador padrão Firefox
  # config.default_driver = :selenium

  # Execução em modo HEADLESS, ou seja, sem exibição do navegador, por baixo dos panos (background)
  # config.default_driver = :selenium_headless
  config.default_driver = :selenium_chrome_headless

  #definindo URL padrão. Este endereço será substituído pela CONSTANTE
  # config.app_host = "http://rocklov-web:3000"
  # Dentro do colchetes eu coloco o campo que eu quero carregar que foi criado no arquivo "local.yml ou hml.yml"
  config.app_host = CONFIG["url"]

  # Com a nova versão, o sistema está demorando para processar e o Capybara não está encontrando o elemento na tela. Desta forma irei adicionar uma espera default no arquivo env.rb. A espera padrão do Capybara são 2 segundos.
  config.default_max_wait_time = 10
end

AllureCucumber.configure do |config|
  # Guardar o relatório no diretório pasta logs
  config.results_directory = "/logs"

  # Limpa e atualiza o relatório com a última execução
  config.clean_results_directory = true
end
