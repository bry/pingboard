RSpec.describe Pingboard::Client do

  Faraday::Adapter::Test::Stubs.new do |stub|
    stub.get('/') { |env| [200, {}, 'test'] }
  end

  describe '#initialize' do
    context 'when no block is given' do
      it 'sets instance varaibles' do
        client = described_class.new(
          request=Pingboard::Request,
          service_app_id: 'testclientid',
          service_app_secret: 'testclientsecret'
        )
        expect(client.service_app_id).to eq('testclientid')
        expect(client.service_app_secret).to eq('testclientsecret')
      end
    end

    context 'when a block is given' do
      it 'sets instance variables' do
        client = described_class.new do |config|
          config.service_app_id = 'testclientid'
          config.service_app_secret = 'testclientsecret'
        end
        expect(client.service_app_id).to eq('testclientid')
        expect(client.service_app_secret).to eq('testclientsecret')
      end
    end
  end
end
