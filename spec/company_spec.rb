require 'rails_helper'

describe 'Welcome Screen', type: :system do
  it 'greets the visitor' do
    visit ('/')
    expect(page).to have_content('Welcome to the app')
  end
end

describe 'Listing Companies', type: :system do

  before :each do
    setup_company
  end

  it 'displays a list of companies' do
    visit ('/companies')
    expect(page).to have_content('Dummy Company')
  end
end