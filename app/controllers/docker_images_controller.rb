class DockerImagesController < ApplicationController
  before_action :set_docker_image, only: [:show, :edit, :update, :destroy]

  # GET /docker_images
  # GET /docker_images.json
  def index
    @docker_images = DockerImage.all
  end

  def launch
    image = params["image"]
    DockerImage.launch(image)
    redirect_to docker_containers_path
  end

  def remove
    imgid = params["imgid"]
    DockerImage.remove(imgid)
    redirect_to docker_images_path
  end

  # GET /docker_images/1
  # GET /docker_images/1.json
  def show
  end

  # GET /docker_images/new
  def new
    @docker_image = DockerImage.new
  end

  # GET /docker_images/1/edit
  def edit
  end

  # POST /docker_images
  # POST /docker_images.json
  def create
    @docker_image = DockerImage.new(docker_image_params)

    respond_to do |format|
      if @docker_image.save
        format.html { redirect_to @docker_image, notice: 'Docker image was successfully created.' }
        format.json { render action: 'show', status: :created, location: @docker_image }
      else
        format.html { render action: 'new' }
        format.json { render json: @docker_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /docker_images/1
  # PATCH/PUT /docker_images/1.json
  def update
    respond_to do |format|
      if @docker_image.update(docker_image_params)
        format.html { redirect_to @docker_image, notice: 'Docker image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @docker_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /docker_images/1
  # DELETE /docker_images/1.json
  def destroy
    @docker_image.destroy
    respond_to do |format|
      format.html { redirect_to docker_images_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_docker_image
      @docker_image = DockerImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def docker_image_params
      params[:docker_image]
    end
end
