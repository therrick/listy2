require 'rails_helper'

RSpec.describe Component, type: :model do
  before(:each) { @component = build(:component) }

  subject { @component }

  it { should respond_to(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should respond_to(:link) }
  it { should respond_to(:note) }

  describe '.clean_unreferenced' do
    it 'deletes unreferenced components' do
      comp1 = create(:component, name: 'comp1')
      Component.clean_unreferenced
      expect(Component.find_by(id: comp1.id)).to eq nil
    end
  end
end
