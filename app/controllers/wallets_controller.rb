class WalletsController < ApplicationController

  def new
    @wallet = Wallet.new
  end

  def create
    if params[:wallet][:name].blank?
      message = {:error => "Budget could not be empty"}
    else
      message = {:notice => "Your budget was added successfully"}
    end
    redirect_to new_budget_path, :flash => message
  end

end
