class AddRefToEmployeeTickets < ActiveRecord::Migration[7.0]
  def change
    add_reference :employee_tickets, :employee, null: false, foreign_key: true
    add_reference :employee_tickets, :ticket, null: false, foreign_key: true
  end
end
