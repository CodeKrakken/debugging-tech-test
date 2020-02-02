# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_action :find_company
  before_action :set_employee, only: %i[show edit update destroy]

  def index
    @employees = @company.employees
  end

  def show; end

  def new
    @employee = @company.employees.build
  end

  def edit; end

  def create
    @employee = @company.employees.build(permitted_params[:employee])
    if @employee.save
      redirect_to company_employees_path(@company)
    else
      render 'new'
    end
  end

  def update
    if @employee.update(forename: permitted_params[:forename],
                        surname: permitted_params[:surname])
      redirect_to company_employees_path(@company)
    else
      render 'edit'
    end
  end

  def destroy
    @employee.destroy
    redirect_to company_employees_path(@company)
  end

  private

  def set_employee
    @employee = Employee.find(permitted_params[:id])
  end

  def permitted_params
    params.permit!
  end

  def find_company
    @company = Company.find(permitted_params[:company_id])
  end
end
