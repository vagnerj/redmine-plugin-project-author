class CreateProjectAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :project_authors do |t|
      t.integer :project_id
      t.integer :user_id
    end
  end
end
