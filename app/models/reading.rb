# == Schema Information
#
# Table name: readings
#
#  id         :integer          not null, primary key
#  status     :integer          default(1)
#  book_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Reading < ActiveRecord::Base
	belongs_to :book
	belongs_to :user

	enum status: [ :unknown, :in_progress, :completed, :not_read, :want_to_read ]
end
