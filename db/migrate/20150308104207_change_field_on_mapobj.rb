class ChangeFieldOnMapobj < ActiveRecord::Migration
  def change
    rename_column :mapobjs, :description, :years2
  end
end
