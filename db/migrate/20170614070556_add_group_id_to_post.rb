class AddGroupIdToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :post, :group_id, :integer
  end
end
