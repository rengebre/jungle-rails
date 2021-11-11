class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: "Jungle", password: "Book"

  def show
    @product_count = Product.count(:all)
    @category_count = Category.count(:all)
  end
end
