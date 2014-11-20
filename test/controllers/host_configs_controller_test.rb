require 'test_helper'

class HostConfigsControllerTest < ActionController::TestCase
  setup do
    @host_config = host_configs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:host_configs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create host_config" do
    assert_difference('HostConfig.count') do
      post :create, host_config: { host: @host_config.host, port: @host_config.port }
    end

    assert_redirected_to host_config_path(assigns(:host_config))
  end

  test "should show host_config" do
    get :show, id: @host_config
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @host_config
    assert_response :success
  end

  test "should update host_config" do
    patch :update, id: @host_config, host_config: { host: @host_config.host, port: @host_config.port }
    assert_redirected_to host_config_path(assigns(:host_config))
  end

  test "should destroy host_config" do
    assert_difference('HostConfig.count', -1) do
      delete :destroy, id: @host_config
    end

    assert_redirected_to host_configs_path
  end
end
