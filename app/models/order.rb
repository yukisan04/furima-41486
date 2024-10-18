class Order < ApplicationRecord
  attr_accessor :token
  belongs_to    :user
  belongs_to    :item
  has_one       :address
  validates     :token, presence: true
  validates     :price, presence: true
end
