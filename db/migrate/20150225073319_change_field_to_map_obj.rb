class ChangeFieldToMapObj < ActiveRecord::Migration
  def change
     remove_column :mapobjs, :objclass
     add_column :mapobjs, :type_id, :integer
  end
end
