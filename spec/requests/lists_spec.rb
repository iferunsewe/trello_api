require 'rails_helper'

RSpec.describe 'Lists API', type: :request do
  let(:number_of_lists) { 5 }
  let!(:lists) { create_list(:list, number_of_lists) }
  let(:list_id) { lists.last.id }
  let(:parsed_json){ JSON.parse(response.body) }

  describe 'GET /lists (all the lists)' do
    before { get '/lists' }
    it 'returns all the lists' do
      expect(parsed_json.size).to eq(number_of_lists)
    end

    it 'returns a 200 status code' do
      expect_status_code?(200)
    end
  end

  describe 'GET /lists/:id' do
    before { get "/lists/#{list_id}" }

    context 'when the list exists' do

      it 'returns the list' do
        expect(parsed_json['id']).to eq(list_id)
      end

      it 'returns a 200 status code' do
        expect_status_code?(200)
      end
    end
  end

  def expect_status_code?(status_code)
    expect(response.status).to eq status_code
  end
end
