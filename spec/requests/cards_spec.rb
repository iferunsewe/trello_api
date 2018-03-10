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
        expect(parsed_json['error']).to eq "Couldn't find Card with 'id'=#{card_id}"
      end
    end
  end

  def expect_status_code?(status_code)
    expect(response.status).to eq status_code
  end
end
