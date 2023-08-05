class BooksController < ApplicationController
  
  def index
        @user = current_user
        @books = Book.all
        @book = Book.new
  end

  def create
       @book = Book.new(book_params)
       @book.user_id = current_user.id
   
   if  @book.save
       redirect_to book_path(@book), notice: 'Book was successfully created.'
    else
       @books = Book.all
       @user = current_user
       render :index
    end
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
      @book = Book.find(params[:id])
   if @book.user == current_user
      render "edit"
   else
     redirect_to books_path
   end
  end
  
  def update
    @book = Book.find(params[:id])
   if
    @book.update(book_params)
    redirect_to book_path(@book.id), notice: 'Book was successfully update.'
   else
      @books = Book.all
      render action: :edit
   end
  end


  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path
  end
  
  
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end