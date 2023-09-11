class Transaction < ApplicationRecord
  include ActiveModel::Serializers::JSON

  belongs_to :source_wallet, foreign_key: "source_wallet_id", class_name: "Wallet", optional: true
  belongs_to :target_wallet, foreign_key: "target_wallet_id", class_name: "Wallet", optional: true

  validates :amount, presence: true
  validates :source_wallet, presence: true, if: Proc.new { |t| t.source_wallet_id.present? }
  validates :target_wallet, presence: true, if: Proc.new { |t| t.target_wallet_id.present? }

  validate :transfer_validation

  def balance
    @balance ||= source_wallet.balance
  end

  private

  def transfer_validation
    if source_wallet_id.blank? && target_wallet_id.blank?
      errors.add(:base, "Transfer requires both source and target wallet")
    elsif source_wallet_id.blank? && target_wallet_id.present? # deposit
      if amount < 0
        errors.add(:amount, "Invalid deposit amount: #{amount} less than 0")
      end
    elsif source_wallet_id.present? && target_wallet_id.blank? # withdraw
      if amount > balance
        errors.add(:amount, "Invalid withdraw amount: available balance #{balance} is less than requested amount #{amount}")
      end
    else
      if amount < 0
        errors.add(:amount, "Invalid transfer amount: #{amount} less than 0")
      else
        # validate source balance
        if amount > balance
          errors.add(:amount, "Invalid transfer amount: #{amount} is more than available balance #{balance}")
        end
      end
    end
  end
end
