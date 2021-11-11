class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: "Jungle", password: "Book"

  def show
  end
end
