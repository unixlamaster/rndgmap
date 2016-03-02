class CreatePoligons < ActiveRecord::Migration
  def change
    create_table :poligons do |t|
      t.string :coords
      t.string :name
      t.string :url
      t.string :year

      t.timestamps null: false
    end
  end
end
