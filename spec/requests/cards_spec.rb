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

  def expect_status_code?(status_code)
    expect(response.status).to eq status_code
  end
end
