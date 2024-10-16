class UserOrder
  include ActiveModel::Model
  attr_accessor :city, :post_code, :prefecture_id, :house_number, :building_name, :phone_number

  with options presence: true do
    validates :city
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id
    validates :house_number
    validates :phone_number
  end

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
end