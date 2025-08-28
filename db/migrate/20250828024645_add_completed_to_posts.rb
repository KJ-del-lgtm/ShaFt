class AddCompletedToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :completed, :boolean
  end
end
