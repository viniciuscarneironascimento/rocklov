class Alert
  include Capybara::DSL

  def alert_element
    if page.has_css?(".alert-error")
      return find(".alert-error").text
    elsif page.has_css?(".alert-dark")
      return find(".alert-dark").text
    end
  end
end
