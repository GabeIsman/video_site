class AddThumbnailUrl < ActiveRecord::Migration
  def up
    add_column :videos, :thumbnail_url, :string
  end

  def down
  end
end
