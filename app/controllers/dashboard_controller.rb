class DashboardController < ApplicationController
  include Secured

  def show
    @devise_user = devise_user
  end
end
