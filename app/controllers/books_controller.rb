class BooksController < ApplicationController

	before_action :check_if_logged_in, :only => [:index, :show]
  	before_action :check_if_admin, :only => [:edit, :update, :destroy, :new, :create]

  	def search
  	end

  	def results
		@books = Book.books_searches_via_goodreads(params[:title])
  	end


	def index
		@books = Book.order(:title)
	end

	def show
		@book = Book.find params[:id]
	end

	def new
		@book = Book.book_via_goodreads_id params[:good_reads_id]
	end

	def create

		book = Book.new
		info = book_via_goodreads(params[:good_reads_id])
		
		if info.present?

			b = Book.find_by :isbn => info['isbn']
			unless b.present?
				# book.author = author.name
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

				author = Author.find_by :good_reads_author_id => id
				unless author.present?
					author = Author.populate_author_via_goodreads(id)
				end

				author.books << book
			end	
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
		book.reviews.destroy_all
		book.readings.destroy_all
		book.destroy

		redirect_to books_path
	end

	private
	def book_via_goodreads(id)
		$good_reads_client.book(id)	
	end

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
