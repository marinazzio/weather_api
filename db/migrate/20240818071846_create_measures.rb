class CreateMeasures < ActiveRecord::Migration[7.2]
  def change
    create_table :measures do |t|
      t.datetime :timestamp
      t.decimal :temperature
      t.references :city, null: false, foreign_key: true
    end
  end
end
