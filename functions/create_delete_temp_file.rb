class CreateDeleteTempFile
  def initialize(path, name)
    @path = path
    @name = name
    create_file(@path, @name)
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
  ##
  # Create temp file with selected name in selected directory
  #
  # @param path [String] path to temp file
  # @param name [String] name for temp file
  #
  #
  private
  def create_file(path, name)
    crt = File.join(path, name)
    FileUtils.touch(crt)
  end
end