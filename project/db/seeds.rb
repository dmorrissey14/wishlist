# This file should contain all the record creation needed to seed the database
# with its default values. The data can then be loaded with the rails db:seed
# command (or created alongside the database with db:setup).
#
# Examples:
#
#  movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#  Character.create(name: 'Luke', movie: movies.first)

case Rails.env

# Do development environment specific seeding here.
when 'development'
  # Common development account
  User.create(email:      'dev@thewishlist.com',
              password:   'Th3W1shL1st',
              first_name: 'WishList',
              last_name:  'Dev')

  # Common development account pre-configured for manual performance tests
  perf_user = User.create(email:      'perftest@thewishlist.com',
                          password:   'Th3W1shL1st',
                          first_name: 'WishList',
                          last_name:  'Performance')
  perf_list = List.create(name: 'Performance Test List Items', owner: perf_user)
  test_item_name_format = 'TestItem%<index>s'
  (0..99).each do |i|
    ListItem.create(description: format(test_item_name_format, index: i),
                    comments:    format(test_item_name_format, index: i),
                    site_link:   'http://localhost:3000',
                    image_link:  'http://via.placeholder.com/350x150',
                    list:        perf_list)
  end
  # when 'test'
  #   # Do test environment specific seeding here.
  # when 'production'
  #   # Do production environment specific seeding here.
end

# Do seeding that goes in all environments here.
