class ItemsController < ApplicationController
  respond_to :html, :xml, :json
  before_action :authenticate_user!
  before_action :set_store
  before_action :set_item, only: [:edit, :update, :destroy]

  def edit
    respond_with @item
  end

  def create
    @item = current_user.items.build(item_params, )
    flash[:notice] = 'Successfully created item' if @item.save
    respond_with(@item)
  end

  def update
    @item = current_user.items.find(params[:id])
    flash[:notice] = 'Successfully updated product' if @item.update_attributes(item_params)
    respond_with(@item)
  end

  def destroy
    @item.destroy
    flash[:notice] = 'Successfully deleted product'
    respond_with(@item)
  end

  private

  def set_store
    @store = current_user.stores.find(params[:store_id])
  end

  def set_item
    @item = @store.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :notes, :number_needed, :popularity)
  end
end
