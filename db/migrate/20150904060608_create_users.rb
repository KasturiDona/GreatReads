class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.text :email
    	t.text :name
      	t.text :image
        t.timestamps null: false
    end
  end
end
