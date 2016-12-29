class CreateProblems < ActiveRecord::Migration[5.0]
  def change
    create_table :problems do |t|
      t.string :name
      t.string :description
      t.string :link
      t.references :competition, foreign_key: true

      t.timestamps
    end
  end
end
