class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
    	t.integer :status, default: 1
    	t.integer :book_id
    	t.integer :user_id
        t.timestamps null: false
    end
  end
end
