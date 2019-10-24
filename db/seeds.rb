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
