class Product < ApplicationRecord
  belongs_to :category
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  attr_accessor :picture
  mount_base64_uploader :picture, PictureUploader 
end
