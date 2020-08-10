class RegistrationsController < ApplicationController
  before_action :require_signin
  before_action :set_event

  def index
    @registration = @event.registrations
  end

  def new
    @registration = @event.registrations.new
  end

  def create
    @registration = @event.registrations.new(params_register)
    @registration.user = current_user
    Rails.logger.debug(current_user)
    if @registration.save
      redirect_to event_registrations_url(@event),
                  notice: 'Thanks for registered'
    else
      render :new
    end

  end

  private

  def params_register
    params.require(:registration).permit(:how_heard)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end


end
