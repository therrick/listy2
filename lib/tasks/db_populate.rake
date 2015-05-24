namespace :db do
  namespace :populate do
    desc 'Add all test data'
    task test_data: [:test_stores]

    desc 'Add test stores'
    task test_stores: :environment do
      puts 'Adding test stores'
      Store.find_or_create_by(user: User.find(1), name: 'store1')
      Store.find_or_create_by(user: User.find(1), name: 'store2')
    end
  end
end