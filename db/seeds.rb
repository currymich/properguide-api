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
Product.create! id: 1, name: "Surgical Stent", price: 120, image_url: "../img/stent_guide.jpg", alt_image: "../img/stent_guide.jpg", active: true

Product.create! id: 2, name: "Crown", price: 150, image_url: "../img/crown1.jpg", alt_image: "../img/crown2.jpg", active: true

Product.create! id: 3, name: "Veneer", price: 150, image_url: "../img/veneer1.jpg", alt_image: "../img/veneer2.jpg", active: true

Product.create! id: 4, name: "Screw Retained", price: 400, image_url: "../img/screw1.jpg", alt_image: "../img/screw2.jpg", active: true

Product.create! id: 5, name: "Cement Retained", price: 400, image_url: "../img/cement1.jpg", alt_image: "../img/cement2.jpg", active: true

Product.create! id: 6, name: "Bridge", price: 150, image_url: "../img/bridge1.jpg", alt_image: "../img/bridge2.jpg", active: true
