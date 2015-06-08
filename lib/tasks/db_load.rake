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
      puts 'Adding test aisles'
      Aisle.find_or_create_by(store: Store.first, name: 'A').
        update_attributes(position: 0, description: 'produce')
      Aisle.find_or_create_by(store: Store.first, name: 'B').
        update_attributes(position: 1, description: 'dry goods')
      Aisle.find_or_create_by(store: Store.first, name: 'C').
        update_attributes(position: 2, description: 'refrigerated')
      Aisle.find_or_create_by(store: Store.first, name: 'D').
        update_attributes(position: 2, description: 'frozen')
    end

    desc 'Add test items'
    task test_items: [:test_aisles] do
      puts 'Adding test items'
      store = Store.first
      produce_aisle = store.aisles.find_by(description: 'produce')
      dry_goods_aisle = store.aisles.find_by(description: 'dry goods')
      refrigerated_aisle = store.aisles.find_by(description: 'refrigerated')
      frozen_aisle = store.aisles.find_by(description: 'frozen')
      store.items.find_or_create_by(name: 'milk').
        update_attributes(number_needed: 1,
                          popularity: rand(5),
                          aisle: refrigerated_aisle,
                          notes: 'skim')
      store.items.find_or_create_by(name: 'bread').
        update_attributes(popularity: rand(5), aisle: dry_goods_aisle)
      store.items.find_or_create_by(name: 'eggs').
        update_attributes(popularity: rand(5), aisle: refrigerated_aisle)
      store.items.find_or_create_by(name: 'cheese').
        update_attributes(popularity: rand(5), aisle: refrigerated_aisle)
      store.items.find_or_create_by(name: 'cereal').
        update_attributes(popularity: rand(5), aisle: dry_goods_aisle)
      store.items.find_or_create_by(name: 'ice cream').
        update_attributes(popularity: rand(5), aisle: dry_goods_aisle)
      store.items.find_or_create_by(name: 'bananas').
        update_attributes(popularity: rand(5), aisle: produce_aisle)
      store.items.find_or_create_by(name: 'apples').
        update_attributes(popularity: rand(5), aisle: produce_aisle)
      store.items.find_or_create_by(name: 'crackers').
        update_attributes(popularity: rand(5), aisle: dry_goods_aisle)
      store.items.find_or_create_by(name: 'cookies').
        update_attributes(popularity: rand(5), aisle: dry_goods_aisle)
      store.items.find_or_create_by(name: 'ice cream').
        update_attributes(popularity: rand(5), aisle: frozen_aisle)
    end
  end
end
