#!/usr/bin/env ruby

# Method to take a list of keyword strings, make sure they exist as tags in our DB
# and then return a list of tag objects
def process_tags(keywords)
  tags = []
  keywords.each do |s|
    t = Tag.find_by_name(s)
    t = Tag.create!(:name => s) unless t
    tags << t
  end
  tags
end

# Method to add a YouTubeIt::Video object to the database
# There's tons of information in the YouTubeIt::Video object
# We can pick and choose and expand over time what info we store
def add_or_update_video(yt_video)
	youtube_id = yt_video.video_id.split("video:").last # unique identifier so we don't repeat stuff
  db_video = Video.find_by_youtube_id(youtube_id)
  # don't update the video if it's already up to date
	return if db_video && db_video.updated_at > yt_video.updated_at
  db_video = Video.new unless db_video
  db_video.title = yt_video.title
	db_video.description = yt_video.description.gsub('apos;','\'') rescue nil
  db_video.url = yt_video.embed_url
  db_video.youtube_id = youtube_id
	db_video.tags = process_tags yt_video.keywords 
  db_video.thumbnail_url = yt_video.thumbnails.first.url #there are actually many thumbnails, we could improve this by being smart about picking
  # Three is a magic number -- the third thumbnail in the list is the big one
  db_video.big_thumbnail_url = yt_video.thumbnails.select{|t| t.height == 360 && t.width == 480}.first.url
  db_video.embed_html = yt_video.embed_html # TODO make sure this doesn't break IE
	db_video.views = yt_video.view_count
  db_video.save!
end

def load_videos 
	
	# You might want to change this
	ENV["RAILS_ENV"] ||= "production"
	
	require File.dirname(__FILE__) + "/../../config/application"
	Rails.application.require_environment!
	youtube_key = "AI39si63GkmwwSUsM06R5uFfHw8lBPs2WZ2llWTuCtTpcPksChgfbQFIa-Gee7mrRKp01Mg-DDWp8s9tXgODmR0dx7cw6vUrSA"

  Rails.logger.info "Grabbing youtube videos at #{Time.now}.\n"
  client = YouTubeIt::Client.new(:dev_key => youtube_key)
  if !client
    Rails.logger.info "Logging in to youtube failed. Aborting."
  else
    response = client.videos_by(:user => "OberlinCollege")
    Rails.logger.info "Videos by user failed." unless response
    while true do
      videos = response.videos
      videos.each do |v|
        add_or_update_video(v)
      end
      break unless response.next_page
      response = client.videos_by(:user => "OberlinCollege", :page => response.next_page)
    end
  end
end
