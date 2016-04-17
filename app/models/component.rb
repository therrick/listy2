class Component < ActiveRecord::Base
  strip_attributes
  has_many :meals, dependent: :destroy
  has_many :calendars, through: :meals
  validates :name, presence: true, uniqueness: true

  def self.clean_unreferenced
    Component.includes(:meals).where(note: nil, link: nil,
                                     meals: { component_id: nil }).destroy_all
  end
end
