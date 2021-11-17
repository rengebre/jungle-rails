require 'rails_helper'

RSpec.feature "ProductAddToCarts", type: :feature, js: true do
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
  
    scenario "Product will be added to cart when Add button clicked" do
      # ACT
      visit root_path
      
      # Check My Cart is empty
      expect(page.find('ul.navbar-right')).to have_content("My Cart (0)")
      
      # Click on Add button for a product
      page.all('article.product')[2].find('footer').click_on("Add")

      # Check My Cart has been updated to 1
      expect(page.find('ul.navbar-right')).to have_content("My Cart (1)")
    end
end