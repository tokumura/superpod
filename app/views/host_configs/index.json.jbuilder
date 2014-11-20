json.array!(@host_configs) do |host_config|
  json.extract! host_config, :id, :host, :port
  json.url host_config_url(host_config, format: :json)
end
