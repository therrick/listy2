class Item < ActiveRecord::Base
  belongs_to :store
  belongs_to :aisle
  validates :store, presence: true
  validates :name, presence: true, uniqueness: { scope: :store_id }
  strip_attributes
  after_validation :maybe_clear_temp_note

  scope :needed, -> { includes(:aisle).where('items.number_needed > 0') }
  scope :not_needed, -> { includes(:aisle).where('items.number_needed = 0') }
  scope :order_by_aisles, (lambda do
    references(:aisle).order('coalesce(aisles.position,0), items.name')
  end)

  def aisle_name
    aisle.nil? ? '-' : aisle.name
  end

  def needed?
    number_needed > 0
  end

  def multiple_needed?
    number_needed > 1
  end

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

  def maybe_clear_temp_note
    self.temp_note = nil if self.number_needed == 0
  end
end
