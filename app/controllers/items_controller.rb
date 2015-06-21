class ItemsController < ApplicationController
  respond_to :html, :json
  before_action :authenticate_user!
  before_action :set_store
  before_action :set_item, except: [:create]

  def edit
    respond_with @item
  end

  def create
    find_or_create_item_with_flash
    redirect_to store_path(@store.id)
  end

  def update
    @item = @store.items.find(params[:id])
    flash[:notice] = "#{@item.name} was updated" if @item.update_attributes(item_params)
    redirect_to store_path(@store.id)
  end

  def destroy
    @item.destroy
    flash[:notice] = "#{@item.name} was deleted"
    redirect_to store_path(@store.id)
  end

  def mark_purchased
    original_number_needed = @item.number_needed
    @item.mark_purchased

    notice = "#{@item.name} was marked purchased. "
    flash[:previous_item_id] = @item.id
    flash[:previous_number_needed] = original_number_needed
    redirect_to store_path(@store.id), notice: notice
  end

  def undo_purchase
    @item.undo_purchase(params[:number_needed].to_i)
    redirect_to store_path(@store.id), notice: 'undone per your request'
  end

  def add_needed
    @item.increment_needed
    flash[:notice] = "#{@item.name} number needed was incremented"
    redirect_to store_path(@store.id)
  end

  def subtract_needed
    @item.decrement_needed
    flash[:notice] = "#{@item.name} number needed was decremented"
    redirect_to store_path(@store.id)
  end

  def clear_needed
    @item.update_attributes(number_needed: 0)
    flash[:notice] = "#{@item.name} was removed from the needed list"
    redirect_to store_path(@store.id)
  end

  private

  def set_store
    @store = current_user.stores.find(params[:store_id])
  end

  def set_item
    @item = @store.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :notes, :number_needed, :popularity, :aisle_id)
  end

  def find_or_create_item_with_flash
    item = Item.find_or_initialize_by(store: @store, name: item_params[:name].downcase)
    item.number_needed += 1
    new = item.new_record?
    if item.save
      set_flash_from_item(item, new)
    else
      flash[:alert] = item.errors.full_messages.join('; ')
    end
  end

  def set_flash_from_item(item, new)
    flash[:notice] = "#{item.name} #{new ? 'was created' : 'number needed was incremented'}"
    flash[:previous_item_id] = item.id
    flash[:previous_item_is_new] = true
  end
end
