class AddExampleToProblems < ActiveRecord::Migration[5.0]
  def change
    add_column :problems, :example, :string
  end
end
