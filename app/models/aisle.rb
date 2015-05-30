class Aisle < ActiveRecord::Base
  belongs_to :store
  has_many :items
  default_scope { order(:position) }
  validates :store, presence: true
  validates :name, presence: true, uniqueness: { scope: :store_id }

  def name_and_description
    [name, description].join(': ')
  end
end
