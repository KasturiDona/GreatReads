# == Schema Information
#
# Table name: genres
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Genre < ActiveRecord::Base
	has_and_belongs_to_many :books
	validates_uniqueness_of :name, :case_sensitive => false
	before_save :capitalize_genre

	def capitalize_genre
		self.name = self.name.capitalize
	end
end
