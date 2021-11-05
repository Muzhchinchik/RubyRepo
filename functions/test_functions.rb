def create_temp_file(path)
  dir = File.dirname(path)

  unless File.directory?(dir)
    FileUtils.mkdir_p(dir)
  end

  a = File.new(path, 'w+')
  a.close
end

def delete_temp_file(path)
  FileUtils.rm_rf(path)
end