class CreateTests < ActiveRecord::Migration[5.0]
  def change
    create_table :tests do |t|
      t.text :input, array: true, default: []
      t.text :output
      t.references :problem, foreign_key: true

      t.timestamps
    end
  end
end
