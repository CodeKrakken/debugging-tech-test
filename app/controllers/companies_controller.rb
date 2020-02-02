# frozen_string_literal: true

class CompaniesController < ApplicationController

  def index
    @company = Company.all
  end

  def show
    @company = Company.find(permitted_params[:id])
    @company = Company.first
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(permitted_params[:company])

    if @company.save
      redirect_to @company
    else
      render 'new'
    end
  end

  def destroy
    @company = Company.find(permitted_params[:id])
    @company.destroy

    redirect_to companies_path
  end

  private

  def permitted_params
    params.permit!
  end
end
