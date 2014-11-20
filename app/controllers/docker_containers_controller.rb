require 'json'

class DockerContainersController < ApplicationController
  before_action :set_docker_container, only: [:show, :edit, :update, :destroy]

  # GET /docker_containers
  # GET /docker_containers.json
  def index
    @docker_containers = DockerContainer.all
  end

  def start
    DockerContainer.start(params["cid"])
    redirect_to docker_containers_path
  end

  def stop
    DockerContainer.stop(params["cid"])
    redirect_to docker_containers_path
  end

  def remove
    DockerContainer.remove(params["cid"])
    redirect_to docker_containers_path
  end

  def commit
    DockerContainer.commit_as_another(params["cid"])
    redirect_to docker_images_path
  end

  # GET /docker_containers/1
  # GET /docker_containers/1.json
  def show
  end

  # GET /docker_containers/new
  def new
    @docker_container = DockerContainer.new
  end

  # GET /docker_containers/1/edit
  def edit
  end

  # POST /docker_containers
  # POST /docker_containers.json
  def create
    @docker_container = DockerContainer.new(docker_container_params)

    respond_to do |format|
      if @docker_container.save
        format.html { redirect_to @docker_container, notice: 'Docker container was successfully created.' }
        format.json { render action: 'show', status: :created, location: @docker_container }
      else
        format.html { render action: 'new' }
        format.json { render json: @docker_container.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /docker_containers/1
  # PATCH/PUT /docker_containers/1.json
  def update
    respond_to do |format|
      if @docker_container.update(docker_container_params)
        format.html { redirect_to @docker_container, notice: 'Docker container was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @docker_container.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /docker_containers/1
  # DELETE /docker_containers/1.json
  def destroy
    @docker_container.destroy
    respond_to do |format|
      format.html { redirect_to docker_containers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_docker_container
      @docker_container = DockerContainer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def docker_container_params
      params[:docker_container]
    end
end
