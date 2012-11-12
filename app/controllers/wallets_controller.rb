class WalletsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @wallets = current_user.wallets
    redirect_to new_budget_path, notice: "You dont have any budgets. Please define new budget." if @wallets.blank?
  end

  def new
    @wallet = Wallet.new
  end

  def create
    @wallet = Wallet.new(params[:wallet])
    @wallet.user = current_user
    if @wallet.save
      redirect_to budgets_path, notice: "Your new '#{@wallet.name}' budget was added successfully"
    else
      render :action=> "new"
    end
  end

end
