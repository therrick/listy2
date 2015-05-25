class AislesController < ApplicationController
  respond_to :html, :xml, :json
  before_action :authenticate_user!
  before_action :set_store
  before_action :set_aisle, only: [:show, :edit, :update, :destroy]

  def index
    @aisles = @store.aisles.order(:position)
    respond_with @aisles
  end

  def show
    respond_with @aisle
  end

  def new
    @aisle = @store.aisles.new
    respond_with @aisle
  end

  def edit
    respond_with @aisle
  end

  def create
    @aisle = @store.aisles.new(aisle_params)
    flash[:notice] = 'Successfully created aisle' if @aisle.save
    respond_with(@aisle)
  end

  def update
    @aisle = @store.aisles.find(params[:id])
    flash[:notice] = 'Successfully updated aisle' if @aisle.update_attributes(aisle_params)
    respond_with(@aisle)
  end

  def destroy
    @aisle.destroy
    flash[:notice] = 'Successfully deleted aisle'
    respond_with(@aisle)
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def move_up
    # TODO: maybe refactor this to use acts-as-list or ranked-model
    aisles = @store.aisles

    # first, compact everything back down to 1-n in case a delete or something got it out of whack
    aisles.sort! { |a, b| a.position <=> b.position }
    aisles.each_with_index do |aisle, i|
      aisle.position = i + 1
      aisle.save!
    end

    @aisle = aisles.find(params[:id])
    original_position = @aisle.position
    if original_position > 1
      @aisle.position -= 1
      @aisle.save!
      aisles.each do |aisle|
        aisle.position += 1 if aisle != @aisle &&
                               aisle.position >= @aisle.position &&
                               aisle.position <= original_position
        aisle.save!
      end
    end
    redirect_to(store_aisles_url(@store.id))
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def sort
    aisles = @store.aisles
    aisles.each do |aisle|
      aisle.position = params['aisle'].index(aisle.id.to_s) + 1
      aisle.save!
    end
    render nothing: true
  end

  private

  def set_store
    @store = current_user.stores.find(params[:store_id])
  end

  def set_aisle
    @aisle = @store.aisles.find(params[:id])
  end

  def aisle_params
    params.require(:aisle).permit(:name, :description, :position)
  end
end
