##
# Create temp file in selected directory
#
# @param path [String] path to temp file
#
#
def create_temp_file(path)
  dir = File.dirname(path)

  unless File.directory?(dir)
    FileUtils.mkdir_p(dir)
  end

  a = File.new(path, 'w+')
  a.close
end
##
# Delete directory including all files
#
# @param path [String] path to temp directory
#
#
def delete_temp_file(path)
  FileUtils.rm_rf(path)
end