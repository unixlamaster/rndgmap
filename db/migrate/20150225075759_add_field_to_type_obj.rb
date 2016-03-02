class AddFieldToTypeObj < ActiveRecord::Migration
  def change
     add_column :type_objs, :icon_src, :string
  end
end
