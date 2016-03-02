class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :coords
      t.string :name
      t.integer :zoom

      t.timestamps null: false
    end
  end
end
