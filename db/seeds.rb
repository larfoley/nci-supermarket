# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
unless User.find_by( email: "admin@nci-supermarket.com" )
  # create all 100 users
  user = User.new(
    email: 'admin@nci-supermarket.com',
    password: 'letmein123',
    password_confirmation: 'letmein123',
    admin: true
  )
  user.save!
end
