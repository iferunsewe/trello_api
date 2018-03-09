class List < ApplicationRecord
  has_many :cards, dependent: :destroy
  validates_presence_of :name
end
