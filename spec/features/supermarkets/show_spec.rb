require 'rails_helper'

RSpec.describe 'the supermarket show page' do
    it 'has a show page with the name and a link to view all of the items the supermarket has' do
        supermarket_1 = Supermarket.create!(name: "Generic Market", location: "OverThere")
        supermarket_2 = Supermarket.create!(name: "Unique Market", location: "OverHere")

        customer_1 = supermarket_1.customers.create!(name: "James Franco")
        customer_2 = supermarket_1.customers.create!(name: "Frank Jameson")
        customer_3 = supermarket_2.customers.create!(name: "Robert Roberts")

        cheese = Item.create!(name:"cheese", price: 5000)
        bread = Item.create!(name:"bread", price: 6000)
        wine = Item.create!(name:"wine", price: 7000)
        chips = Item.create!(name:"chips", price: 8000)
        water = Item.create!(name:"water", price: 9000)
        steak = Item.create!(name:"steak", price: 10000)

        CustomerItem.create!(item: cheese, customer: customer_1)
        CustomerItem.create!(item: bread, customer: customer_1)
        CustomerItem.create!(item: wine, customer: customer_1)
        CustomerItem.create!(item: chips, customer: customer_1)
        CustomerItem.create!(item: water, customer: customer_2)
        CustomerItem.create!(item: chips, customer: customer_2)
        CustomerItem.create!(item: wine, customer: customer_2)
        CustomerItem.create!(item: steak, customer: customer_3)

        visit "/supermarkets/#{supermarket_1.id}"

        expect(page).to have_content("Generic Market")
        expect(page).to have_content("View all items")

        click_link("View all items")

        expect(current_path).to eq("/supermarkets/#{supermarket_1.id}/items")

        expect(page).to have_content("cheese", count: 1)
        expect(page).to_not have_content("bread", count: 2)
        expect(page).to have_content("bread", count: 1)
        expect(page).to have_content("wine", count: 1)
        expect(page).to_not have_content("wine", count: 2)
        expect(page).to have_content("chips", count: 1)
        expect(page).to have_content("water", count: 1)
        expect(page).to_not have_content("steak")
    end
  end
