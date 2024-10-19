class UserOrder

  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id
    validates :city
    validates :house_number
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is 10 or 11 digit numbers' }
    validates :user_id
    validates :item_id
    validates :token
  end

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end