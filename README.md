# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birth_date         | date   | null: false |


### Association

- has_many :items
- has_many :orders

## items テーブル

| Column          | Type       | Options     |
| ------          | ------     | ----------- |
<!-- | title           | string     | null: false | -->
| name            | string     | null: false |
| description     | text       | null: false |
| category_id     | integer    | null: false |
| condition_id    | integer    | null: false |
| shipping_fee_id | integer    | null: false |
| prefecture_id   | integer    | null: false |
| shipping_day_id | integer    | null: false |
| price           | integer    | null: false |
| user            | references | null: false, foreign_key: true |

※ `image` は ActiveStorage を使うため、DBカラムには含めません。
### Association

- belongs_to :user
- has_one :order
<!-- - has_one_attached :image -->

## orders テーブル

| Column    | Type       | Options                        |
| -------   | ---------- | ------------------------------ |
| item      | references | null: false, foreign_key: true |
| user      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address


## addresses テーブル

| Column        | Type       | Options                        |
| -------       | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| street_line   | string     | null: false                    |
| building      | string     |                                |
| phone_number  | string     | null: false                    |
| order         | references | null: false, foreign_key: true |

### Association

- belongs_to :order
