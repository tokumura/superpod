class Container < ActiveRecord::Base

  host_config = HostConfig.all[0]
  Docker.url = "http://#{host_config.host}:#{host_config.port}"

  def self.all
    cons = Docker::Container.all(:all => true)
    cons
  end

  def self.get_free_port
    cons = Docker::Container.all(:all => true)
    using_ports = Array.new

    cons.each do |c|
      puts c.json["Name"].to_s + " : " + c.json["HostConfig"]["PortBindings"].to_s
      using_ports << c.json["HostConfig"]["PortBindings"]["8000/tcp"][0]["HostPort"].to_i
    end
    using_ports.sort!

    free = 8000
    (8001..9999).each do |i|
      if using_ports.include?(i) == false
        free = i
        break
      end
    end
    free
  end

  def self.start cid
    orca_port = Container.get_free_port
    container = Docker::Container.get(cid)
    req_json = '{"PortBindings":{ "8000/tcp": [{ "HostPort": "orca_port" }] }}'.gsub(/orca_port/, "#{orca_port}")
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
    uid = Time.now.strftime("%Y%m%d%H%M%S")
    req_json = '{}'
    RestClient.post Docker.url + "/commit?container=#{container.id}&repo=tokumura/orca_#{uid}", req_json, :content_type => :json, :accept => :json
  end

  def self.get_state_word status
    puts "########"
    puts status
    puts "########"
    word = "stopped" 
    if status == "true"
      word = "running"
    end
    word
  end

  def self.get_state_color status
    color = "#FF7548"
    if status == "true"
      color = "#70D53C"
    end
    color
  end
end
