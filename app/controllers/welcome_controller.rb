class WelcomeController < ApplicationController
  before_filter :authenticate_user!
  def index
    if HostConfig.all.size > 0
      @move_to = images_path
    else
      @move_to = host_configs_path
    end
    
    redirect_to images_path
  end
end
