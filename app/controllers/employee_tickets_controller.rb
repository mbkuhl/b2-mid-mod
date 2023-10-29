class EmployeeTicketsController < ApplicationController

  def new
    EmployeeTicket.create!(
      employee_id: params[:id],
      ticket_id: params[:add_ticket]
    )
    redirect_to "/employees/#{params[:id]}"
  end
end