class VideoController < ApplicationController
  def index
    @featured = Video.limit(3)
  end
end
