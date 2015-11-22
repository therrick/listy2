require 'rails_helper'

RSpec.describe Item, type: :model do
  before(:each) { @item = build(:item) }

  subject { @item }

  it { should respond_to(:aisle) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:store_id) }
  it { should validate_presence_of(:store) }
  it { should respond_to(:temp_note) }

  it 'clears temp note when number_needed reaches zero' do
    subject.number_needed = 1
    subject.temp_note = 'test'
    subject.save!
    expect(subject.temp_note).to eq 'test'
    subject.number_needed = 0
    subject.save!
    expect(subject.temp_note).to eq nil
  end
end
