require 'rails_helper'

RSpec.describe Card, type: :model do
  it {  should belong_to :list }

  it {  should validate_presence_of :title }
  it {  should validate_presence_of :description }
  it 'should validate that the due_date can not be in the past' do
    expect{ create(:card, due_date: Date.yesterday) }.
      to raise_error ActiveRecord::RecordInvalid, "Validation failed: Due date can't be in the past"
  end

  context 'when it is an update' do
    let(:card) { create(:card, due_date: Date.today) }

    it 'should not validate that the due_date can not be in the past' do
      card.due_date = Date.yesterday
      card.save
      expect{ card.update(title: 'New title') }.
        not_to raise_error ActiveRecord::RecordInvalid, "Validation failed: Due date can't be in the past"
    end
  end

  context 'default values' do
    subject(:card){ described_class.new }
    it 'should have a default false value for the attribute due_date_soon' do
      expect(card.due_date_soon).to eq false
    end

    it 'should have a default false value for the attribute overdue' do
      expect(card.overdue).to eq false
    end
  end

  describe '#set_overdue' do
    subject(:set_overdue) { create_card.set_overdue }
    let(:create_card) { create(:card, due_date: date) }
    let(:date){ Date.today }

    context 'when the due date is in the past' do
      it 'sets the overdue attribute to true' do
        create_card.due_date = Date.yesterday
        create_card.save
        set_overdue
        expect(create_card.overdue).to be true
      end
    end

    context 'when the due date is today' do
      it 'does not set the overdue attribute to false' do
        set_overdue
        expect(create_card.overdue).to be false
      end
    end

    context 'when the due date is in the future' do
      let(:date){ Date.tomorrow }
      it 'does not set the overdue attribute to false' do
        set_overdue
        expect(create_card.overdue).to be false
      end
    end

    context 'when the overdue attribute is true' do
      it 'should not change the due_date_date value' do
        expect{ set_overdue }.to_not change{ create_card.overdue }
      end
    end

    context 'when the due_date_soon attribute is false' do
      it 'should not change the overdue value' do
        expect{ set_overdue }.to_not change{ create_card.overdue }
      end
    end
  end

  describe '#set_due_date_soon' do
    subject(:set_due_date_soon) { create_card.set_due_date_soon }
    let(:create_card) { create(:card, due_date: date) }
    let(:date){ Date.today }

    context 'when the date is in the next three days' do
      let(:date){ Date.tomorrow }
      it 'sets the due_date_soon attribute to true' do
        set_due_date_soon
        expect(create_card.due_date_soon).to be true
      end
    end

    context 'when the date is not in the next three days' do
      let(:date){ Date.today + 4 }
      it 'should not change the due_date_date value' do
        expect{ set_due_date_soon }.to_not change{ create_card.due_date_soon }
      end
    end

    context 'when the overdue attribute is true' do
      it 'should not change the due_date_date value' do
        create_card.due_date = Date.yesterday
        create_card.save
        create_card.set_overdue
        expect{ set_due_date_soon }.to_not change{ create_card.due_date_soon }
      end
    end

    context 'when the due_date_soon attribute is true' do
      it 'should not change the due_date_date value' do
        expect{ set_due_date_soon }.to_not change{ create_card.due_date_soon }
      end
    end
  end
end
