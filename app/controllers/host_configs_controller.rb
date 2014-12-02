class HostConfigsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_host_config, only: [:show, :edit, :update, :destroy]

  # GET /host_configs
  # GET /host_configs.json
  def index
    @host_configs = HostConfig.all
  end

  # GET /host_configs/1
  # GET /host_configs/1.json
  def show
  end

  # GET /host_configs/new
  def new
    @host_config = HostConfig.new
  end

  # GET /host_configs/1/edit
  def edit
  end

  # POST /host_configs
  # POST /host_configs.json
  def create
    @host_config = HostConfig.new(host_config_params)

    respond_to do |format|
      if @host_config.save
        format.html { redirect_to @host_config, notice: 'Host config was successfully created.' }
        format.json { render action: 'show', status: :created, location: @host_config }
      else
        format.html { render action: 'new' }
        format.json { render json: @host_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /host_configs/1
  # PATCH/PUT /host_configs/1.json
  def update
    respond_to do |format|
      if @host_config.update(host_config_params)
        format.html { redirect_to @host_config, notice: 'Host config was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @host_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /host_configs/1
  # DELETE /host_configs/1.json
  def destroy
    @host_config.destroy
    respond_to do |format|
      format.html { redirect_to host_configs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_host_config
      @host_config = HostConfig.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def host_config_params
      params.require(:host_config).permit(:host, :port)
    end
end
