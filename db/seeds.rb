# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Spot.destroy_all
User.destroy_all


team = %w(mira dave chinzoo sevan)

team.each do |mem|
    User.new(email: mem + "@skate.co", password: 'password').save
end