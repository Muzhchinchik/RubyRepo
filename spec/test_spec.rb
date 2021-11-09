RSpec.describe "Work with SPAWN" do

  before(:all)do
    @test_class = TestFunctions.new(path = File.dirname(TestData::TEMP_FILE_PATH), name = File.basename(TestData::TEMP_FILE_PATH))
  end

  after(:all)do
    @test_class.delete_temp_file(File.join(File.dirname(TestData::TEMP_FILE_PATH), File.basename(TestData::TEMP_FILE_PATH)))
  end

  it 'SPAWN and INCLUDE' do
    expected_data = TestData::EXPECTED_DATA[:EXPECTED_APPROXIMATE]
    spn = spawn('ping localhost', :out=>[TestData::TEMP_FILE_PATH, 'w+'])
    Process.wait spn
    file = File.open(TestData::TEMP_FILE_PATH)
    file_data = file.read
    expect(file_data).to include(expected_data)
    file.close
  end

  it 'SPAWN and END WITH' do
    expected_data = TestData::EXPECTED_DATA[:EXPECTED_AVERAGE]
    spn = spawn('ping localhost', :out=>[TestData::TEMP_FILE_PATH, 'w+'])
    Process.wait spn
    file = File.open(TestData::TEMP_FILE_PATH)
    file_data = file.read.strip
    expect(file_data).to end_with(expected_data)
    file.close
  end


  it 'SPAWN and START WITH' do
    expected_data = TestData::EXPECTED_DATA[:EXPECTED_DESKTOP]
    spn = spawn('ping localhost', :out=>[TestData::TEMP_FILE_PATH, 'w+'])
    Process.wait spn
    file = File.open(TestData::TEMP_FILE_PATH)
    file_data = file.read.strip
    expect(file_data).to start_with(expected_data)
    file.close
  end

  it 'SPAWN and BE AN(STRING)' do
    spn = spawn('ping localhost', :out=>[TestData::TEMP_FILE_PATH, 'w+'])
    Process.wait spn
    file = File.open(TestData::TEMP_FILE_PATH)
    file_data = file.read.strip
    expect(file_data).to be_an(String)
    file.close
  end

  it 'SPAWN and MATCH' do
    spn = spawn('ping localhost', :out=>[TestData::TEMP_FILE_PATH, 'w+'])
    match_string = TestData::EXPECTED_DATA[:EXPECTED_STATISTICS]
    Process.wait spn
    file = File.open(TestData::TEMP_FILE_PATH)
    file_data = file.read.strip
    expect(file_data).to match(match_string)
    file.close
  end

  it 'SPAWN and NOT MATCH' do
    spn = spawn('ping localhost', :out=>[TestData::TEMP_FILE_PATH, 'w+'])
    match_string = TestData::EXPECTED_DATA[:EXPECTED_HELLO]
    Process.wait spn
    file = File.open(TestData::TEMP_FILE_PATH)
    file_data = file.read.strip
    expect(file_data).not_to match(match_string)
    file.close
  end

  it 'REGEX' do
    spn = spawn('ping localhost', :out=>[TestData::TEMP_FILE_PATH, 'w+'])
    Process.wait spn
    #success?
    file = File.open(TestData::TEMP_FILE_PATH)
    file_data = file.read.strip
    expect(/Minimum = \d+ms, Maximum = \d+ms, Average = \d+ms/.match?(file_data)).to be(true)
    file.close
  end

end