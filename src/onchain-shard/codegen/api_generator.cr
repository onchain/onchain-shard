class APIGenerator

  def self.generate_api(yml : YAML::Any)
  
    tags = Hash(String, Array(YAML::Any)).new
    tags_path = Hash(String, Array(String)).new
    
    yml["paths"].as_h.each do |key, value|
      
      case value.raw
      when Hash
        
        is_post = true if value["post"]? != nil
        
        tag_name = is_post ? value["post"]["tags"].as_a.first.to_s :
          value["get"]["tags"].as_a.first.to_s
      
        if tags[tag_name]? == nil
          tags[tag_name] = Array(YAML::Any).new
        end
        tags[tag_name] << (is_post ? value["post"] : value["get"])
        
        if tags_path[tag_name]? == nil
          tags_path[tag_name] = Array(String).new
        end
        tags_path[tag_name] << key.to_s + ":" + is_post.to_s
        
      else
        puts value.as_a.first
      end
    end
      
    tags_path.keys.each do |key|
      generate_interface(key, tags_path[key], tags[key])
    end
  end
  
  
  def self.generate_interface(name : String, paths : Array(String), 
    params : Array(YAML::Any))
    
    change_name = name.gsub(" API", "")
  
    clazz = "require \"http/client\"\n\nclass #{change_name}\n\n"
    
    paths.each_with_index do |the_path, i|
    
      path = the_path.split(":")[0]
      is_post = the_path.split(":")[1] == "true" ? true : false
    
      op_id = params[i]["operationId"].to_s
      clazz = clazz + "  # #{path} #{op_id}\n"
      method_name = op_id.gsub(" ", "_").downcase
      
      clazz = clazz + "  def self.#{method_name}("
      
      params[i]["parameters"].as_a.each do |param|
      
        if clazz[clazz.size - 1].to_s != "("
          clazz = clazz + ", "
        end
        
        clazz = clazz + param["name"].to_s
        if param["schema"]["type"]? != nil
          clazz = clazz + " : "
          clazz = clazz + ModelGenerator.convert_type( param["schema"]["type"].to_s)
        end
        
      end
      
      clazz = clazz + ")\n\n"
      
      if is_post
        clazz = clazz + generate_post_call(path, params[i])
      else
        clazz = clazz + generate_get_call(path, params[i])
      end
      
      clazz = clazz + "\"\n\n    raise \"Error with API\" if response.status_code != 200"
      
      array = false
      if params[i]["responses"]["default"]["content"]["application/json"]["schema"]["type"]? != nil
        array = true
        model_name = params[i]["responses"]["default"]["content"]["application/json"]["schema"]["items"]["$ref"].to_s
      else
        model_name = params[i]["responses"]["default"]["content"]["application/json"]["schema"]["$ref"].to_s
      end
      model_name = ref_to_model(model_name)
      
      clazz = clazz + "\n\n    #{model_name.downcase} = #{model_name}.from_json response.body \n"
      clazz = clazz + "\n\n    return #{model_name.downcase}\n"
      
      clazz = clazz + "  end\n\n"
    end
    
    clazz = clazz + "end"
    
    
    file_name = "src/onchain-shard/api/#{change_name.downcase}.cr"
    begin
      if File.read(file_name) != clazz
        File.open(file_name, "w") { |f| f << clazz }
      end
    rescue e
      File.open(file_name, "w") { |f| f << clazz }
    end
    
  end
  
  def self.generate_post_call(path : String, paramaters : YAML::Any)
  
    clazz = ""
    clazz = clazz + "    response = HTTP::Client.get \"https://onchain.io/api"
    path_we_need = path
    index = path.index("{")
    if index
      path_we_need = path[0..index - 2]
    end
    clazz = clazz + path_we_need
    paramaters["parameters"].as_a.each do |param|
    
      if param["in"].to_s == "path"
      
        clazz = clazz + "/\#{" + param["name"].to_s + "}"
        
      end
      
    end
    
    clazz = clazz + "/"
    
    first = true
    paramaters["parameters"].as_a.each do |param|
    
      if param["in"].to_s == "query"
      
        if first
          clazz = clazz + "?" 
        else
          clazz = clazz + "&"
        end
        first = false
        clazz = clazz + param["name"].to_s + "=\#{" + param["name"].to_s + "}"
        
      end
      
    end
    
    return clazz
  end
  
  def self.generate_get_call(path : String, paramaters : YAML::Any)
  
    clazz = ""
    clazz = clazz + "    response = HTTP::Client.get \"https://onchain.io/api"
    path_we_need = path
    index = path.index("{")
    if index
      path_we_need = path[0..index - 2]
    end
    clazz = clazz + path_we_need
    paramaters["parameters"].as_a.each do |param|
    
      if param["in"].to_s == "path"
      
        clazz = clazz + "/\#{" + param["name"].to_s + "}"
        
      end
      
    end
    
    clazz = clazz + "/"
    
    first = true
    paramaters["parameters"].as_a.each do |param|
    
      if param["in"].to_s == "query"
      
        if first
          clazz = clazz + "?" 
        else
          clazz = clazz + "&"
        end
        first = false
        clazz = clazz + param["name"].to_s + "=\#{" + param["name"].to_s + "}"
        
      end
      
    end
    
    return clazz
  end
  
  def self.ref_to_model(ref : String)
    ref = ref.gsub("#/components/schemas/", "")
    ref = ref.gsub("'", "")
    return ref.camelcase
  end
  
end