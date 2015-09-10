# all methods for the books model is defined here

class BooksController < ApplicationController

	before_action :check_if_logged_in, :only => [:index, :show]
  	before_action :check_if_admin, :only => [:edit, :update, :destroy, :new, :create]

  	# searches for a list of books via goodreads brrok search api
  	def search
  	end

  	# returns the search results (function call in book model book.rb file)
  	def results
		@books = Book.books_searches_via_goodreads(params[:title])
  	end

  	# lists out all existing books in db by order of title
	def index
		@books = Book.all
	end

	# displays complete book details
	def show
		@book = Book.find params[:id]
	end

	# adds a new book to db via goodreads book id (api used). Function is called in the book model book.rb
	def new
		@book = Book.book_via_goodreads_id params[:good_reads_id]
	end

	# creating a new book 
	def create
		book = Book.new

		# function called in private method (goodreads api) using goodreads book id
		info = book_via_goodreads(params[:good_reads_id])
		
		# checks if book is valid
		if info.present?

			# check if book already exists
			b = Book.find_by :isbn => info['isbn']
			unless b.present?

				# if book is not already present in the database, extract valid book information from goodreads api and save book to database
				book.title = info['title']
				book.isbn = info['isbn']
				book.publisher = info['publisher']
				book.year = info['publication_year']
				book.description = info['description'] if info['description'].present?
				book.image = info['image_url']
				book.save

				# Attempt to get an author ID with Goodreads' wildly inconsistent data structure.
				begin
					id = info.authors.first[1].id
				rescue
					id = info.authors.first[1].first['id']
				end

				# check if author is already present
				author = Author.find_by :good_reads_author_id => id
				unless author.present?

					# if author is not in the database, add it via goodreads api using goodreads author id
					author = Author.populate_author_via_goodreads(id)
				end

				# book belongs to an author
				author.books << book
			end	
		end
		redirect_to book
	end

	def edit
		@book = Book.find params[:id]
	end

	# update book details 
	def update
		book = Book.find params[:id]
		book.update book_params
		book.update :genre_ids => params[:book][:genre_id]
		redirect_to book
	end

	# while deleting a book, even its reviews and readings are removed
	def destroy
		book = Book.find params[:id]
		book.reviews.destroy_all
		book.readings.destroy_all
		book.destroy

		redirect_to books_path
	end

	private

	# gets goodreads book details (api)
	def book_via_goodreads(id)
		$good_reads_client.book(id)	
	end

	# white-listing book parameters
	def book_params
		params.require(:book).permit(:title, :publisher, :year, :image, :isbn, :description, :author_id)
	end

	def check_if_logged_in
    	redirect_to root_path unless @current_user.present?
  	end

  	def check_if_admin
    	redirect_to root_path unless @current_user.present? && @current_user.admin?
  	end

end
