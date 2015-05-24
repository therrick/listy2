class Store < ActiveRecord::Base
  belongs_to :user
  has_many :aisles, dependent: :destroy
  has_many :items, dependent: :destroy
  validates :name, presence: true, uniqueness: { scope: :user_id }
end
