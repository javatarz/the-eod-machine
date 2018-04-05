class DeleteCategoriesWithoutATeam < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      DELETE FROM categories WHERE team_id IS NULL
    SQL
  end

  def down

  end
end
