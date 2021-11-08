class TestFunctions
  def initialize(path, name)
    @path = path
    @name = name
    create_file(@path, @name)
  end
  ##
  # Create temp file in selected directory
  #
  # @param path [String] path to temp file
  #
  #
  def create_temp_file(path, name)
    dir = File.dirname(path)

    unless File.directory?(dir)
      FileUtils.mkdir_p(dir)
    end

    path << '#{name}'

    a = File.new(path, 'w+')
    a.close
  end
  ##
  # Delete directory including all files
  #
  # @param path [String] path to temp directory
  #
  #
  public
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
  def create_file(path, name)
    crt = File.join(path, name)
    FileUtils.touch(crt)
  end
end