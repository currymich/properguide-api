# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

OrderStatus.destroy_all
OrderStatus.create! id: 1, name: "In Progress"
OrderStatus.create! id: 2, name: "Placed"
OrderStatus.create! id: 3, name: "Shipped"
OrderStatus.create! id: 4, name: "Cancelled"

Product.destroy_all
Product.create! id: 1, name: "Surgical Stent", price: 300, image_url: "../img/stent_guide.jpg", active: true
Product.create! id: 2, name: "Implant", price: 500, image_url: "../img/case3.jpg", active: true
