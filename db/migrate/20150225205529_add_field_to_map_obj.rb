class AddFieldToMapObj < ActiveRecord::Migration
  def change
    add_column :mapobjs, :area_id, :integer
  end
end
