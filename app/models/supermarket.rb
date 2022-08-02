class Supermarket < ApplicationRecord
  has_many :customers

  def top_three
    customers.joins(:items).select('items.*, COUNT(items.*) AS count').group('items.id').order('count desc').limit(3)
  end 

  def instock_items 
    customers.joins(:items).select('items.*').distinct
  end 
end