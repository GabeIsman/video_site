class UpdateVideoAttributeName < ActiveRecord::Migration
  def up
    rename_column(:videos, :name, :title)
  end

  def down
  end
end
