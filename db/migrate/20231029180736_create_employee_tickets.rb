class CreateEmployeeTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :employee_tickets do |t|

      t.timestamps
    end
  end
end
