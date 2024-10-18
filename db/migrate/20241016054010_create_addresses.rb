class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string     :city,           null:false
      t.string     :post_code,      null:false
      t.string     :house_number,   null:false
      t.string     :phone_number,   null:false
      t.integer    :prefecture_id,  null:false
      t.references :order,          foreign_key: true, null: false
      t.string     :building_name
      t.timestamps
    end
  end
end
