class Component < ActiveRecord::Base
  has_many :meals
  has_many :calendars, through: :meals
  validates :name, uniqueness: true

  def self.clean_unreferenced
    Component.includes(:meals).where(meals: { component_id: nil }).destroy_all
  end
end
