class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :account, dependent: :destroy

  has_many :orders

  after_create :create_account

  private

  def create_account
    account = Account.create(user_id: self.id)
    account.save
  end
end
