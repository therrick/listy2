describe User do
  before(:each) { @user = User.new(email: 'user@example.com') }

  subject { @user }

  it { should respond_to(:email) }

  it '#email returns a string' do
    expect(@user.email).to match 'user@example.com'
  end

  describe '#admin?' do
    it 'returns false for non-admin' do
      expect(@user.admin?).to eq false
    end

    it 'returns true for admin' do
      user2 = create(:user, :admin, email: 'admin@example.com')
      expect(user2.admin?).to eq true
    end
  end
end
