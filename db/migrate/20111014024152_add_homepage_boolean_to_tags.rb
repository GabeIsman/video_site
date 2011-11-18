class AddHomepageBooleanToTags < ActiveRecord::Migration
  def change
    add_column :tags, :homepage, :integer, :default => 0
  end
end
