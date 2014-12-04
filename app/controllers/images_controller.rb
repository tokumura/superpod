class ImagesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /images
  # GET /images.json
  def index
    author = params["author"]
    if author
      @selected_user = author
    else
      @selected_user = User.get_account(current_user.email)
      author = @selected_user
    end
    @users = Array.new
    User.all.each do |u|
      @users << u.email[0..u.email.index('@')-1] 
    end
    @images = Image.all(author)
  end

  def launch
    image = params["image_name"]
    author = current_user.email[0..current_user.email.index('@')-1]
    container_name = params["container_name"] + "___" + author
    Image.launch(image, container_name)
    redirect_to containers_path + "?author=" + author
  end

  def remove
    imgid = params["image_id"]
    author = params["author"]
    Image.remove(imgid)
    redirect_to images_path + "?author=#{author}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params[:image]
    end
end
