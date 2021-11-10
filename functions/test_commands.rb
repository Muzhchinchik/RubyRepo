class TestCommand
  def initialize(app, arg)
    use_command(app, arg)
  end
  ##
  # Launch app with arguments
  #
  # @param app [String] application name to run
  # @param arg [String] arguments to run with app
  #
  #
  private
  def use_command(app, arg)
    Process.wait(spawn("#{app} #{arg}", :out=>[TestData::TEMP_FILE_PATH, 'w+']))
  end
end