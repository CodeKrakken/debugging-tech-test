# frozen_string_literal: true

class Employee < ApplicationRecord
  belongs_to :company
  validates :forename, :surname, :middlename, presence: true
end
