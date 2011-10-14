class AddBigThumbnailToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :big_thumbnail_url, :string
  end
end
