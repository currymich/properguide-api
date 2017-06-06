# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Dentist.destroy_all

Dentist.create! id: 1, name: "Admin"

Dentist.create! id: 2, name: "William Choi", office_name: "ProperGuide", email: "willdmd@gmail.com", phone: "5105175355", address: "1598 Washington ave", address_state: "CA", address_city: "San Leandro", address_zip: "94577", license_num: "189a80ab"

Dentist.create! id: 3, name: "Ngan Tran", office_name: "Bell Dental", email: "ngandmd@gmail.com", phone: "5105551234", address: "1599 Washington ave", address_state: "CA", address_city: "San Lorenzo", address_zip: "94541", license_num: "1508ga02"

OrderStatus.destroy_all
OrderStatus.create! id: 1, name: "In Progress"
OrderStatus.create! id: 2, name: "Placed"
OrderStatus.create! id: 3, name: "Shipped"
OrderStatus.create! id: 4, name: "Cancelled"

Product.destroy_all
Product.create! id: 1, name: "Surgical Implant Guide", price: 120, image_url: "../img/stent_guide.jpg", alt_image: "../img/stent_guide.jpg", active: true
Product.create! id: 2, name: "CBCT", price: 150, image_url: "../img/cbct.jpg", alt_image: "../img/cbct.jpg", active: true
Product.create! id: 3, name: "Screw Retained Crown", price: 400, image_url: "../img/screw1.jpg", alt_image: "../img/screw2.jpg", active: true
Product.create! id: 4, name: "Cement Retained Crown", price: 400, image_url: "../img/cement1.jpg", alt_image: "../img/cement2.jpg", active: true
Product.create! id: 5, name: "E-Max Veneer", price: 150, image_url: "../img/veneer1.jpg", alt_image: "../img/veneer2.jpg", active: true
Product.create! id: 6, name: "Bridge", price: 150, image_url: "../img/bridge1.jpg", alt_image: "../img/bridge2.jpg", active: true
Product.create! id: 7, name: "Non-Implant Crown", price: 150, image_url: "../img/crown1.jpg", alt_image: "../img/crown2.jpg", active: true

Order.create! id: 1, dentist_id: 1, patient_name: "Mike Curry", order_status_id: 1
Order.create! id: 2, dentist_id: 1, patient_name: "Andrew Doan", order_status_id: 1
Order.create! id: 3, dentist_id: 1, patient_name: "Bao-Chau Nguyen", order_status_id: 1

Order.create! id: 4, dentist_id: 2, patient_name: "Richard Lai", order_status_id: 2
Order.create! id: 5, dentist_id: 2, patient_name: "Chris Park", order_status_id: 1

Order.find(1).order_items.create! product_id: 1, quantity: 1
Order.find(1).order_items.create! product_id: 4, quantity: 1
Order.find(2).order_items.create! product_id: 2, quantity: 1
Order.find(3).order_items.create! product_id: 3, quantity: 1
Order.find(3).order_items.create! product_id: 6, quantity: 1
Order.find(4).order_items.create! product_id: 5, quantity: 1
Order.find(5).order_items.create! product_id: 1, quantity: 2

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end
