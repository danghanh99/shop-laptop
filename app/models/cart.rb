class Cart < ApplicationRecord
  belongs_to :user
  has_many :order_items
  validates :user_id, presence: true, uniqueness: true
end
