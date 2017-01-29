class AddDifficultyToProblems < ActiveRecord::Migration[5.0]
  def change
    add_column :problems, :difficulty, :string
  end
end
