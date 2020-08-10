class RegistrationsController < ApplicationController

  before_action :set_event

  def index
    @registration = @event.registrations
  end

  def new
    @registration = @event.registrations.new
  end

  def create
    @registration = @event.registrations.new(params_register)
    if @registration.save
      redirect_to event_registrations_url(@event),
                  notice: 'Thanks for registered'
    else
      render :new
    end

  end

  private

  def params_register
    params.require(:registration).permit(:name, :email, :how_heard)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end


end
