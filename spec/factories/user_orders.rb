FactoryBot.define do
  factory :user_order do
    post_code { '111-1111' }
    prefecture_id { Faker::Number.within(range: 2..48) }
    city { '大阪市' }
    house_number { '11-11' }
    building_name { 'スカイビル' }
    phone_number { '09000000000' }
    association :user
    association :item
    token {"tok_abcdefghijk00000000000000000"}
  end
end