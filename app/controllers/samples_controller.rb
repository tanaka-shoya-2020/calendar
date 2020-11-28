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
    if @event.valid?
      @event.day = @event.start_time.day
      @event.save
      redirect_to samples_path
    else
      flash[:alert] = 'タイトルは20文字以内で入力してください'
      render 'samples/new'
    end
  end

  def edit
    @event = Sample.find(params[:id])
  end

  def update
    @event = Sample.find(params[:id])
    @event.day = @event.start_time.day
    @event.update(event_params)
    if @event.valid?
      redirect_to samples_path
    else
      flash[:alert]
      render 'samples/edit'
    end
  end

  def destroy
    @event = Sample.find(params[:id])
    if @event.destroy
      redirect_to samples_path
    else
      flash[:alert] = '削除に失敗しました'
      @events = Sample.where(day: @event.start_time.day).order('start_time ASC')
      render 'samples/show'
    end
  end

  private

  def event_params
    params.require(:sample).permit(:title, :start_time, :body, :day)
  end
end
