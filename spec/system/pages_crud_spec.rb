require 'rails_helper'

require_relative '../helpers/test_seeds'

RSpec.describe 'Pages CRUD', type: :system do
  before do
    create_categories_and_products
  end

  it 'Should upload and display the file' do
    visit root_path
    find('form input[type="file"]').set("#{Rails.root}/spec/system/basket_3.txt")
    click_button 'Submit'

    content = ['1 imported bottle of perfume: 27.99',
               '1 bottle of perfume: 18.99',
               '1 box of imported chocolates: 11.25',
               'Sales Taxes: 6.7',
               'Total: 74.68']

    content.each do |string|
      expect(page).to have_content string
    end
  end
end
