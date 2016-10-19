class CreateItjuziOrganizations < ActiveRecord::Migration
  def change
    create_table :itjuzi_organizations do |t|
      t.string :link, index: true
      t.string :icon_url
      t.string :name
      t.timestamps null: false
    end
  end
end
