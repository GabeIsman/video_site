class VideoController < ApplicationController
  def index
    @featured = Video.limit(3)
  end

  def all
    @videos = Video.all
  end
end
