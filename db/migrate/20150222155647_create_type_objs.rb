class CreateTypeObjs < ActiveRecord::Migration
  def change
    create_table :type_objs do |t|
      t.string :objclass
      t.string :src

      t.timestamps null: false
    end
  end
end
