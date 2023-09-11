class User < ApplicationRecord
  has_one :wallet, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } # simple validation
end
