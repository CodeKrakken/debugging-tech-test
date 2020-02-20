class Company < ApplicationRecord
  has_many :employees, dependent: :destroy
  accepts_nested_attributes_for :employees
end

