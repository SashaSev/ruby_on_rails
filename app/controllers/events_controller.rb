class EventsController < ApplicationController

  before_action :require_signin, except: %i[index show]
  before_action :require_admin, except: %i[index show]
  # before_action :set_event, only: [:show]
  def index
    @events = Event.upcoming
  end

  def show
    # tail
    @event = Event.find(params[:id])
    # Rails.logger.debug("My object #{@event.inspect}")

  end

  def edit
    @event = Event.find(params[:id])
    # Rails.logger.debug("My object #{@event.inspect}")
  end

  def update
    # tail
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: 'Event successfully updated'
    else
      render :edit
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event, notice: 'Event successfully created'
    else
      render :new
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_url
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :location, :price, :starts_at, :capacity, :image_file)
  end
  # private
  #
  # def set_event
  #   @event = Event.find(params[:id])
  # end
end
