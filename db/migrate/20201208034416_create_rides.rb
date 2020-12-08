class CreateRides < ActiveRecord::Migration[6.0]
  def change
    create_table :rides do |t|
      t.string :name, null: false
      t.string :status, null: false, default: 'operational'
      t.integer :capacity, null: false
      t.float :duration, null: false, comment: 'duration is in minutes'
      t.string :sensor_code, null: false

      t.timestamps
    end
    add_index :rides, :sensor_code, unique: true
  end
end
