class BooksController < ApplicationController

  def new
    @book = @user.book.new
  end

  def create
    @book = Book.new(book_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book.user, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book.user }
      else
        format.html { redirect_to @book.user, notice: 'WARNING: Title cannot be blank' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    respond_to do |format|
      format.html { redirect_to @book.user, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def book_params
      params.require(:book).permit(:title, :user_id)
    end
end
