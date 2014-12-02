class ContainersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_container, only: [:show, :edit, :update, :destroy]

  # GET /containers
  # GET /containers.json
  def index
    @containers = Container.all_on_host
    @clist = Container.all
  end

  def start
    Container.start(params["cid"])
    redirect_to containers_path
  end

  def stop
    Container.stop(params["cid"])
    redirect_to containers_path
  end

  def remove
    cid = params["cid"]
    Container.remove(cid)
    container = Container.find_by(container_id: cid[0..11])
    container.destroy
    redirect_to containers_path
  end

  def commit
    Container.commit_as_another(params["cid"])
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
