describe User do
  before(:each) { @user = build(:user, email: 'user@example.com') }

  subject { @user }

  it { should respond_to(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:email) }
  it { should respond_to(:name) }

  it '#email returns a string' do
    expect(@user.email).to match 'user@example.com'
  end

  describe '#admin?' do
    it 'returns false for non-admin' do
      expect(@user.admin?).to eq false
    end

    it 'returns true for admin' do
      user2 = build(:user, :admin, email: 'admin@example.com')
      expect(user2.admin?).to eq true
    end
  end
end
