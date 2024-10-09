class UsersController < ApplicationController
  # GET /users/:user_id/events_participated
  def events_participated
    user = User.find(params[:user_id])
    events = user.events_participated
    render json: events
  end

  # GET /users/:user_id/events_organised
  def events_organised
    user = User.find(params[:user_id])
    events = user.events_organised
    render json: events
  end
end
