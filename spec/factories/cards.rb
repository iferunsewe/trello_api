FactoryBot.define do
  factory :card do
    title 'Bar'
    description 'Duis ornare, neque vel tincidunt suscipit, risus velit venenatis augue, nec consectetur enim ipsum eget neque. Donec pharetra in leo ac placerat'
    due_date Date.today + 7
    list
  end
end
