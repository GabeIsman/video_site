class AddHomepageBooleanToTags < ActiveRecord::Migration
  def change
    add_column :tags, :homepage, :bool, :default => 0
  end
end
