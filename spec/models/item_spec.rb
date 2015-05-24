require 'rails_helper'

RSpec.describe Item, type: :model do
  before(:each) { @item = build(:item) }

  subject { @item }

  it { should respond_to(:aisle) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:store_id) }
  it { should validate_presence_of(:store) }
end
