class UsersController < ApplicationController

  def new
  end

  def create
    @book = Book.new(book_params)
      if @book.save
        flash[:notice] = "投稿を作成しました"
        redirect_to book_path(@book.id), notice:'Book was successfully created.'
      else
        @books = Book.all
        flash[:alert] = 'Book was not successfully created.'
        render :index
      end
  end

  def index
    @user = current_user
    @book = Book.new
    @users = User.all

  end

  def show
  @user = User.find(params[:id])
  @book = Book.new
  @books = @user.books
  @userimage = current_user
  end

  def destroy
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id), notice:'You have updated user successfully.'
    else
    @users = User.all
    flash[:alert] = 'Book was not successfully updated.'
      render :edit
    end
  end

 private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
