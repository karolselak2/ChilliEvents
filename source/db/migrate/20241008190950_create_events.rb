class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :name
      t.integer :organiser_id
      t.datetime :start
      t.datetime :end
      t.integer :participants_limit

      t.timestamps
    end
  end
end
