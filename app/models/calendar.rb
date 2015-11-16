class Calendar < ActiveRecord::Base
  has_many :meals
  has_many :components, through: :meals
  after_save :clean_components

  def component_list
    components.map(&:name)
  end

  def component_list=(names_string)
    components.delete_all
    names_string.split(',').map!(&:strip).each do |name|
      unless components.where(name: name).exists?
        component = Component.find_or_initialize_by(name: name)
        components << component
      end
    end
  end

  def clean_components
    Component.clean_unreferenced
  end
end
