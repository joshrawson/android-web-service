class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_name, null: false
      t.timestamps null: false
    end
  end
end
