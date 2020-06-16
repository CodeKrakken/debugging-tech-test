def setup_company
  visit ('/companies/new')
  fill_in('Name', with: 'Dummy Company')
  fill_in('Details', with: 'None')
  click_button('Save')
end