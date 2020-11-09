class Cart < ApplicationRecord
  belongs_to :user
  has_many :order_items, optional: true
  validates :user_id, presence: true, uniqueness: true
end
