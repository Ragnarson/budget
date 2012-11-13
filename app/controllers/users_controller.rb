class UsersController < ApplicationController

  def index
    @users = User.where(:users => {:invited_by => current_user.id})
    if @users.empty?
      redirect_to new_user_path, notice: "You didn't add any family member."
    else
      respond_to do |format|
        format.html # index.html.erb
      end
    end
  end

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
      mail_params = Hash["email" => @user.email, "current_user_email" => current_user.email, "url" => "http://budget.shellyapp.com"]
      UserMailer.invite_email(mail_params).deliver
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
