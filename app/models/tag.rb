class Tag < ActiveRecord::Base
  has_and_belongs_to_many :videos

  def self.homepage_tags
  	Tag.all.select{ |t| t.homepage > 0 }
  end

	def homepage_videos( already_displayed_video_ids )
  	candidates = videos.order(:created_at)
		selected = []
		candidates.each do |v|
			selected << v unless already_displayed_video_ids.include?( v.id )
			break if selected.count == 5
		end
		return selected
	end
end
