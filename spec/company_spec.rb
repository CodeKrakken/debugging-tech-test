require 'rails_helper'

describe 'Welcome Screen', type: :system do
  it 'greets the visitor' do
    visit ('/')
    expect(page).to have_content('Welcome to the app')
  end
end

describe 'Listing Companies', type: :system do
  it 'displays a list of companies' do
    visit ('/companies')
    expect(page).to have_content('Mickeys Plaice')
  end
end

describe 'Listing Employees', type: :system do
  it 'displays the correct company details' do
    visit ('/companies')
    find("a[href='/companies/4/employees']").click
    expect(page).to have_content('Fabian')
  end

  it 'stores and displays employee edits correctly' do
    visit ('/companies/3/employees')
    find("a[href='/companies/3/employees/9/edit']").click
    fill_in('Surname', with: 'Spengler')
    click_button('Save')
    expect(page).to have_content('Spengler')
  end

  it 'saves and displays a new employee' do
    visit ('companies/2/employees/new')
    fill_in('Forename', with: 'Gomez')
    fill_in('Surname', with: 'Addams')
    click_button('Save')
    expect(page).to have_content('Gomez Addams')
  end
end

describe 'Creating a company', type: :system do
  it 'displays the correct company upon saving' do
    visit('/companies/new')
    fill_in('Name', with: "Dummy's Dummies")
    fill_in('Details', with: 'Dummies, Dummy.')
    click_button('Save')
    expect(page).to have_content("Dummy's Dummies")
  end
end