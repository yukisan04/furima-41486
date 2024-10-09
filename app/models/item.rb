class Item < ApplicationRecord
  with_options presence: true do
    validates :user
    validates :name
    validates :content
    validates :price
    validates :category_id
    validates :condition_id
    validates :shipping_fee_id
    validates :shipping_date_id
    validates :prefecture_id
  end

  validates :price, numericality: { only_integer: true, greater_than: 300, less_than: 9999999 }
  belongs_to :user
end
