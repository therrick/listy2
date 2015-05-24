require 'rails_helper'

RSpec.describe Store, type: :model do
  before(:each) { @store = build(:store) }

  subject { @store }

  it { should respond_to(:name) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
