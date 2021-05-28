class UsersController < ApplicationController
 before_action :check_user, only: [:edit,:update]

  def new
  end

  def create
     @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id), notice:'You have updated user successfully.'
    else
    @users = User.all
    flash[:alert] = 'Book was not successfully updated.'
      render :edit
    end

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

  end

  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy# データ（レコード）を削除
    redirect_to user_path  # 投稿一覧画面へリダイレクト
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
    flash[:alert] = 'Name is too short (minimum is 2 characters)'
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image,:introduction)
  end

    def check_user
      @user = User.find(params[:id])
      if @user != current_user
        redirect_to user_path(current_user.id)
      end
    end
end