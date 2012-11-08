class WalletsController < ApplicationController

  def new
    @wallet = Wallet.new
  end

  def create
    @wallet = Wallet.new(params[:wallet])

    if @wallet.save
      message = {:notice => "Your new '"+ @wallet.name + "' budget was added successfully"}
      redirect_to new_budget_path, :flash => message
    else
      render action: "new"
    end
  end

end
