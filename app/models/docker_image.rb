require 'docker'
require "rest_client"

class DockerImage < ActiveRecord::Base

  host_config = HostConfig.all[0]
  Docker.url = "http://#{host_config.host}:#{host_config.port}"

  def self.all
    images = Docker::Image.all
  end

  def self.launch image
    orca_port = DockerContainer.get_port_num
    puts "$$$$$$$$$$$$"
    puts "next free port : " + orca_port.to_s
    puts "$$$$$$$$$$$$"
    container = Docker::Container.create('Image' => image, 
                                         'ExposedPorts' => '8000/tcp', 
                                         'OpenStdin' => true,
                                         'Tty' => true)
    container.stop
    req_json = '{"PortBindings":{ "8000/tcp": [{ "HostPort": "orca_port" }] }}'.gsub(/orca_port/, "#{orca_port}")
    RestClient.post Docker.url + "/containers/#{container.id}/start", req_json, :content_type => :json, :accept => :json
  end

  def self.remove imgid
    image = Docker::Image.get(imgid)
    image.remove(:force => true)
  end
end
