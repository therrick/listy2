namespace :db do
  namespace :load do
    desc 'Add all test data'
    task test_data: [:test_stores, :test_aisles, :test_items]

    desc 'Add test stores'
    task test_stores: :environment do
      puts 'Adding test stores'
      Store.find_or_create_by(user: User.first, name: 'store1')
      Store.find_or_create_by(user: User.first, name: 'store2')
    end

    desc 'Add test aisles'
    task test_aisles: [:test_stores] do
      puts 'Adding test stores'
      Aisle.find_or_create_by(store: Store.first, name: 'aisle1').
        update_attributes(position: 0, description: 'aisle 1 description')
      Aisle.find_or_create_by(store: Store.first, name: 'aisle2').
        update_attributes(position: 1, description: 'aisle 2 description')
    end

    desc 'Add test items'
    task test_items: [:test_aisles] do
      puts 'Adding test items'
      Item.find_or_create_by(store: Store.first, name: 'milk').
        update_attributes(number_needed: 1, popularity: 5, notes: 'skim')
      Item.find_or_create_by(store: Store.first, name: 'bread').
        update_attributes(number_needed: 0, popularity: 2, aisle: Aisle.first)
      Item.find_or_create_by(store: Store.first, name: 'eggs').
        update_attributes(number_needed: 0, popularity: 3, aisle: Aisle.first)
      Item.find_or_create_by(store: Store.first, name: 'cereal').
        update_attributes(number_needed: 0, popularity: 3, aisle: Aisle.second)
    end
  end
end