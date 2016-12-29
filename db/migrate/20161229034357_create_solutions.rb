class CreateSolutions < ActiveRecord::Migration[5.0]
  def change
    create_table :solutions do |t|
      t.references :user, foreign_key: true
      t.references :problem, foreign_key: true
      t.string :language
      t.text :code
      t.boolean :validity

      t.timestamps
    end
  end
end
