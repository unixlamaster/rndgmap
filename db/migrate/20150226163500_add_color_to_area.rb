class AddColorToArea < ActiveRecord::Migration
  def change
    add_column :areas, :color, :string
  end
end
