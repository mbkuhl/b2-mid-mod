class EmployeeTicket < ApplicationRecord
  belongs_to :ticket
  belongs_to :employee

end