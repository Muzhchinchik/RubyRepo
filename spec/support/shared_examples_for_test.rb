require 'pry'

RSpec.shared_examples 'Shared test' do |shell|
  before(:all)do
    @test_class = CreateDeleteTempFile.new(path = File.dirname(TestData::TEMP_FILE_PATH), name = File.basename(TestData::TEMP_FILE_PATH))
  end

  after(:all)do
    @test_class.delete_temp_file(File.join(File.dirname(TestData::TEMP_FILE_PATH), File.basename(TestData::TEMP_FILE_PATH)))
  end
  it "Verifies output from #{shell}" do
    TestCommand.new(shell, '/c ping localhost')
    file_data = File.read(TestData::TEMP_FILE_PATH).strip
    expect(file_data).to include("#{expected_data[:approximate]}")
    expect(file_data).to end_with("#{expected_data[:average]}")
    expect(file_data).to start_with("#{expected_data[:desktop]}")
    expect(file_data).to be_an(String)
    expect(file_data).to match("#{expected_data[:statistics]}")
    expect(file_data).not_to match("#{expected_data[:hello]}")
    expect(/Minimum = \d+ms, Maximum = \d+ms, Average = \d+ms/.match?(file_data)).to be(true)
  end
end