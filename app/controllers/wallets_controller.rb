class WalletsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @wallet = Wallet.new
  end

  def create
    @wallet = Wallet.new(params[:wallet])
    @wallet.user = current_user
    if @wallet.save
      redirect_to new_budget_path, :notice=> "Your new '#{@wallet.name}' budget was added successfully"
    else
      render :action=> "new"
    end
  end

end
