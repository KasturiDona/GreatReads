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
		search.results.work.each do |book|      
		  @book << book.title   
		end
		@book
	end
end
