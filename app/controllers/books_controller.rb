class BooksController < ApplicationController
before_action :check_book, only: [:edit]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice:'You have created book successfully.'
    else
        @books = Book.all
        flash[:alert] = 'Book was not successfully created.'
        render :index
    end
  end

def edit
  @book = Book.find(params[:id])
end

  def index

    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice:'Book was successfully updated.'
    else
      @books = Book.all
      flash[:alert] = 'Book was not successfully updated.'
      render :edit
    end
  end

  def show
    @book = Book.new
    @books = Book.all
    @bookshow = Book.find(params[:id])
    @user = @bookshow.user
  end

  def destroy
     book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy# データ（レコード）を削除
    redirect_to books_path
  end

   private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def check_book
      @book = Book.find(params[:id])
      if @book.user != current_user
        redirect_to books_path
      end
  end
  
  
end
