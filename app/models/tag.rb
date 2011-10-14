class Tag < ActiveRecord::Base
  has_and_belongs_to_many :videos

  def self.homepage_tags
    Tag.all.select{ |t| t.homepage == 1 }
  end
end
