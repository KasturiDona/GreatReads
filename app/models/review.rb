# == Schema Information
#
# Table name: reviews
#
#  id          :integer          not null, primary key
#  description :text
#  rating      :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Review < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :books
end
