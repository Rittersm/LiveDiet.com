class RatingAndCategoryModelIntegration < ActiveRecord::Migration[5.0]
  def change
    remove_column :plans, :category, :string
    add_reference :plans, :category, index: true
    remove_column :subscriptions, :rating, :integer
    add_reference :subscriptions, :rating, index: true
  end
end
