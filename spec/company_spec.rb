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
    find("a[href='#{'/companies/4/employees'}']").click
    expect(page).to have_content('Fabian')
  end

  it 'stores and displays employee edits correctly' do
    visit ('/companies/3/employees')
    find("a[href='#{'/companies/3/employees/9/edit'}']").click
    fill_in('Surname', with: 'Pugwash')
    click_button('Save')
    expect(page).to have_content('Pugwash')
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