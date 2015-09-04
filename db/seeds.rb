Book.destroy_all
b1 = Book.create :title => "Mr. Mercedes"
b2 = Book.create :title => "The Namesake"
b3 = Book.create :title => "Harry Potter and the Philosopher's Stone"
b4 = Book.create :title => "War and Peace"
b5 = Book.create :title => "Love Story"

Author.destroy_all
a1 = Author.create :name => "Stephen King"
a2 = Author.create :name => "Jhumpa Lahiri"
a3 = Author.create :name => "J.K Rowling"
a4 = Author.create :name => "Leo Tolstoy"
a5 = Author.create :name => "Eric Segal"

Genre.destroy_all
g1 = Genre.create :name => "Crime Thriller"
g2 = Genre.create :name => "Adult Fiction"
g3 = Genre.create :name => "Fantasy"
g4 = Genre.create :name => "Classic"
g5 = Genre.create :name => "Romantic"

Review.destroy_all
rev1 = Review.create :description => "Very Good"
rev2 = Review.create :description => "Boring"
rev3 = Review.create :description => "Must Read"
rev4 = Review.create :description => "Loved It"
rev5 = Review.create :description => "Don't miss it"

Reading.destroy_all
read1 = Reading.create :status => 1
read2 = Reading.create :status => 2
read3 = Reading.create :status => 2
read4 = Reading.create :status => 3
read5 = Reading.create :status => 4

User.destroy_all
u1 = User.create :name => 'Abhishek', :email => "abhishek@gmail.com", :password => 'chicken', :password_confirmation => 'chicken'
u2 = User.create :name => 'Arnov', :email => "arnov@gmail.com", :password => 'goldfish', :password_confirmation => 'goldfish'

a1.books << b1
a2.books << b2
a3.books << b3
a4.books << b4
a5.books << b5

read1.update :book => b1
read2.update :book => b2
read3.update :book => b3
read4.update :book => b4
read5.update :book => b5

g1.books << b1 << b2
g2.books << b1 << b2 << b3 << b4
g3.books << b3
g4.books << b5

rev1.books << b5 << b4 << b3 << b2 << b1
rev2.books << b1 << b3 << b5
rev3.books << b1 << b2