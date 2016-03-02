class AddFieldToMapobj < ActiveRecord::Migration
  def change
    add_column :mapobjs, :description, :string
    add_column :mapobjs, :result, :string
    add_column :mapobjs, :amount, :string
    add_column :mapobjs, :cost, :float
  end
end
