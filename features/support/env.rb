require "capybara"
require "capybara/cucumber"
require "faker"
require "pry"

Capybara.configure do |config|
    # definindo navegador padrão
    config.default_driver = :selenium_chrome
    #definindo URL padrão
    config.app_host = "http://rocklov-web:3000"
    # Com a nova versão, o sistema está demorando para processar e o Capybara não está encontrando o elemento na tela. Desta forma irei adicionar uma espera default no arquivo env.rb. A espera padrão do Capybara são 2 segundos.
    config.default_max_wait_time = 10
end