class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.references :user, index: { unique: true }

      t.timestamps
    end
  end
end
