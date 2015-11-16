require 'rails_helper'

RSpec.describe Meal, type: :model do
  before(:each) { @meal = build(:meal) }

  subject { @meal }

  it { should respond_to(:component) }
  it { should respond_to(:calendar) }
end
