namespace :db do
  desc 'Add some random items to the database'
  task make_items: :environment do
    category_count = Category.count
    100.times do
      item = Item.new
      item.name = Faker::Name::title
      item.description = Faker::Lorem::paragraph (rand(30) + 3)
      item.price = (rand(10000) + 100) / 100.0
      item.special_offer = rand(5) == 0
      item.category = Category.find (rand(category_count) + 1)
      item.save!
    end
  end

  desc 'Cleanup old carts and completed orders'
  task cleanup: :environment do
    Cart.where('created_at < ?', 30.days.ago).destroy_all
    Order.where('created_at < ? and completed = ?', 30.days.ago, true).destroy_all
  end
end