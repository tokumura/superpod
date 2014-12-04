class ContainersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_container, only: [:show, :edit, :update, :destroy]

  # GET /containers
  # GET /containers.json
  def index
    author = params["author"]
    if author
      @selected_user = author
    else
      @selected_user = all
    end
    @users = Array.new
    User.all.each do |u|
      @users << u.email[0..u.email.index('@')-1] 
    end
    @host = HostConfig.all[0].host
    @containers = Container.all_on_host(author)
  end

  def start
    author = params["author"]
    Container.start(params["cid"])
    redirect_to containers_path + "?author=" + author
  end

  def stop
    author = params["author"]
    Container.stop(params["cid"])
    redirect_to containers_path + "?author=" + author
  end

  def remove
    cid = params["cid"]
    Container.remove(cid)
    redirect_to containers_path
  end

  def commit
    cid = params["save_cid"]
    image_name = params["image_name"]
    Container.commit_as_another(cid, image_name)
    redirect_to images_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_container
      @container = Container.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def container_params
      params[:container]
    end
end
