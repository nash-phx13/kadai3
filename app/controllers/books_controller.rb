class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to books_path
    else
      render :index
    end
  end

def edit
end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all

  end

  def show
    @showbook = Book.find(params[:id])
    @book = Book.new
    @books = Book.all
    @user = @showbook.user
  end

  def destroy
  end

   private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
