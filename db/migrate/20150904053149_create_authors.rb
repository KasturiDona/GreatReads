class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
    	t.text :name
    	t.text :pen_name
    	t.date :dob
    	t.date :dod
    	t.text :nationality
    	t.text :image
        t.timestamps null: false
    end
  end
end
