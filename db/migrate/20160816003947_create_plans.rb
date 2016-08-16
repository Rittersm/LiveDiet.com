class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.text :overview
      t.string :category
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
