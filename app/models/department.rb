class Department < ApplicationRecord
  validates :name, presence: true
  validates :floor, presence: true
  has_many :employees
end