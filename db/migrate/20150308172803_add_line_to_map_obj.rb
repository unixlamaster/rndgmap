class AddLineToMapObj < ActiveRecord::Migration
  def change
    add_column :mapobjs, :line, :string
  end
end
