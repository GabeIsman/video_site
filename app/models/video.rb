class Video < ActiveRecord::Base
  has_and_belongs_to_many :tags
	NUM_RELATED_VIDEOS = 5

	# TODO this could be better/faster
	def related_videos
		related_videos = {}
		tags.each do |t|
			shared_tag_videos = t.videos
			size = shared_tag_videos.count
			shared_tag_videos.each do |v|
				next if v.id == id
				key = "#{v.id}"
				related_videos[key] = related_videos[key] ? related_videos[key] + 1.0/size : 1.0/size
			end
		end
		# Hash sorting is really weird
		# When you call sort on a hash it first converts into an array of arrays, each of the
		# form [key, value] and then sorts that. So here we pass a block to customize the 
		# comparison to sort on the value, rather than the key. We them map the result (which
		# is an array of arrays) to the first element of each (which is the key). In the end
		# we get a sorted array of keys, ordered by their value in the original hash.
		ordered_by_score = related_videos.sort{|a,b| b[1] <=> a[1]}.map(&:first)
		ordered_by_score[0,NUM_RELATED_VIDEOS].map(&:to_i).map{|id| Video.find(id)}
	end
end
