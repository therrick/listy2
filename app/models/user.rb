class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  enum role: [:user, :admin]
  after_initialize :set_default_role, if: :new_record?
  has_many :stores, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    role.to_sym == :admin
  end

  private

  def set_default_role
    self.role ||= :user
  end
end
