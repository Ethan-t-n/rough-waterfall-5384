require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customer_items }
    it { should have_many(:items).through(:customer_items) }
  end


  describe 'instance methods' do
    describe '#total_cost' do
      it 'calculates the total cost of all items for a customer' do
        supermarket_1 = Supermarket.create!(name: "Generic Market", location: "OverThere")
        customer_1 = supermarket_1.customers.create!(name: "James Franco")

        customer_1.items.create!(name:"cheese", price: 5000)
        customer_1.items.create!(name:"bread", price: 6000)
        customer_1.items.create!(name:"wine", price: 7000)

        expect(customer_1.total_cost).to eq(18000)
      end
    end
  end
end
