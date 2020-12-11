class OrderItem < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :order, optional: true
  belongs_to :product
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :product_name, presence: true
  attr_accessor :picture
  mount_base64_uploader :picture, PictureUploader
  
  default_scope { order('id ASC') }
end
