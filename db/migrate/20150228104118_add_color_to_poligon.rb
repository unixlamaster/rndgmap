class AddColorToPoligon < ActiveRecord::Migration
  def change
    add_column :poligons, :color, :string
  end
end
