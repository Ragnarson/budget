module LoginTestHelper

private
  def log_in_pl
    click_on I18n.t('home.login', locale: 'pl')
  end

  def log_in_en
    click_on I18n.t('home.login', locale: 'en')
  end
end