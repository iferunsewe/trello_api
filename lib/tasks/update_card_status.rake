namespace :card_status do
  desc 'It should update the cards status of overdue or due date soon'
  task :update => :environment do
    Card.all.each do |card|
      card.set_overdue
      card.set_due_date_soon
    end
  end
end
