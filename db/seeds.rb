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

User.destroy_all
User.create! name: "Mike", username: "currymich", email: "currymich@gmail.com", password: "test"

Dentist.destroy_all
Dentist.create! id: 1, name: "William Choi", office_name: "ProperGuide", email: "willdmd@gmail.com", phone: "5105175355", address: "1598 Washington ave", address_state: "CA", address_city: "San Leandro", address_zip: "94577", license_num: "189a80ab"

Dentist.create! id: 2, name: "Ngan Tran", office_name: "Bell Dental", email: "ngandmd@gmail.com", phone: "5105551234", address: "1599 Washington ave", address_state: "CA", address_city: "San Lorenzo", address_zip: "94541", license_num: "1508ga02"

Order.create! id: 1, order_status_id: 1, dentist_id: 1, patient_name: "Mike Curry"
Order.create! id: 2, order_status_id: 1, dentist_id: 1, patient_name: "Andrew Doan"
Order.create! id: 3, order_status_id: 1, dentist_id: 1, patient_name: "Bau-Chau Nguyen"

Order.create! id: 4, order_status_id: 1, dentist_id: 2, patient_name: "Richard Lai"
Order.create! id: 5, order_status_id: 2, dentist_id: 2, patient_name: "Chris Park"

OrderItem.create! order_id: 1, product_id: 1, quantity: 1
OrderItem.create! order_id: 1, product_id: 4, quantity: 1
OrderItem.create! order_id: 2, product_id: 2, quantity: 4
OrderItem.create! order_id: 3, product_id: 3, quantity: 2
OrderItem.create! order_id: 4, product_id: 6, quantity: 2
OrderItem.create! order_id: 5, product_id: 5, quantity: 2
