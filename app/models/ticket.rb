class Ticket < ApplicationRecord
  validates :subject, presence: true
  validates :age, presence: true, numericality: true
  has_many :employee_tickets
  has_many :employees, through: :employee_tickets
end