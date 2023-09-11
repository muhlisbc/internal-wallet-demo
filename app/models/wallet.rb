class Wallet < ApplicationRecord
  include ActiveModel::Serializers::JSON

  belongs_to :user

  has_many :credits,  foreign_key: "target_wallet_id", class_name: "Transaction", dependent: :destroy
  has_many :debits,   foreign_key: "source_wallet_id", class_name: "Transaction", dependent: :destroy

  validates :user_id, uniqueness: true
  validates_associated :user

  def balance
    credits.sum(:amount) - debits.sum(:amount)
  end
end
