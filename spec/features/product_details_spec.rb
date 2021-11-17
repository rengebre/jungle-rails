require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
    # SETUP
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

  scenario "The product show page renders when a product link is clicked on from the home page" do
    # ACT
    visit root_path

    page.all('article.product')[0].find('header').click
    
    expect(page).to have_css 'section.products-show'
  end

end
