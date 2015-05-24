class StoresController < ApplicationController
  respond_to :html, :xml, :json
  before_action :authenticate_user!
  before_action :set_store, only: [:show, :edit, :update, :destroy, :mark_all_purchased]

  def index
    @stores = current_user.stores.where(hidden: false)
    respond_with @stores
  end

  def show
    respond_with @store
  end

  def new
    @store = current_user.stores.new
    respond_with @store
  end

  def edit
    respond_with @store
  end

  def create
    @store = current_user.stores.new(store_params)
    flash[:notice] = 'Successfully created store' if @store.save
    respond_with(@store)
  end

  def update
    @store = current_user.stores.find(params[:id])
    flash[:notice] = 'Successfully updated store' if @store.update_attributes(store_params)
    respond_with(@store)
  end

  def destroy
    @store.destroy
    flash[:notice] = 'Successfully deleted store'
    respond_with(@store)
  end

  def mark_all_purchased
    @store.items.where('number_needed > 0').each do |item|
      item.popularity += item.number_needed
      item.number_needed = 0
      item.save!
    end

    redirect_to store_url(@store.id)
  end

  private

  def set_store
    @store = current_user.stores.find(params[:id])
  end

  def store_params
    params.require(:store).permit(:name, :hidden)
  end
end
