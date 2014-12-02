class ImagesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /images
  # GET /images.json
  def index
    @images = Image.all
  end

  def launch
    image = params["image_name"]
    container_name = params["container_name"]
    Image.launch(image, container_name)
    redirect_to containers_path
  end

  def remove
    imgid = params["image_id"]
    Image.remove(imgid)
    redirect_to images_path
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
