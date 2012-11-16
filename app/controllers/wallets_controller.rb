class WalletsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @wallets = current_user.wallets
    redirect_to new_budget_path, notice: t('flash.no_wallets') if @wallets.blank?
  end

  def new
    @wallet = Wallet.new
  end

  def create
    @wallet = Wallet.new(params[:wallet])
    @wallet.user = current_user
    if @wallet.save
      redirect_to budgets_path, notice: t('flash.wallet_success', name: @wallet.name)
    else
      render :action=> "new"
    end
  end

end
