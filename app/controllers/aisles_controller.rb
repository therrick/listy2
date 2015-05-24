class AislesController < ApplicationController
  respond_to :html, :xml, :json
  before_action :authenticate_user!
  before_action :set_store
  before_action :set_aisle, only: [:show, :edit, :update, :destroy]

  def index
    @aisles = current_user.aisles.where(hidden: false)
    respond_with @aisles
  end

  def show
    respond_with @aisle
  end

  def new
    @aisle = current_user.aisles.new
    respond_with @aisle
  end

  def edit
    respond_with @aisle
  end

  def create
    @aisle = current_user.aisles.new(aisle_params)
    flash[:notice] = 'Successfully created aisle' if @aisle.save
    respond_with(@aisle)
  end

  def update
    @aisle = current_user.aisles.find(params[:id])
    flash[:notice] = 'Successfully updated product' if @aisle.update_attributes(aisle_params)
    respond_with(@aisle)
  end

  def destroy
    @aisle.destroy
    flash[:notice] = 'Successfully deleted product'
    respond_with(@aisle)
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
