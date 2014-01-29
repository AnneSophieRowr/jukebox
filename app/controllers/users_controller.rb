class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = Kaminari.paginate_array(UserDecorator.decorate_collection(User.all)).page(params[:page])
  end

  def new
    @user = User.new
  end

  def edit
    @user = @user.decorate
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: t('user.create', name: @user.decorate.name) }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: t('user.update', name: @user.decorate.name) }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    name = @user.decorate.name
    @user.destroy
      respond_to do |format|
      format.html { redirect_to users_url, notice: t('user.destroyed', name: name) }
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:last_name, :first_name, :email, :password, :password_confirmation)
  end

end
