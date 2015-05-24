class Item < ActiveRecord::Base
  belongs_to :store
  belongs_to :aisle
  validates :store, presence: true
  validates :name, presence: true, uniqueness: { scope: :store_id }
end
