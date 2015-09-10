# == Schema Information
#
# Table name: books
#
#  id         :integer          not null, primary key
#  title      :text
#  publisher  :text
#  year       :text
#  image      :text
#  isbn       :text
#  author_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Book < ActiveRecord::Base
	belongs_to :author
	has_many :readings
	has_many :reviews
	has_and_belongs_to_many :genres

	# searches for all books with matching title and returns the list (goodreads api) 
	def self.books_searches_via_goodreads(title)
		search = $good_reads_client.search_books(title)
		books = []

		# if a valid search has been made, display each book. Import the book name and goodreads id
		if (search.results).present?
			search.results.work.each do |book|      
			  books << {
			  	:title => book['best_book']['title'],
			  	:good_reads_id => book['best_book'].id   
			}
			end
		end
		books
	end

	# when admin selects the book it is added to the database (goodreads api)
	def self.book_via_goodreads_id(id)
		info = $good_reads_client.book(id)
		book = Book.new
		book.title = info['title']
		book
	end
end
