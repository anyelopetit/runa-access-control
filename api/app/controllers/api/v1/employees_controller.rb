# frozen_string_literal: true

# Controller for employees
class Api::V1::EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_employee, only: %i[show]
  before_action :current_page

  include Renders

  # Action to get all employees
  def index
    policy.index?
    employees = Employee.all.page(@current_page)
    employees = employees.reject { |a| a.eql?(current_user) }
    success(employees)
  end

  # Action to create a employee
  def create
    policy.create?
    employee = Employee.new(employee_params)

    if employee.save
      current_user.register(employee)
      created(employee)
    else
      unprocessable_entity(employee.errors)
    end
  end

  # Action to show an employee
  def show
    policy.show?
    success(@employee)
  end

  private

  # Function to get current page
  def current_page
    @current_page = params[:page]
  end

  # Set an administrator
  def set_employee
    @employee = Employee.find(params[:id])
  rescue StandardError
    no_found("Couldn't find Employee with 'id'=#{params[:id]}")
  end

  # Permissions to users
  def policy
    @policy ||= EmployeePolicy.new(user: current_user)
  end

  # Params object permit
  def employee_params
    params.require(:employee).permit(
      :name, :email, :password, :position
    )
  end
end