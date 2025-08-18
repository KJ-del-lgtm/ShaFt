class ChangeGroupIdToAllowNullInPosts < ActiveRecord::Migration[6.1]
  def change
    change_column_null :posts, :group_id, true
  end
end
