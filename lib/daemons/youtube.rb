#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "production"

require File.dirname(__FILE__) + "/../../config/application"
Rails.application.require_environment!
youtube_key = "AI39si63GkmwwSUsM06R5uFfHw8lBPs2WZ2llWTuCtTpcPksChgfbQFIa-Gee7mrRKp01Mg-DDWp8s9tXgODmR0dx7cw6vUrSA"

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
  db_video = Video.find_by_youtube_id(yt_video.video_id)
  # TODO make this not update the video if it's already up to date
  # only do this after the script is done, as this way new fields get
  # dynamically update on old videos
  db_video = Video.new unless db_video
  db_video.title = yt_video.title
  db_video.description = yt_video.description
  db_video.url = yt_video.embed_url
  db_video.youtube_id = yt_video.video_id # unique identifier so we don't repeat stuff
  db_video.tags = process_tags yt_video.keywords 
  db_video.thumbnail_url = yt_video.thumbnails.first.url #there are actually many thumbnails, we could improve this by being smart about picking
  db_video.embed_html = yt_video.embed_html5 # TODO make sure this doesn't break IE
  db_video.save!
end

$running = true
Signal.trap("TERM") do 
  $running = false
end

while($running) do
  
  # Replace this with your code
  Rails.logger.auto_flushing = true
  Rails.logger.info "Grabbing youtube videos at #{Time.now}.\n"
  client = YouTubeIt::Client.new(:dev_key => youtube_key)
  if !client
    Rails.logger.info "Logging in to youtube failed. Sleeping."
  else
    response = client.videos_by(:user => "OberlinCollege")
    Rails.logger.info "Videos by user failed." unless response
    videos = response.videos
    videos.each do |v|
      add_or_update_video(v)
    end
  end

  sleep 10
end

