json.array!(@docker_containers) do |docker_container|
  json.extract! docker_container, :id
  json.url docker_container_url(docker_container, format: :json)
end
