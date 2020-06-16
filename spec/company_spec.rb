feature 'Company details' do
  scenario 'See details of existing company' do
    visit('/')
    expect(page).to have_content('Minnie Mouse')
  end
end