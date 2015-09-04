class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
    	t.text :title
    	t.text :publisher
    	t.text :year
    	t.text :image
    	t.text :isbn
    	t.integer :author_id
    	t.timestamps
    end
  end
end
