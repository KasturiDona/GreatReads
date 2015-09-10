# == Schema Information
#
# Table name: authors
#
#  id          :integer          not null, primary key
#  name        :text
#  pen_name    :text
#  dob         :date
#  dod         :date
#  nationality :text
#  image       :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Author < ActiveRecord::Base
	has_many :books
	has_many :genres, :through => :books
	has_many :reviews, :through => :books
	def display_name
        if pen_name
            pen_name
        else
            name
        end
    end
    
    # get author details by their goodreads author id (API)
    def self.populate_author_via_goodreads(id)
        info = $good_reads_client.author id
        author = Author.new
        author.name = info['name']
        author.dob = info['born_at']
        author.dod = info['died_at']
        author.image = info['image_url']
        author.good_reads_author_id = info['id']
        author.save

        author
    end
end
