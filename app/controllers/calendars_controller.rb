class CalendarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]

  def index
    @calendars = []
    calendars = Calendar.where(date: date_range).to_a
    date_range.each do |date|
      %w(B L D).each do |meal_time|
        entry = calendars.find { |c| c.date == date && c.meal_time == meal_time }
        @calendars << (entry.presence || Calendar.new(date: date, meal_time: meal_time))
      end
    end
  end

  def show
  end

  def new
    @calendar = Calendar.new
  end

  def edit
  end

  def create
    @calendar = Calendar.create(calendar_params)
    render 'calendar'
  end

  def update
    # TODO: deal with errors in ajax saves
    # TODO: next/prev week
    @calendar.update_attributes(calendar_params)
    render 'calendar'
  end

  def destroy
    @calendar.destroy
    respond_to do |format|
      format.html { redirect_to calendars_url, notice: 'Calendar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_calendar
    @calendar = Calendar.find(params[:id])
  end

  def calendar_params
    params.require(:calendar).permit(:date, :meal_time, :component_list)
  end

  def date_range
    begin_date = params[:begin_date].presence || Time.zone.today
    begin_date..(begin_date + 6)
  end
end
