class Item < ActiveRecord::Base
  belongs_to :store
  belongs_to :aisle
  validates :store, presence: true
  validates :name, presence: true, uniqueness: { scope: :store_id }

  scope :name_search, ->(term) { where('items.name like ?', "%#{term}%") }
  scope :needed, -> { where('items.number_needed > 0') }
  scope :not_needed, -> { where('items.number_needed = 0') }
  scope :order_by_aisles, -> { includes(:aisle).order('aisles.position, items.name') }

  def increment_needed
    self.number_needed += 1
    self.save!
  end

  def decrement_needed
    self.number_needed -= 1 unless number_needed == 0
    self.save!
  end

  def mark_purchased
    self.popularity += number_needed
    self.number_needed = 0
    self.save!
  end

  def undo_purchase(number_needed)
    self.popularity -= number_needed
    self.number_needed = number_needed
    self.save!
  end
end