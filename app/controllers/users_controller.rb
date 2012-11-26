class UsersController < ApplicationController

  def index
    @users = User.where(:users => {:invited_by => current_user.id})
    redirect_to new_user_path, notice: t('flash.no_members') if @users.blank?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.password = User.generate_password
    @user.invited_by = current_user.id
    if @user.save
      mail_params = {email: @user.email, current_user_email: current_user.email, url: "http://budget.shellyapp.com"}
      UserMailer.invite_email(mail_params).deliver
      redirect_to users_path, notice: t('flash.success_one', model: t('activerecord.models.user'))
    else
      render action: "new"
    end
  end

  def edit_profile
    @user = current_user
  end

  def update
    @user = current_user
    @user.locale = params[:user][:locale]

    if @user.save
      I18n.locale = @user.locale
      flash.now[:notice] = t("flash.update_one")
      render action: "edit_profile"
    else
      flash.now[:error] = t("flash.fail_changes")
      render action: "edit_profile"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: t('flash.delete_one', model: t('activerecord.models.user'))
  end
end
