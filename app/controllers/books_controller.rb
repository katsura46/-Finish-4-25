class BooksController < ApplicationController
   before_action:authenticate_user!
   before_action :correct_user, only: [:edit, :update]

  def new
    @book = Book.new
  end

  #投稿データを保存
  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    if @newbook.save
      redirect_to book_path(@newbook)
      flash[:notice] = "Book was successfully created"
    else
       @books = Book.all
       @user = current_user
       render :index
    end
  end

  def index
    @newbook = Book.new
    @books = Book.all
    @user = current_user


  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
      flash[:notice] = "You have updated book successfully."
    else
      render :edit
    end
  end


  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @users = User.all
    @books = @user.books
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :user)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    unless @user == current_user
     redirect_to books_path
    end
  end

end
