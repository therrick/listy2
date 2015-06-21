class StoresController < ApplicationController
  respond_to :html, :xml, :json
  before_action :authenticate_user!
  before_action :set_store, only: [:show, :edit, :update, :destroy, :mark_all_purchased]

  def index
    @stores = current_user.stores.where(hidden: false)
    respond_with @stores
  end

  def show
    @previous_item,
      @previous_number_needed,
      @previous_item_is_new = set_previous_from_flash
    @list_items = @store.items.needed.order_by_aisles
    @other_items = @store.items.not_needed
    @other_items = apply_sort(@other_items)
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

  def set_previous_from_flash
    [@store.items.find_by(id: flash[:previous_item_id]),
     flash[:previous_number_needed],
     flash[:previous_item_is_new]]
  end

  def apply_sort(items)
    session[:sort] = 'pop' if params[:sort] == 'pop'
    session[:sort] = 'name' if params[:sort] == 'name'
    if session[:sort] == 'pop'
      items.order('items.popularity DESC')
    else
      items.order('items.name')
    end
  end
end
