require 'rails_helper'

RSpec.describe List, type: :model do
  it { should have_many(:cards).dependent(:destroy) }

  it {  should validate_presence_of :name  }
end
