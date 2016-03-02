class RenameColumnName < ActiveRecord::Migration
  def change
    rename_column :mapobjs, :class, :objclass
  end
end
