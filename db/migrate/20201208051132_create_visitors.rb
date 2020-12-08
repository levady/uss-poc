class CreateVisitors < ActiveRecord::Migration[6.0]
  def change
    create_table :visitors do |t|
      t.references :ride
      t.integer :visitors_count, null: false 
      t.timestamp :collected_at, null: false
      t.timestamp :created_at, null: false, default: -> { "NOW()" }
      t.timestamp :updated_at, null: false, default: -> { "NOW()" }
    end
    add_index :visitors, :collected_at
    add_index :visitors, [:ride_id, :visitors_count, :collected_at], unique: true
  end
end
