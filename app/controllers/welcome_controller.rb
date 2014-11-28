class WelcomeController < ApplicationController
  before_filter :authenticate_user!
  def index
    redirect_to images_path
  end
end
