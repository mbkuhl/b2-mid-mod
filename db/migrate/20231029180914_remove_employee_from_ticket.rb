class RemoveEmployeeFromTicket < ActiveRecord::Migration[7.0]
  def change
    remove_reference :tickets, :employee, null: false, foreign_key: true
  end
end
