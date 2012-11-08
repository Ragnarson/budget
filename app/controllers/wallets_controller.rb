class WalletsController < ApplicationController

  def new
    @wallet = Wallet.new
  end

  def create
    @wallet = Wallet.new(params[:wallet])

    if @wallet.valid?
      redirect_to new_budget_path, notice: 'Your budget was added successfully'
    else
      render 'new'
    end
  end

end
