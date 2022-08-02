require 'rails_helper'

RSpec.describe 'the customer show page' do
    it 'has a customer show page with a list of itmes and the supermarket they belong to' do
        supermarket_1 = Supermarket.create!(name: "Generic Market", location: "OverThere")
        supermarket_2 = Supermarket.create!(name: "Unique Market", location: "OverHere")

        customer_1 = supermarket_1.customers.create!(name: "James Franco")
        customer_2 = supermarket_2.customers.create!(name: "Frank Jameson")

        customer_1.items.create!(name:"cheese", price: 5000)
        customer_1.items.create!(name:"bread", price: 6000)
        customer_1.items.create!(name:"wine", price: 7000)
        customer_2.items.create!(name:"chips", price: 8000)

        visit "/customers/#{customer_1.id}"

        expect(page).to have_content("James Franco")
        expect(page).to have_content("Generic Market")
        expect(page).to have_content("cheese")
        expect(page).to have_content("bread")
        expect(page).to have_content("wine")

        expect(page).to_not have_content("Unique Market")
        expect(page).to_not have_content("chips")
        expect(page).to_not have_content("Frank Jameson")
    end

    it 'has the total price of all items' do
        supermarket_1 = Supermarket.create!(name: "Generic Market", location: "OverThere")
        supermarket_2 = Supermarket.create!(name: "Unique Market", location: "OverHere")

        customer_1 = supermarket_1.customers.create!(name: "James Franco")
        customer_2 = supermarket_2.customers.create!(name: "Frank Jameson")

        customer_1.items.create!(name:"cheese", price: 5000)
        customer_1.items.create!(name:"bread", price: 6000)
        customer_1.items.create!(name:"wine", price: 7000)
        customer_2.items.create!(name:"chips", price: 8000)

          visit "/customers/#{customer_1.id}"

        expect(page).to have_content("Total cost: $180.00")
    end
end
