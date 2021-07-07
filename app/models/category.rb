class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates_presence_of :name

  BOOK = 'Book'.freeze
  FOOD = 'Food'.freeze
  MEDICAL = 'Medical'.freeze
  OTHER = 'Other'.freeze
end
