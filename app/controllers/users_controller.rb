class UsersController < ApplicationController
   before_action :authenticate_user!
   before_action :correct_user, only: [:edit, :update]

  def index
    @user = current_user
    @users = User.all
    @newbook = Book.new
  end

  def edit

    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:notice] = 'You have updated user successfully.'
    else
      @books = @user.books
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @newbook = Book.new
    @books = @user.books

  end

  private
  def  user_params
    params.require(:user).permit(:name, :profile_image, :introduction)

  end

  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
    redirect_to user_path(current_user)
  end
  end
end
