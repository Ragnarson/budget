class UsersController < ApplicationController

  def index
    @users = User.where(:users => {:invited_by => current_user.id})
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

  def create
    @user = User.new(params[:user])
    @user.password = User.generate_password
    @user.invited_by = current_user.id
    if @user.save
      UserMailer.invite_email(@user).deliver
      redirect_to users_path, notice: 'User was successfully created.'
    else
      render action: "new"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'User was successfully deleted' 
  end
end
