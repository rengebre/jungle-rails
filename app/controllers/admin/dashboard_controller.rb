class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']

  def show
    # puts ENV['ADMIN_USERNAME']
    @product_count = Product.count(:all)
    @category_count = Category.count(:all)
  end
end
