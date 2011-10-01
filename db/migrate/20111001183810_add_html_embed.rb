class AddHtmlEmbed < ActiveRecord::Migration
  def up
    add_column :videos, :embed_html, :text
  end

  def down
  end
end
