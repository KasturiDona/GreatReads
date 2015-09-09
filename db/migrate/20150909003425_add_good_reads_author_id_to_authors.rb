class AddGoodReadsAuthorIdToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :good_reads_author_id, :integer
  end
end
