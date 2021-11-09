RSpec.describe "Work with SPAWN" do

  before(:all)do
    @test_class = TestFunctions.new(path = File.dirname(TestData::TEMP_FILE_PATH), name = File.basename(TestData::TEMP_FILE_PATH))
  end

  after(:all)do
    @test_class.delete_temp_file(File.join(File.dirname(TestData::TEMP_FILE_PATH), File.basename(TestData::TEMP_FILE_PATH)))
  end

  it 'SPAWN and INCLUDE' do
    expected_data = TestData::EXPECTED_DATA[:approximate]
    spn = spawn('ping localhost', :out=>[TestData::TEMP_FILE_PATH, 'w+'])
    Process.wait spn
    file_data = File.read(TestData::TEMP_FILE_PATH).strip
    expect(file_data).to include(expected_data)
  end

  it 'SPAWN and END WITH' do
    expected_data = TestData::EXPECTED_DATA[:average]
    spn = spawn('ping localhost', :out=>[TestData::TEMP_FILE_PATH, 'w+'])
    Process.wait spn
    file_data = File.read(TestData::TEMP_FILE_PATH).strip
    expect(file_data).to end_with(expected_data)
  end


  it 'SPAWN and START WITH' do
    expected_data = TestData::EXPECTED_DATA[:desktop]
    spn = spawn('ping localhost', :out=>[TestData::TEMP_FILE_PATH, 'w+'])
    Process.wait spn
    file_data = File.read(TestData::TEMP_FILE_PATH).strip
    expect(file_data).to start_with(expected_data)
  end

  it 'SPAWN and BE AN(STRING)' do
    spn = spawn('ping localhost', :out=>[TestData::TEMP_FILE_PATH, 'w+'])
    Process.wait spn
    file_data = File.read(TestData::TEMP_FILE_PATH).strip
    expect(file_data).to be_an(String)
  end

  it 'SPAWN and MATCH' do
    spn = spawn('ping localhost', :out=>[TestData::TEMP_FILE_PATH, 'w+'])
    match_string = TestData::EXPECTED_DATA[:statistics]
    Process.wait spn
    file_data = File.read(TestData::TEMP_FILE_PATH).strip
    expect(file_data).to match(match_string)
  end

  it 'SPAWN and NOT MATCH' do
    spn = spawn('ping localhost', :out=>[TestData::TEMP_FILE_PATH, 'w+'])
    match_string = TestData::EXPECTED_DATA[:hello]
    Process.wait spn
    file_data = File.read(TestData::TEMP_FILE_PATH).strip
    expect(file_data).not_to match(match_string)
  end

  it 'REGEX' do
    spn = spawn('ping localhost', :out=>[TestData::TEMP_FILE_PATH, 'w+'])
    Process.wait spn
    file_data = File.read(TestData::TEMP_FILE_PATH).strip
    expect(/Minimum = \d+ms, Maximum = \d+ms, Average = \d+ms/.match?(file_data)).to be(true)
  end

end