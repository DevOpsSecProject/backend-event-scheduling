class Ticket < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :event

  validates :price, presence: true
end
