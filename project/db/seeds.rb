# This file should contain all the record creation needed to seed the database
# with its default values. The data can then be loaded with the rails db:seed
# command (or created alongside the database with db:setup).
#
# Examples:
#
#  movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#  Character.create(name: 'Luke', movie: movies.first)

case Rails.env
when 'development'
  # Do development environment specific seeding here.
  User.create(email: 'dev@thewishlist.com', password: 'Th3W1shL1st',
              first_name: 'WishList', last_name: 'Dev')
  # when 'test'
  #   # Do test environment specific seeding here.
  # when 'production'
  #   # Do production environment specific seeding here.
end

# Do seeding that goes in all environments here.
