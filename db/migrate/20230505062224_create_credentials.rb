class CreateCredentials < ActiveRecord::Migration[7.0]
  def change
    create_table :credentials do |t| # might do a UUID
      t.references :user, null: false, foreign_key: true
      t.string :nickname, null: false
      t.string :external_id, null: false
      t.string :public_key, null: false
      t.integer :sign_count, null: false, default: 0

      t.timestamps
    end

    add_index :credentials, :external_id, unique: true
    add_index :credentials, %i[nickname user_id], unique: true
  end
end
