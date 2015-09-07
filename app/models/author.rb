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
end
