class Attendee < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :rsvp, inclusion: { in: [true, false] }
end
