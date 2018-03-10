require 'rails_helper'

RSpec.describe 'Lists API', type: :request do

  describe 'GET /lists (all the lists)' do
    let(:number_of_lists) { 5 }
    let!(:lists) {  create_list(:list, number_of_lists) }
    let(:parsed_json){ JSON.parse(response.body) }

    before { get '/lists' }
    it 'returns all the lists' do
      expect(parsed_json.size).to eq(number_of_lists)
    end

    it 'returns a 200 status code' do
      expect(response.status).to eq 200
    end
  end

end
