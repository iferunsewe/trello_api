require 'rails_helper'

RSpec.describe 'Lists API', type: :request do
  let(:number_of_lists) { 5 }
  let!(:lists) { create_list(:list, number_of_lists) }
  let(:list_id) { lists.last.id }
  let(:parsed_json){ JSON.parse(response.body) }

  describe 'get all the lists' do
    before { get '/lists' }
    it 'returns all the lists' do
      expect(parsed_json.size).to eq(number_of_lists)
    end

    it 'returns a 200 status code' do
      expect_status_code?(200)
    end
  end

  describe 'get a list' do
    before { get "/lists/#{list_id}" }

    context 'when the list exists' do
      it 'returns the list' do
        expect(parsed_json['id']).to eq(list_id)
      end

      it 'returns a 200 status code' do
        expect_status_code?(200)
      end
    end

    context 'when the list does not exist' do
      let(:list_id) { number_of_lists + 1 }

      it 'returns a 404 status code' do
        expect_status_code?(404)
      end

      it 'returns a message to say the list could not be found' do
        expect(parsed_json['error']).to eq "Couldn't find List with 'id'=#{list_id}"
      end
    end
  end

  describe 'create a list' do
    context 'when the request contains valid params' do
      before { post '/lists', params: params }

      let(:name){ 'New list' }
      let(:params){ { name: name } }

      it 'creates a list' do
        expect(parsed_json['name']).to eq name
      end

      it 'returns a 201 status code' do
        expect_status_code?(201)
      end
    end

    context 'when the request contains invalid params' do
      before { post '/lists', params: params }

      let(:name){ 'New list' }
      let(:params){ { name: nil } }

      it 'returns a 422 status code' do
        expect_status_code?(422)
      end

      it 'returns a validation message' do
        expect(parsed_json['error']).to include 'Validation failed'
      end
    end
  end

  def expect_status_code?(status_code)
    expect(response.status).to eq status_code
  end
end
