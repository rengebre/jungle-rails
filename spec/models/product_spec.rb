require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it "should save successfully" do
      @category = Category.new(name: "Test")
      @product = Product.new(  name: "Timothy", price: 1020, quantity: 10, category: @category)

      @product.save!

      expect(@product.id).to be_present
    end

    it "should not save if name is nil" do
      @category = Category.new(name: "Test")
      @product = Product.new(  name: nil, price: 1020, quantity: 10, category: @category)

      @product.save

      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "should not save if price is nil" do
      @category = Category.new(name: "Test")
      @product = Product.new(  name: "Timothy", price: nil, quantity: 10, category: @category)

      @product.save

      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "should not save if quantity is nil" do
      @category = Category.new(name: "Test")
      @product = Product.new(  name: "Timothy", price: 1020, quantity: nil, category: @category)

      @product.save

      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should not save if category is nil" do
      @category = Category.new(name: "Test")
      @product = Product.new(  name: "Timothy", price: 1020, quantity: 10, category: nil)

      @product.save

      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
