class EventsController < ApplicationController
  before_action :set_event, only: %i[ show update destroy generate_tickets ]

  # GET /events
  def index
    @events = Event.all

    render json: @events
  end

  # GET /events/1
  def show
    render json: @event
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy!
  end

  def generate_tickets

    count = params[:count].presence || 10
    base_price = params[:base_price].presence || 25.00

    generated_count = 0

    count.to_i.times do |i|
      seat_row = (65 + (i / 10)).chr
      seat_number = "#{seat_row}#{(i % 10) +1}"

      row_premium = (seat_row.ord - 65) * 5.00
      ticket_price = base_price.to_f + row_premium

      ticket = @event.tickets.create(
        price: ticket_price,
        seat_number: seat_number,
      )

      generated_count += 1 if ticket.persisted?
    end

    render json: {
      success: true,
      message: "#{generated_count} tickets generated successfully ",
      ticket_count: @event.tickets.count
    }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :description, :date, :location, :recurrence)
    end
end
