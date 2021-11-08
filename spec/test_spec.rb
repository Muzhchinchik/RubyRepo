RSpec.describe "Work with SPAWN" do

  before(:all)do
    @test_class = TestFunctions.new(path = File.dirname(TestData::TEMP_FILE_PATH), name = File.basename(TestData::TEMP_FILE_PATH))
  end

  after(:all)do
    @test_class.delete_temp_file(File.join(File.dirname(TestData::TEMP_FILE_PATH), File.basename(TestData::TEMP_FILE_PATH)))
  end

  it 'SPAWN and INCLUDE' do
    #expected_data = 'Approximate round trip times in milli-seconds:'
    expected_data = TestData::EXPECTED_APPROXIMATE
    spn = spawn(TestData::PING_LOCALHOST, :out=>[TestData::TEMP_FILE_PATH, TestData::OUTWRITEPLUS])
    Process.wait spn
    #success?
    file = File.open(TestData::TEMP_FILE_PATH)
    file_data = file.read
    expect(file_data).to include(expected_data)
    file.close
  end

  it 'SPAWN and END WITH' do
    expected_data = TestData::EXPECTED_AVERAGE
    spn = spawn(TestData::PING_LOCALHOST, :out=>[TestData::TEMP_FILE_PATH, TestData::OUTWRITEPLUS])
    Process.wait spn
    #success?
    file = File.open(TestData::TEMP_FILE_PATH)
    file_data = file.read.strip
    expect(file_data).to end_with(expected_data)
    file.close
  end


  it 'SPAWN and START WITH' do
    #expected_data = 'Pinging DESKTOP-MRO0O4C'
    expected_data = TestData::EXPECTED_DESKTOP
    spn = spawn(TestData::PING_LOCALHOST, :out=>[TestData::TEMP_FILE_PATH, TestData::OUTWRITEPLUS])
    Process.wait spn
    #success?
    file = File.open(TestData::TEMP_FILE_PATH)
    file_data = file.read.strip
    expect(file_data).to start_with(expected_data)
    file.close
  end

  it 'SPAWN and BE AN(STRING)' do
    spn = spawn(TestData::PING_LOCALHOST, :out=>[TestData::TEMP_FILE_PATH, TestData::OUTWRITEPLUS])
    Process.wait spn
    #success?
    file = File.open(TestData::TEMP_FILE_PATH)
    file_data = file.read.strip
    expect(file_data).to be_an(String)
    file.close
  end

  it 'SPAWN and MATCH' do
    spn = spawn(TestData::PING_LOCALHOST, :out=>[TestData::TEMP_FILE_PATH, TestData::OUTWRITEPLUS])
    #match_string = 'Ping statistics for ::1:'
    match_string = TestData::EXPECTED_STATISTICS
    Process.wait spn
    #success?
    file = File.open(TestData::TEMP_FILE_PATH)
    file_data = file.read.strip
    expect(file_data).to match(match_string)
    file.close
  end

  it 'SPAWN and NOT MATCH' do
    spn = spawn(TestData::PING_LOCALHOST, :out=>[TestData::TEMP_FILE_PATH, TestData::OUTWRITEPLUS])
    #match_string = 'Hello World'
    match_string = TestData::EXPECTED_HELLO
    Process.wait spn
    #success?
    file = File.open(TestData::TEMP_FILE_PATH)
    file_data = file.read.strip
    expect(file_data).not_to match(match_string)
    file.close
  end

  it 'REGEX' do
    spn = spawn(TestData::PING_LOCALHOST, :out=>[TestData::TEMP_FILE_PATH, TestData::OUTWRITEPLUS])
    Process.wait spn
    #success?
    file = File.open(TestData::TEMP_FILE_PATH)
    file_data = file.read.strip
    expect(TestData::REGTEMPLATE.match?(file_data)).to be(true)
    file.close
  end

end