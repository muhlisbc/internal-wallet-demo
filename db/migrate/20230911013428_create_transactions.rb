class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.float   :amount,            null: false
      t.integer :source_wallet_id
      t.integer :target_wallet_id

      t.index   :source_wallet_id
      t.index   :target_wallet_id

      t.timestamps
    end
  end
end
