class UsersController < ApplicationController

  # GET users

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end


  # GET users/new

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end
end
