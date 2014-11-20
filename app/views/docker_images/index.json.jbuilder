json.array!(@docker_images) do |docker_image|
  json.extract! docker_image, :id
  json.url docker_image_url(docker_image, format: :json)
end
