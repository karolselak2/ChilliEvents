class EventsController < ApplicationController
  before_action :set_event, only: %i[show update participants register_participant]

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # GET /events/:id
  def show
    render json: @event
  end

  # GET /events/:event_id/participants
  def participants
    render json: @event.event_participants.includes(:user)
  end

  # PATCH/PUT /events/:id
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # POST /events/:event_id/register_participant
  def register_participant
    @event_participant = @event.event_participants.new(user_id: params[:user_id])

    begin
      if @event_participant.save
        render json: @event_participant, status: :created
      else
        render json: @event_participant.errors, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotUnique => e
      render json: { error: 'User has been already registered' }, status: :unprocessable_entity
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id] || params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :start, :end, :participants_limit, :organiser_id)
  end
end
