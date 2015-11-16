require 'rails_helper'

RSpec.describe Calendar, type: :model do
  before(:each) { @calendar = build(:calendar) }

  subject { @calendar }

  it { should respond_to(:date) }
  it { should respond_to(:meal_time) }

  it 'returns component names for component_list' do
    subject.components << (create :component)
    subject.components << (create :component)
    expect(subject.component_list)
      .to match_array [subject.components.first.name, subject.components.second.name]
  end

  it 'allows components to be set via component_list' do
    subject.component_list = 'comp1, comp2'
    expect(subject.component_list)
      .to match_array %w(comp1 comp2)
  end

  it 'removes components via component_list' do
    subject.components << (create :component)
    subject.components << (create :component)
    subject.component_list = 'comp1'
    expect(subject.component_list)
      .to match_array ['comp1']
  end
end
