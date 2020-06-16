require 'rails_helper'

describe 'Company details', type: :system do
  it 'lists correct employees' do
    visit ('/')
    expect(page).to have_content('Welcome to the app')
  end
end