class Card < ApplicationRecord
  belongs_to :list
  validates_presence_of :title, :description
  validate :due_date_cannot_be_in_the_past, on: :create
  after_save :set_overdue, :set_due_date_soon, if: :saved_change_to_due_date?
  after_find :set_overdue, :set_due_date_soon

  def set_overdue
    return if !self.due_date_soon || self.overdue
    self.update!(overdue: true) if Date.today > self.due_date
  end

  def set_due_date_soon
    return if self.due_date_soon || self.overdue
    self.update!(due_date_soon: true) if self.due_date.between?(Date.today, Date.today + 3)
  end

  private

  def due_date_cannot_be_in_the_past
    errors.add(:due_date, "can't be in the past") if
      !due_date.blank? and due_date < Date.today
  end
end
