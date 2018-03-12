require 'rails_helper'

RSpec.describe 'Cards API', type: :request do
  let!(:list) { create(:list) }
  let(:list_id) { list.id }
  let(:number_of_cards) { 5 }
  let!(:cards) { create_list(:card, number_of_cards, list_id: list_id) }
  let(:card_id) { cards.last.id }
  let(:parsed_json){ JSON.parse(response.body) }

  describe 'get all the cards for a specific list' do
    before { get "/lists/#{list_id}/cards" }

    it 'returns all the cards' do
      expect(parsed_json.size).to eq(number_of_cards)
    end

    it 'returns a 200 status code' do
      expect_status_code?(200)
    end
  end

  describe 'get a card from a list' do
    before { get "/lists/#{list_id}/cards/#{card_id}" }

    context 'when the card exists' do
      it 'returns a 200 status code' do
        expect_status_code?(200)
      end

      it 'returns the card' do
        expect(parsed_json['id']).to eq(card_id)
      end
    end

    context 'when the card does not exist' do
      let(:card_id) { number_of_cards + 1 }

      it 'returns a 404 status code' do
        expect_status_code?(404)
      end

      it 'returns a message to say the card could not be found' do
        expect(parsed_json['error']).to include "Couldn't find Card with 'id'=#{card_id}"
      end
    end
  end

  describe 'create a card for a specific list' do
    before { post "/lists/#{list_id}/cards", params: params }

    context 'when the request contains valid params' do
      let(:title) { 'Title' }
      let(:params){ { title: title, description: 'More description' } }

      it 'creates a card' do
        expect(parsed_json['title']).to eq title
      end

      it 'returns a 201 status code' do
        expect_status_code?(201)
      end
    end

    context 'when the request contains invalid params' do
      let(:params){ }

      it 'returns a 422 status code' do
        expect_status_code?(422)
      end

      it 'returns a validation message' do
        expect(parsed_json['error']).to include 'Validation failed'
      end
    end
  end

  describe 'update a card in a list' do
    before do
      put "/lists/#{list_id}/cards/#{card_id}", params: params
    end
    let(:params){ { title: 'New title' } }

    context 'when the card exists' do
      it 'returns a 200 status code' do
        expect_status_code?(200)
      end

      it 'returns the card with the changed attribute' do
        expect(parsed_json['id']).to eq(card_id)
        expect(parsed_json['title']).to eq(params[:title])
      end
    end

    context 'when the card does not exist' do
      let(:card_id) { number_of_cards + 1 }

      it 'returns a 404 status code' do
        expect_status_code?(404)
      end

      it 'returns a message to say the card could not be found' do
        expect(parsed_json['error']).to include "Couldn't find Card with 'id'=#{card_id}"
      end
    end
  end

  context 'when changing the list the card belongs to' do
    let(:new_list) { create(:list) }

    it 'returns the card attached to a different list' do
      expect(Card.find(card_id).list_id).to eq list_id
      put "/cards/#{card_id}/change_list/#{new_list.id}"
      expect(parsed_json['list_id']).to eq(new_list.id)
    end
  end

  describe 'delete a card in a list' do
    before do
      delete "/lists/#{list_id}/cards/#{card_id}"
    end

    it 'returns a 204 status code' do
      expect_status_code?(204)
    end
  end

  def expect_status_code?(status_code)
    expect(response.status).to eq status_code
  end
end
