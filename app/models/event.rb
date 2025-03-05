class Event < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :attendees, dependent: :destroy

  def generate_tickets(options = {})
    count = options[:count] || 10
    base_price = options[:base_price] || 25.00

    count.times do |i|
      seat_row = (65 + (i / 10)).chr
      seat_number = "#{seat_row}#{(i % 10) +1}"

      row_premium = (seat_row.ord - 65) * 5.00
      self.tickets.create!(
        price: base_price + row_premium,
        seat_number: seat_number
        )
    end
  end

end
