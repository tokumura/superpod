require 'docker'
class Container < ActiveRecord::Base

  host_config = HostConfig.all[0]
  Docker.url = "http://#{host_config.host}:#{host_config.port}"

  def self.all_on_host author
    cons = Array.new
    Docker::Container.all(:all => true).each do |c|
      if author == nil || author == "all"
        cons << c
      elsif author == c.json["Name"].gsub(/\//, "").split('___')[1]
        cons << c
      end
    end
    cons
  end

  def self.get_free_port
    cons = Docker::Container.all(:all => true)
    using_ports = Array.new

    cons.each do |c|
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
    container = Docker::Container.get(cid)
    container.start
  end

  def self.stop cid
    container = Docker::Container.get(cid)
    container.stop
  end

  def self.remove cid
    container = Docker::Container.get(cid)
    container.delete(:force => true)
  end

  def self.commit_as_another cid, image_name, overwrite, author
    container = Docker::Container.get(cid)
    if overwrite
      image_name = container.json["Config"]["Image"].split(':')[0]
    end
    image_name = image_name + "___" + author
    url = "#{Docker.url}/commit?container=#{container.id}&repo=#{image_name}&tag=latest"
    RestClient.post(url, "{}", :content_type => :json, :accept => :json)
  end

  def self.get_state_word status
    state = Hash["en" => "stopped", "ja" => "停止中"]
    if status == "true"
      state = Hash["en" => "running", "ja" => "起動中"]
    end
    state
  end

  def self.get_state_color status
    color = "#FF7548"
    if status == "true"
      color = "#70D53C"
    end
    color
  end
end
