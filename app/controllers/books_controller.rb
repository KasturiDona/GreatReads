class BooksController < ApplicationController

	before_action :check_if_logged_in, :only => [:index, :show]
  	before_action :check_if_admin, :only => [:edit, :update, :destroy, :new, :create]

	def index
		@books = Book.order(:title)
	end

	def show
		@book = Book.find params[:id]
	end

	def new
		@book = Book.new
	end

	def create
		book = Book.new
		info = book_via_goodreads(params[:book][:title])
		# book.author = author.name
		book.title = info['title']
		book.isbn = info['isbn']
		book.publisher = info['publisher']
		book.year = info['publication_year']
		book.image = info['image_url']
		book.save

		author = Author.find_by :id => params[:book][:author_id]
		if author.present?
			author.books << book
		else
			begin
				id = info.authors.first[1].id
			rescue
				id = info.authors.first[1].first['id']
			end
			author = Author.populate_author_via_goodreads(id)
			author.books << book
		end

		redirect_to book
	end

	def edit
		@book = Book.find params[:id]
	end

	def update
		book = Book.find params[:id]
		book.update book_params
		book.update :genre_ids => params[:book][:genre_id]
		redirect_to book
	end

	def destroy
		book = Book.find params[:id]
		book.destroy
		redirect_to books_path
	end

	private
	def book_params
		params.require(:book).permit(:title, :publisher, :year, :image, :isbn, :author_id)
	end

	def book_via_goodreads(title)
		$good_reads_client.book_by_title(title)
	end


	def check_if_logged_in
    	redirect_to root_path unless @current_user.present?
  	end

  	def check_if_admin
    	redirect_to root_path unless @current_user.present? && @current_user.admin?
  	end

end
