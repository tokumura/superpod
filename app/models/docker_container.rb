require 'docker'

class DockerContainer < ActiveRecord::Base

  host_config = HostConfig.all[0]
  Docker.url = "http://#{host_config.host}:#{host_config.port}"

  def self.all
    cons = Docker::Container.all(:all => true)
    cons
  end

  def self.get_port_num
    cons = Docker::Container.all(:all => true)
    using_ports = Array.new
    cons.each do |c|
      puts "################"
      puts c.json["HostConfig"]["PortBindings"]["8000/tcp"]
      using_ports << c.json["HostConfig"]["PortBindings"]["8000/tcp"][0]["HostPort"].to_i
      puts "################"
    end

    free = 8000
    using_ports.each do |port|
      (8001..9999).each do |i|
        free = i if port != i
        break
      end
    end
    puts free
    free
  end

  def self.start cid
    container = Docker::Container.get(cid)
    req_json = '{"PortBindings":{ "8000/tcp": [{ "HostPort": "8888" }] }}'
    RestClient.post Docker.url + "/containers/#{container.id}/start", req_json, :content_type => :json, :accept => :json
  end

  def self.stop cid
    container = Docker::Container.get(cid)
    container.stop
  end

  def self.remove cid
    container = Docker::Container.get(cid)
    container.delete(:force => true)
  end

  def self.commit_as_another cid
    container = Docker::Container.get(cid)
    req_json = '{}'
    RestClient.post Docker.url + "/commit?container=#{container.id}&repo=tokumura/orca_c", req_json, :content_type => :json, :accept => :json
  end

end
