class AddFieldToPoligon < ActiveRecord::Migration
  def change
    add_column :poligons, :area_id, :integer
  end
end
