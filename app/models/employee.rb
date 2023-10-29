class Employee < ApplicationRecord
  validates :name, presence: true
  validates :level, presence: true, numericality: true
  belongs_to :department
  has_many :employee_tickets
  has_many :tickets, through: :employee_tickets

  def oldest_ticket
    tickets.order(age: :desc).limit(1).pluck(:subject)
  end

  def tickets_by_age
    tickets.order(age: :desc).pluck(:subject)
  end

  def shared_ticket_employees
    tickets.map do |ticket|
      ticket.employees.pluck("employees.name")
    end.flatten.uniq
  end
end