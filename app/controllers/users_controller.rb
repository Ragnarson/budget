class UsersController < ApplicationController

  # GET users
  def index
    @users = User.find(:all, :conditions => {:invited_by => current_user.id})

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

  # POST users
  def create
    @user = User.new(params[:user])
    @user.password = User.generate_password
    @user.invited_by = current_user.id

    respond_to do |format|
      if @user.save
        UserMailer.invite_email(@user).deliver
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_path, notice: 'User was successfully deleted' }
      format.json { head :no_content }
    end
  end
end
