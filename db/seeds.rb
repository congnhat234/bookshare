# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(name: "Administrator",
  email: "admin@bookshare.com",
  password: "Admin@123",
  password_confirmation: "Admin@123")

User.create!(
  name: "Cong Nhat",
  email: "congnhat@bookshare.com",
  password: "Aa@123123",
  password_confirmation: "Aa@123123",
  phone: "0123456789",
  address: "Da Nang",
  avatar: "",
  role: 1,
  confirmed_at: Time.now)

5.times do |n|
  name = Faker::Book.genre
  Category.create!(name: name)
end

20.times do |n|
  title  = Faker::Book.title
  description = Faker::Book.author + " " + Faker::Book.publisher
  quantity = Faker::Number.between(from: 10, to: 200)
  price = Faker::Number.between(from: 50000, to: 500000)
  category_id = Faker::Number.between(from: 1, to: 5)
  rating = Faker::Number.decimal(l_digits: 1, r_digits: 1)
  view = Faker::Number.number(digits: 5)
  discount = Faker::Number.between(from: 5, to: 70)
  user = 1
  type = Faker::Number.between(from: 0, to: 2)
  book = Book.create!(title: title,
    description: description,
    quantity: quantity,
    price: price,
    category_id: category_id,
    rating: rating,
    view: view,
    discount: discount,
    user_id: user,
    activated: true,
    book_type: type)
end

30.times do |n|
  title = Faker::Book.title
  preview = Faker::Books::Lovecraft.paragraph
  content = Faker::Books::Lovecraft.paragraphs
  view = Faker::Number.number(digits: 5)
  user = 1
  Post.create!(title: title,
    preview: preview,
    content: content,
    view: view,
    photo: "",
    user_id: user)
end
