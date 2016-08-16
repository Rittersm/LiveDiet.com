class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.text :daily_overview
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
