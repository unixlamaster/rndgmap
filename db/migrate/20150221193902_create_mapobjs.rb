class CreateMapobjs < ActiveRecord::Migration
  def change
    create_table :mapobjs do |t|
      t.string :year
      t.string :class
      t.string :latitude
      t.string :longtitude
      t.string :url
      t.string :name
      t.string :address

      t.timestamps null: false
    end
  end
end
