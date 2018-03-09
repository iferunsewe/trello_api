require 'rails_helper'

RSpec.describe Card, type: :model do
  it {  should validate_presence_of :title }
  it {  should validate_presence_of :description }

  context 'default values' do
    subject(:card){ described_class.new }
    it 'should have a default false value for the attribute due_date_soon' do
      expect(card.due_date_soon).to eq false
    end

    it 'should have a default false value for the attribute overdue' do
      expect(card.overdue).to eq false
    end
  end
end
