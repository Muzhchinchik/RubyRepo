require 'pry'
require './functions/test_commands'
RSpec.describe "Work with SPAWN" do

  before(:all)do
    @test_class = TestFunctions.new(path = File.dirname(TestData::TEMP_FILE_PATH), name = File.basename(TestData::TEMP_FILE_PATH))
  end

  after(:all)do
    @test_class.delete_temp_file(File.join(File.dirname(TestData::TEMP_FILE_PATH), File.basename(TestData::TEMP_FILE_PATH)))
  end

  it 'SPAWN and INCLUDE' do
    TestCommand.new('cmd.exe', '/c ping localhost')
    expected_data = TestData::EXPECTED_DATA[:approximate]
    file_data = File.read(TestData::TEMP_FILE_PATH).strip
    expect(file_data).to include(expected_data)
  end

  it 'SPAWN and END WITH' do
    TestCommand.new('cmd.exe', '/c ping localhost')
    expected_data = TestData::EXPECTED_DATA[:average]
    file_data = File.read(TestData::TEMP_FILE_PATH).strip
    expect(file_data).to end_with(expected_data)
  end

  it 'SPAWN and START WITH' do
    TestCommand.new('cmd.exe', '/c ping localhost')
    expected_data = TestData::EXPECTED_DATA[:desktop]
    file_data = File.read(TestData::TEMP_FILE_PATH).strip
    expect(file_data).to start_with(expected_data)
  end

  it 'SPAWN and BE AN(STRING)' do
    TestCommand.new('cmd.exe', '/c ping localhost')
    file_data = File.read(TestData::TEMP_FILE_PATH).strip
    expect(file_data).to be_an(String)
  end

  it 'SPAWN and MATCH' do
    TestCommand.new('cmd.exe', '/c ping localhost')
    match_string = TestData::EXPECTED_DATA[:statistics]
    file_data = File.read(TestData::TEMP_FILE_PATH).strip
    expect(file_data).to match(match_string)
  end

  it 'SPAWN and NOT MATCH' do
    TestCommand.new('cmd.exe', '/c ping localhost')
    match_string = TestData::EXPECTED_DATA[:hello]
    file_data = File.read(TestData::TEMP_FILE_PATH).strip
    expect(file_data).not_to match(match_string)
  end

  it 'REGEX' do
    TestCommand.new('cmd.exe', '/c ping localhost')
    file_data = File.read(TestData::TEMP_FILE_PATH).strip
    expect(/Minimum = \d+ms, Maximum = \d+ms, Average = \d+ms/.match?(file_data)).to be(true)
  end

end