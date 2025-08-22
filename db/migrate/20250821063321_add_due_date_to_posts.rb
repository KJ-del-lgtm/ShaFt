class AddDueDateToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :due_date, :date
  end
end
