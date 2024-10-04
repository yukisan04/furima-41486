## 機能一覧
- データベース設計
- ユーザー管理機能
- 商品出品機能
- 商品一覧表示機能
- 商品詳細表示機能
- 商品情報編集機能
- 商品購入機能
- 商品削除機能

# テーブル設計

## users テーブル
| Column             | Type      | Options
| -------------------| ----------| -------------------------
| nickname           | string    | null: false
| email              | string    | null: false, unique: true
| encrypted_password | string    | null: false
| family_name        | string    | null:false
| first_name         | string    | null:false
| family_name_kana   | string    | null:false
| first_name_kana    | string    | null:false
| birth              | date      | null:false

### Association
- has_many :items, dependent: :destroy
- has_many :orders
- has_one :addresses, dependent: :destroy

# items テーブル
| Column           | Type      | Options
| -----------------| ----------| -----------------
| user             | reference | foreign_key: true
| name             | string    | null: false
| content          | text      | null: false
| price            | integer   | null: false
| category_id      | integer   | foreign_key: true
| condition_id     | integer   | foreign_key: true
| shipping_fee_id  | integer   | foreign_key: true
| shipping_area_id | integer   | foreign_key: true
| shipping_date_id | integer   | foreign_key: true

### Association
- belongs_to :user
- has_one :order

# orders テーブル
| Column        | Type      | Options
| --------------| ----------| -----------------
| user          | reference | foreign_key: true
| item          | reference | foreign_key: true

### Association
- belongs_to :user
- belongs_to :item
- has_one :addresses

# addresses テーブル
| Column        | Type      | Options
| --------------| ----------| -----------------
| city          | string    | null: false
| post_code     | string    | null: false
| house_number  | string    | null: false
| phone_number  | string    | null: false
| prefecture_id | integer   | null: false
| order         | reference | foreign_key: true
| building_name | string    |

### Association
- belongs_to :order

# ER図
![ER図](https://github.com/user-attachments/assets/a37fce4b-1704-410b-af5b-01f0f7b0af26)