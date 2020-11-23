class SamplesController < ApplicationController
  def index
    @events = Sample.all
  end

  def show
    @event  = Sample.find(params[:id])
    @events = Sample.where(day: @event.start_time.day).order('start_time ASC')
  end

  def new
    @event = Sample.new
  end

  def create
    @event = Sample.new(event_params)
    @event.day = @event.start_time.day
    if @event.valid?
      @event.save
      redirect_to samples_path
    else
      flash[:alert] = 'タイトルは50文字以内で入力してください'
      render 'samples/new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def event_params
    params.permit(:title, :start_time, :end_time, :body)
  end
end
