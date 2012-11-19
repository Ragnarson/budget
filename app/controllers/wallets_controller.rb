class WalletsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @wallets = current_user.wallets
    redirect_to new_wallet_path, notice: t('flash.no_wallets') if @wallets.blank?
  end

  def new
    @wallet = Wallet.new
  end

  def create
    @wallet = Wallet.new(params[:wallet])
    @wallet.user = current_user
    if @wallet.save
      redirect_to wallets_path, notice: t('flash.wallet_success', name: @wallet.name)
    else
      render action: 'new'
    end
  end

  def edit
    @wallet = current_user.wallets.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to wallets_path, notice: t('flash.no_record', model: t('activerecord.models.wallet'))
  end

  def update
    begin
      @wallet = current_user.wallets.find(params[:id])
      @wallet.attributes = params[:wallet]
      if @wallet.save
        redirect_to wallets_path, notice: t('flash.update_one', model: t('activerecord.models.wallet'))
      else
        render action: 'edit'
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to wallets_path, notice: t('flash.no_record', model: t('activerecord.models.wallet'))
    end
  end

  def destroy
    current_user.wallets.find(params[:id]).destroy
    redirect_to wallets_path, notice: t('flash.delete_one', model: t('activerecord.models.wallet'))
  rescue ActiveRecord::RecordNotFound
    redirect_to wallets_path, notice:  t('flash.no_record', model: t('activerecord.models.wallet'))
  end
end
