require 'docker'
class Image < ActiveRecord::Base

  host_config = HostConfig.all[0]
  Docker.url = "http://#{host_config.host}:#{host_config.port}"

  def self.all author
    images = Array.new
    Docker::Image.all.each do |img|
      if author == nil || author == "all"
        images << img
      elsif author == img.info["RepoTags"].to_s.gsub(/\"|\[|\]/, "").split('___')[1].split(':')[0]
        images << img 
      end
    end
    images
  end

  def self.launch image, name
    orca_port = Container.get_free_port
    container = Docker::Container.create('name' => name, 'Image' => image, 
                                         'ExposedPorts' => '8000/tcp', 
                                         'OpenStdin' => true,
                                         'Tty' => true)
    container.stop
    req_json = '{"PortBindings":{ "8000/tcp": [{ "HostPort": "orca_port" }] }}'.gsub(/orca_port/, "#{orca_port}")
    RestClient.post Docker.url + "/containers/#{container.id}/start?name=#{name}", req_json, :content_type => :json, :accept => :json
    #Container.save(container.id.to_s[0..11], author)
  end

  def self.remove imgid
    image = Docker::Image.get(imgid)
    image.remove(:force => true)
  end

end
