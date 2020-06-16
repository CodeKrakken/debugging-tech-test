require 'rails_helper'

describe 'Welcome Screen', type: :system do
  it 'greets the visitor' do
    visit ('/')
    expect(page).to have_content('Welcome to the app')
  end
end