class AttendeesController < ApplicationController
  before_action :set_event
  before_action :set_attendee, only: [:update, :destroy, :rsvp]
  # testing commit
  # GET /events/:event_id/attendees
  def index
    @attendees = @event.attendees
    render json: @attendees
  end

  # POST /events/:event_id/attendees
  def create
    existing_attendee = @event.attendees.find_by(email: attendee_params[:email])
    if existing_attendee
      render json: existing_attendee, status: :ok
    else
      @attendee = @event.attendees.new(attendee_params)

      if @attendee.save
        render json: @attendee, status: :created
      else
        Rails.logger.error("Attendee validation errors: #{@attendee.errors.full_messages}")
        render json: {errors: @attendee.errors.full_messages}, status: :unprocessable_entity
      end
    end

  end

  # PATCH/PUT /events/:event_id/attendees/:id
  def update
    if @attendee.update(attendee_params)
      render json: @attendee
    else
      render json: @attendee.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/:event_id/attendees/:id
  def destroy
    @attendee.destroy
    head :no_content
  end

  # PATCH /attendees/:id/rsvp
  def rsvp
    if @attendee.update(rsvp: params[:rsvp])
      render json: @attendee
    else
      render json: { error: 'Unable to update RSVP' }, status: :unprocessable_entity
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_attendee
    @attendee = @event.attendees.find(params[:id])
  end

  def attendee_params
    params.require(:attendee).permit(:name, :email, :rsvp, :event_id)
  end
end
