class CreateItjuziOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :itjuzi_organizations do |t|
      t.string :link, index: true
      t.string :icon_url
      t.string :name, index: true
      t.timestamps null: false
    end
  end
end
