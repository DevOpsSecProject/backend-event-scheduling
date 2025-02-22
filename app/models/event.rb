class Event < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :favourties, dependent: :destroy
  has_many :tickets, through: :favourties
end
