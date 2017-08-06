RSpec.describe Pingboard::Request do

  describe '#initialize' do
    it 'initializes instance variables' do
      request = described_class.new(
        client: 'client',
        http_verb: 'http_verb',
        path: 'path',
        headers: nil,
        body: nil,
        params: {}
      )

      expect(request.client).to eq('client')
      expect(request.http_verb).to eq('http_verb')
      expect(request.path).to eq('path')
    end
  end

end
