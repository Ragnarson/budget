class WalletsController < ApplicationController

  #need authentication !!! to tie wallet with user

  def index
    @wallets = Wallet.find(:all) #here missing wallets for logged user
    redirect_to new_wallet_path, :flash => {:notice => 'Add new budget'} if @wallets.blank?
  end

  def new
    @wallet = Wallet.new

  end

  def create
    @wallet = Wallet.new(params[:wallet])
    if @wallet.save
      redirect_to wallets_path, :flash => {:notice => "Your budget was added successfully"}
    else
      render :template => 'wallets/new'
    end
  end

  def edit
    get_wallet(params[:id])
    redirect_to wallets_path, :flash => {:error => "Can't find budget"} if @wallet.blank?
  end

  def update
    get_wallet(params[:id])
    if @wallet.blank?
      redirect_to wallets_path, :flash => {:error => "Can't find budget"}
    else
      @wallet.attributes = params[:wallet]
      if @wallet.save
        redirect_to wallets_path, :flash => {:notice => "Your budget was updated successfully"}
      else
        render :template => 'wallets/edit'
      end
    end
  end

  def destroy
    get_wallet(params[:id])
    if @wallet.blank?
      redirect_to wallets_path, :flash => {:error => "Can't find budget"}
    else
      @wallet.destroy
      redirect_to wallets_path, :flash => {:notice => "Your budget was deleted successfully"}
    end
  end

  def get_wallet(id)
    @wallet = Wallet.where(:id => id).first
  end

end
