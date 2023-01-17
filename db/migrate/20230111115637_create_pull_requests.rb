class CreatePullRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :pull_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :score
      t.integer :state
      t.datetime :created, null: false, default: -> { "CURRENT_TIMESTAMP" }

      t.timestamps
    end
  end
end
