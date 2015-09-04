class CreateBooksReviews < ActiveRecord::Migration
  def change
    create_table :books_reviews, :id => false do |t|
      t.integer :book_id
      t.integer :review_id
    end
  end
end
