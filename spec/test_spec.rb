RSpec.describe "Work with SPAWN" do

  let(:expected_data) { TestData::EXPECTED_DATA }

  it_behaves_like('Shared test', shell = 'cmd.exe')
  it_behaves_like('Shared test', shell = 'powershell.exe')

end