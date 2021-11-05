require 'fileutils'
require 'rake'
require './functions/test_functions'

RSpec.describe "1" do

  before(:all)do
    create_temp_file('C:\test_folder\temp_file.txt')
  end

  after(:all)do
    delete_temp_file('C:\test_folder\temp_file.txt')
  end

  it 'SPAWN and INCLUDE' do
    expected_data = 'Approximate round trip times in milli-seconds:'
    spn = spawn('ping localhost', :out=>['C:\test_folder\temp_file.txt', "w+"])
    Process.wait spn
    #success?
    file = File.open('C:\test_folder\temp_file.txt')
    file_data = file.read
    expect(file_data).to include(expected_data)
    file.close
  end

  it 'SPAWN and END WITH' do
    expected_data = 'Average = 0ms'
    spn = spawn('ping localhost', :out=>['C:\test_folder\temp_file.txt', "w+"])
    Process.wait spn
    #success?
    file = File.open('C:\test_folder\temp_file.txt')
    file_data = file.read.strip
    expect(file_data).to end_with(expected_data)
    file.close
  end


  it 'SPAWN and START WITH' do
    expected_data = 'Pinging DESKTOP-MRO0O4C'
    spn = spawn('ping localhost', :out=>['C:\test_folder\temp_file.txt', "w+"])
    Process.wait spn
    #success?
    file = File.open('C:\test_folder\temp_file.txt')
    file_data = file.read.strip
    expect(file_data).to start_with(expected_data)
    file.close
  end

  it 'SPAWN and BE AN(STRING)' do
    spn = spawn('ping localhost', :out=>['C:\test_folder\temp_file.txt', "w+"])
    Process.wait spn
    #success?
    file = File.open('C:\test_folder\temp_file.txt')
    file_data = file.read.strip
    expect(file_data).to be_an(String)
    file.close
  end

  it 'SPAWN and MATCH' do
    spn = spawn('ping localhost', :out=>['C:\test_folder\temp_file.txt', "w+"])
    match_string = 'Ping statistics for ::1:'
    Process.wait spn
    #success?
    file = File.open('C:\test_folder\temp_file.txt')
    file_data = file.read.strip
    expect(file_data).to match(match_string)
    file.close
  end

  it 'SPAWN and NOT MATCH' do
    spn = spawn('ping localhost', :out=>['C:\test_folder\temp_file.txt', "w+"])
    match_string = 'Hello World'
    Process.wait spn
    #success?
    file = File.open('C:\test_folder\temp_file.txt')
    file_data = file.read.strip
    expect(file_data).not_to match(match_string)
    file.close
  end

  it 'REGEX' do
    spn = spawn('ping localhost', :out=>['C:\test_folder\temp_file.txt', "w+"])
    Process.wait spn
    #success?
    file = File.open('C:\test_folder\temp_file.txt')
    file_data = file.read.strip
    expect(/Minimum = \d+ms, Maximum = \d+ms, Average = \d+ms/.match?(file_data)).to be(true)
    file.close
  end
  
end