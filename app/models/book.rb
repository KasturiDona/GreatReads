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

	def self.books_searches_via_goodreads(title)
		search = $good_reads_client.search_books(title)
		books = []
		search.results.work.each do |book|      
		  books << {
		  	:title => book['best_book']['title'],
		  	:good_reads_id => book['best_book'].id   
		}
		end
		books
	end

	def self.book_via_goodreads_id(id)
		info = $good_reads_client.book(id)
		book = Book.new
		book.title = info['title']
		book
	end
end
