class CalendarsController < ApplicationController
  before_action :move_to_sign_in

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
    if user_signed_in?
      @event = UserEvent.find(params[:id])
      @events = UserEvent.where(user_id: current_user.id).where(day: @event.start_time.day).order("start_time ASC")
    elsif team_signed_in?
      @events = TeamEvent.where(team_id: current_team.id)
    end
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
      @event.day = @event.start_time.day
      if @event.valid?
        @event.save
        redirect_to calendars_path
      else
        flash[:alert] = 'タイトルは50文字以内で入力してください'
        render 'calendars/new'
      end
    elsif team_signed_in?
      @event = TeamEvent.new(team_event_params)
      @event.day = @event.start_time.day
      if @event.valid?
        @event.save
        redirect_to calendars_path
      else
        flash[:alert] = 'タイトルは50文字以内で入力してください'
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
      else
        flash[:alert]
        render 'calendars/new'
      end
    elsif team_signed_in?
      @event = TeamEvent.find(params[:id])
      if @event.valid?
        @event.update(team_event_params)
      else
        flash[:alert]
        render 'calendars/new'
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
    params.require(:user_event).permit(:title, :start_time, :end_time, :body, :day).merge(user_id: current_user.id)
  end

  def team_event_params
    params.require(:team_event).permit(:title, :start_time, :end_time, :body, :day).merge(team_id: current_team.id)
  end

  def move_to_sign_in
    return unless !user_signed_in? && !team_signed_in?

    redirect_to new_user_session_path
    flash[:alert] = 'ログインしてください'
  end
end
