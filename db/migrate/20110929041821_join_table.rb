class JoinTable < ActiveRecord::Migration
  def up
    create_table :tags_videos, :id => false do |t|
      t.integer :tag_id
      t.integer :video_id
    end
  end

  def down
  end
end
