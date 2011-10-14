class ChangeTagHomepageColumn < ActiveRecord::Migration
  def up
    change_column :tags, :homepage, :integer, :default => 0
  end

  def down
  end
end
