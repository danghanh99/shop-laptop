class Product < ApplicationRecord
  belongs_to :category
  validates :name, presence: true
  has_many :order_items, dependent: :destroy
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  attr_accessor :picture
  mount_base64_uploader :picture, PictureUploader

  scope :product_name, ->(search) { where('name ILIKE :search', search: "%#{search}%") if search }

  def self.search(params)
    Product.includes(:category).product_name(params[:search])
  end
end
