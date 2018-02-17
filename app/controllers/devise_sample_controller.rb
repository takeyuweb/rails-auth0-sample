class DeviseSampleController < ApplicationController
  before_action :authenticate_devise_user!

  def show
  end
end
