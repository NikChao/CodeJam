class AddPointsToProblem < ActiveRecord::Migration[5.0]
  def change
    add_column :problems, :points, :integer
  end
end
