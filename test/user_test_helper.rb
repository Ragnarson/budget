module UserTestHelper

  private
  def log_in_pl
    click_on I18n.t('home.login', locale: 'pl')
  end

  def log_in_en
    click_on I18n.t('home.login', locale: 'en')
  end
  
  def get_user_wallet_by_name(user, name)
    user.families.first.wallets.find_by_name(name)
  end

  def get_user_wallet_by_id(user, id)
    user.families.first.wallets.find_by_id(id)
  end
end