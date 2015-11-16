class Meal < ActiveRecord::Base
  belongs_to :component
  belongs_to :calendar
end
