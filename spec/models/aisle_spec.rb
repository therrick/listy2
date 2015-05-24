require 'rails_helper'

RSpec.describe Aisle, type: :model do
  before(:each) { @aisle = build(:aisle) }

  subject { @aisle }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:store_id) }
  it { should validate_presence_of(:store) }
end
