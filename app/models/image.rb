require 'docker'
class Image < ActiveRecord::Base

  host_config = HostConfig.all[0]
  Docker.url = "http://#{host_config.host}:#{host_config.port}"

  def self.all
    images = Docker::Image.all
  end

  def self.launch image, name, author
    orca_port = Container.get_free_port
    container = Docker::Container.create('name' => name, 'Image' => image, 
                                         'ExposedPorts' => '8000/tcp', 
                                         'OpenStdin' => true,
                                         'Tty' => true)
    container.stop
    req_json = '{"PortBindings":{ "8000/tcp": [{ "HostPort": "orca_port" }] }}'.gsub(/orca_port/, "#{orca_port}")
    RestClient.post Docker.url + "/containers/#{container.id}/start?name=#{name}", req_json, :content_type => :json, :accept => :json
    Container.save(container.id.to_s[0..11], author)
  end

  def self.remove imgid
    image = Docker::Image.get(imgid)
    image.remove(:force => true)
  end

end
