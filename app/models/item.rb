class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to :user
  has_one :order
  has_one_attached :image

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

  # Price full-width character validation (先に評価)
  validate :price_must_be_half_width

  # Price validation
  validates :price, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999,
    message: "Price must be between ¥300 and ¥9,999,999"
  }, if: -> { price_before_type_cast.to_s.match?(/\A\d+\z/) } 

  def price_must_be_half_width
    input_price = price_before_type_cast.to_s
    if input_price.match?(/[^\d]/)
      errors.add(:base, "Price must be in half-width numbers")
      return
    end
  end
end