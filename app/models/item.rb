class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one_attached :image
  has_one :order

  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipping_day

  # Required fields validation
  with_options presence: { message: "can't be blank" } do
    validates :name
    validates :description
    validates :image
    validates :price
  end

  # ActiveHash ID validation
  with_options presence: true, numericality: { other_than: 0, message: "Please select a valid option" } do
    validates :category_id
    validates :condition_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :shipping_day_id
  end

  # Price validation
  validates :price, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999,
    message: "Price must be between ¥300 and ¥9,999,999"
  }
  
  def sold_out?
    order.present?
  end
end