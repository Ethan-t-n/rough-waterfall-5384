require 'rails_helper'

RSpec.describe Supermarket, type: :model do
  describe 'relationships' do
    it { should have_many :customers }
  end

  describe 'instance methods' do
    describe '#top_three' do
      it 'has the top three items for that supermarket' do 
        supermarket_1 = Supermarket.create!(name: "Generic Market", location: "OverThere")

        customer_1 = supermarket_1.customers.create!(name: "James Franco")
        customer_2 = supermarket_1.customers.create!(name: "Frank Jameson")
        customer_3 = supermarket_1.customers.create!(name: "Robert Roberts")
        customer_4 = supermarket_1.customers.create!(name: "Bobby Bobberts")
        customer_5 = supermarket_1.customers.create!(name: "Bill Nye")
        customer_6 = supermarket_1.customers.create!(name: "Hulk Hogan")
        
        cheese = Item.create!(name:"cheese", price: 5000)
        bread = Item.create!(name:"bread", price: 6000)
        wine = Item.create!(name:"wine", price: 7000)
        chips = Item.create!(name:"chips", price: 8000)
        water = Item.create!(name:"water", price: 9000)
        steak = Item.create!(name:"steak", price: 10000)

        CustomerItem.create!(item: cheese, customer: customer_1)
        CustomerItem.create!(item: bread, customer: customer_1)
        CustomerItem.create!(item: steak, customer: customer_1)
        CustomerItem.create!(item: chips, customer: customer_1)
        CustomerItem.create!(item: water, customer: customer_2)
        CustomerItem.create!(item: bread, customer: customer_2)
        CustomerItem.create!(item: wine, customer: customer_2)
        CustomerItem.create!(item: steak, customer: customer_2)
        CustomerItem.create!(item: steak, customer: customer_3)
        CustomerItem.create!(item: bread, customer: customer_3)
        CustomerItem.create!(item: steak, customer: customer_4)
        CustomerItem.create!(item: bread, customer: customer_4)
        CustomerItem.create!(item: water, customer: customer_4)
        CustomerItem.create!(item: steak, customer: customer_5)
        CustomerItem.create!(item: bread, customer: customer_5)
        CustomerItem.create!(item: water, customer: customer_5)
        CustomerItem.create!(item: steak, customer: customer_6)

        expect(supermarket_1.top_three[0].name).to eq("steak")
        expect(supermarket_1.top_three[1].name).to eq("bread")
        expect(supermarket_1.top_three[2].name).to eq("water")
      end 
    end
    describe '#supermarket_items_list' do
      it 'shows the uniq list of items for a supermarket' do 
        supermarket_1 = Supermarket.create!(name: "Generic Market", location: "OverThere")
        supermarket_2 = Supermarket.create!(name: "Unique Market", location: "OverHere")

        customer_1 = supermarket_1.customers.create!(name: "James Franco")
        customer_2 = supermarket_1.customers.create!(name: "Frank Jameson")
        customer_3 = supermarket_1.customers.create!(name: "Robert Roberts")
        customer_4 = supermarket_1.customers.create!(name: "Bobby Bobberts")
        customer_5 = supermarket_1.customers.create!(name: "Bill Nye")
        customer_6 = supermarket_1.customers.create!(name: "Hulk Hogan")
        
        cheese = Item.create!(name:"cheese", price: 5000)
        bread = Item.create!(name:"bread", price: 6000)
        wine = Item.create!(name:"wine", price: 7000)
        chips = Item.create!(name:"chips", price: 8000)
        water = Item.create!(name:"water", price: 9000)
        steak = Item.create!(name:"steak", price: 10000)

        CustomerItem.create!(item: cheese, customer: customer_1)
        CustomerItem.create!(item: bread, customer: customer_1)
        CustomerItem.create!(item: steak, customer: customer_1)
        CustomerItem.create!(item: chips, customer: customer_1)
        CustomerItem.create!(item: water, customer: customer_2)
        CustomerItem.create!(item: bread, customer: customer_2)
        CustomerItem.create!(item: wine, customer: customer_2)
        CustomerItem.create!(item: steak, customer: customer_2)
        CustomerItem.create!(item: steak, customer: customer_3)
        CustomerItem.create!(item: bread, customer: customer_3)
        CustomerItem.create!(item: steak, customer: customer_4)
        CustomerItem.create!(item: bread, customer: customer_4)
        CustomerItem.create!(item: water, customer: customer_4)
        CustomerItem.create!(item: steak, customer: customer_5)
        CustomerItem.create!(item: bread, customer: customer_5)
        CustomerItem.create!(item: water, customer: customer_5)
        CustomerItem.create!(item: steak, customer: customer_6)

        expect(supermarket_1.instock_items.count).to eq(6)
        expect(supermarket_1.instock_items[0].name).to eq("cheese")
        expect(supermarket_1.instock_items[4].name).to eq("water")
      end 
    end
  end
end