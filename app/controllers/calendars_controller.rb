class CalendarsController < ApplicationController
  def index
    if user_signed_in?
      @user = User.find(current_user.id)
      @events = UserEvent.where(user_id: @user.id)
    elsif team_signed_in?
      @team = Team.find(current_team.id)
      @events = TeamEvent.where(team_id: @team.id)
    end
  end

  def show
  end

  def new
    if user_signed_in?
      @event = UserEvent.new
    elsif team_signed_in?
      @event = TeamEvent.new
    end
  end

  def create
    if user_signed_in?
      @event = UserEvent.new(user_event_params)
      binding.pry
      if @event.valid?
        @event.save
        redirect_to calendars_path
      else
        render 'calendars/new'
      end
    elsif team_signed_in?
      @event = TeamEvent.new(team_event_params)
      if @event.valid?
        @event.save
        redirect_to calendars_path
      else
        render 'calendars/new'
      end
    end
  end

  def edit
  end

  def update
    if user_signed_in?
      @event = UserEvent.find(params[:id])
      if @event.valid?
        @event.update(user_event_params)
      end
    elsif team_signed_in?
      @event = TeamEvent.find(params[:id])
      if @event.valid?
        @event.update(team_event_params)
      end
    end
  end

  def destroy
    event = UserEvent.find(params[:id])
    event.destroy
    redirect_to calendars_path
  end

  private

    def user_event_params
      params.require(:user_event).permit(:title, :start_time, :end_time, :body).merge(user_id: current_user.id)
    end

    def team_event_params
      params.require(:team_event).permit(:title, :event_start, :event_end, :body).merge(team_id: current_team.id)
    end
end
