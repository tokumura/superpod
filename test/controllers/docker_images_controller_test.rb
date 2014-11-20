require 'test_helper'

class DockerImagesControllerTest < ActionController::TestCase
  setup do
    @docker_image = docker_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:docker_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create docker_image" do
    assert_difference('DockerImage.count') do
      post :create, docker_image: {  }
    end

    assert_redirected_to docker_image_path(assigns(:docker_image))
  end

  test "should show docker_image" do
    get :show, id: @docker_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @docker_image
    assert_response :success
  end

  test "should update docker_image" do
    patch :update, id: @docker_image, docker_image: {  }
    assert_redirected_to docker_image_path(assigns(:docker_image))
  end

  test "should destroy docker_image" do
    assert_difference('DockerImage.count', -1) do
      delete :destroy, id: @docker_image
    end

    assert_redirected_to docker_images_path
  end
end
