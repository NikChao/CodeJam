class CreateCompetitions < ActiveRecord::Migration[5.0]
  def change
    create_table :competitions do |t|
      t.string :name
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
