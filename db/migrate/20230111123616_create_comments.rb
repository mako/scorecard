class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pull_request, null: false, foreign_key: true
      t.integer :score
      t.datetime :created, null: false, default: -> { "CURRENT_TIMESTAMP" }

      t.timestamps
    end
  end
end
