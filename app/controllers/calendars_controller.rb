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
      @events = UserEvent.where(user_id: current_user.id).where(day: @event.start_time.day).order('start_time ASC')
    elsif team_signed_in?
      @event = TeamEvent.find(params[:id])
      @events = TeamEvent.where(team_id: current_team.id).where(day: @event.start_time.day).order('start_time ASC')
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
      if @event.valid?
        @event.day = @event.start_time.day
        @event.save
        redirect_to calendars_path
      else
        flash[:alert] = 'タイトルは50文字以内で入力してください'
        render 'calendars/new'
      end
    elsif team_signed_in?
      @event = TeamEvent.new(team_event_params)
      if @event.valid?
        @event.day = @event.start_time.day
        @event.save
        redirect_to calendars_path
      else
        flash[:alert] = 'タイトルは20文字以内で入力してください'
        render 'calendars/new'
      end
    end
  end

  def edit
    if user_signed_in?
      @event = UserEvent.find(params[:id])
    elsif team_signed_in?
      @event = TeamEvent.find(params[:id])
    end
  end

  def update
    if user_signed_in?
      @event = UserEvent.find(params[:id])
      @event.day = @event.start_time.day
      @event.update(user_event_params)
      if @event.valid?
        redirect_to calendars_path
      else
        flash[:alert]
        render 'calendars/edit'
      end
    elsif team_signed_in?
      @event = TeamEvent.find(params[:id])
      @event.day = @event.start_time.day
      @event.update(team_event_params)
      if @event.valid?
        redirect_to calendars_path
      else
        flash[:alert]
        render 'calendars/edit'
      end
    end
  end

  def destroy
    if user_signed_in?
      @event = UserEvent.find(params[:id])
      if @event.destroy
        redirect_to calendars_path
      else
        flash[:alert] = '削除に失敗しました'
        @events = UserEvent.where(user_id: current_user.id).where(day: @event.start_time.day).order('start_time ASC')
        render 'calendars/show'
      end
    elsif team_signed_in?
      @event = TeamEvent.find(params[:id])
      if @event.destroy
        redirect_to calendars_path
      else
        flash[:alert] = '削除に失敗しました'
        @events = TeamEvent.where(team_id: current_user.id).where(day: @event.start_time.day).order('start_time ASC')
        render 'calendars/show'
      end
    end
  end

  private

  def user_event_params
    params.require(:user_event).permit(:title, :start_time, :body, :day).merge(user_id: current_user.id)
  end

  def team_event_params
    params.require(:team_event).permit(:title, :start_time, :body, :day).merge(team_id: current_team.id)
  end

  def move_to_sign_in
    return unless !user_signed_in? && !team_signed_in?

    redirect_to new_user_session_path
    flash[:alert] = 'ログインしてください'
  end
end
