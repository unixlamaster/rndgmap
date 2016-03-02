class ChangeLongtitudeOnMapobj < ActiveRecord::Migration
  def change
    rename_column :mapobjs, :longtitude, :longitude
  end
end
