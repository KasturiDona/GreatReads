Book.destroy_all
b1 = Book.create :title => "Mr. Mercedes"
b2 = Book.create :title => "To Kill a Mockingbird"
b3 = Book.create :title => "Finders Keepers"
b4 = Book.create :title => "The Namesake"
b5 = Book.create :title => "The Lowland"

Author.destroy_all
a1 = Author.create :name => "Sonu Nigam"
a2 = Author.create :name => "Anu Malik"
a3 = Author.create :name => "Shreya Goshal"
a4 = Author.create :name => "KK"
a5 = Author.create :name => "Alka Yagnik"

Album.destroy_all
ab1 = Album.create :name => "Coke Studio 1"
ab2 = Album.create :name => "Best Hits"
ab3 = Album.create :name => "Top 20"
ab4 = Album.create :name => "Indi Pop"
ab5 = Album.create :name => "Hai na"

Genre.destroy_all
g1 = Genre.create :name => "Romantic"
g2 = Genre.create :name => "Pop"
g3 = Genre.create :name => "Hip Hop"
g4 = Genre.create :name => "Rock"
g5 = Genre.create :name => "Instrumental"

User.destroy_all
u1 = User.create :name => 'Amit', :email => "amit@gmail.com", :password => 'chicken', :password_confirmation => 'chicken'
u2 = User.create :name => 'Amina', :email => "amina@gmail.com", :password => 'goldfish', :password_confirmation => 'goldfish'

Mixtape.destroy_all
m1 = u1.mixtapes.create :name => "Mix 1"
m2 = Mixtape.create :name => "Mix 2"
m3 = Mixtape.create :name => "Mix 3"

u2.mixtapes << m2 << m3

a1.songs << s1
a2.songs << s2
a3.songs << s3
a4.songs << s4
a5.songs << s5

ab1.songs << s1
ab2.songs << s2
ab3.songs << s3
ab4.songs << s4
ab5.songs << s5

g1.songs << s1 << s2
g2.songs << s4
g3.songs << s3
g4.songs << s1 << s2 << s3 << s4 << s5

m1.songs << s5 << s4 << s3 << s2 << s1
m2.songs << s1 << s3 << s5
m3.songs << s1 << s2 << s5