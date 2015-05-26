class Aisle < ActiveRecord::Base
  belongs_to :store
  has_many :items
  validates :store, presence: true
  validates :name, presence: true, uniqueness: { scope: :store_id }

  def name_and_description
    [name, description].join(': ')
  end
end
