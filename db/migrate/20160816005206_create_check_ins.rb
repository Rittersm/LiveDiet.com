class CreateCheckIns < ActiveRecord::Migration[5.0]
  def change
    create_table :check_ins do |t|
      t.integer :weight
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
