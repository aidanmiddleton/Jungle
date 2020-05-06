require 'rails_helper'

RSpec.feature "Visitor navigates to product page upon clicking link on home page", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see product description and quantity" do
    # ACT
    visit root_path
    page.find('.product', match: :first).first('a').click

    # debug
    # save_screenshot
  
    # VERIFY
    expect(page).to have_content "Description", wait: 10 
    expect(page).to have_content "Quantity", wait: 10 
    expect(page).to have_content "Price", wait: 10
  
  end

end
