class VideoController < ApplicationController
  def index
    @featured = Video.limit(3)
    @important_tags = Tag.where("homepage > 0")
  end

  def tags
    
  end

  def all
    @videos = Video.all
  end

  def view
    id = params[:id]
    @video = find_video(id)
    return redirect_to :controller => :video, :action => :index unless @video
  end

  def edit
    id = params[:id]
    @video = find_video(id)
    return redirect_to :controller => :video, :action => :index unless @video
  end

  def update
    video = find_video(params[:video][:id])
    return redirect_to :controller => :video, :action => :index unless video
    video.update_attributes!(params[:video])
  end

  private

  def find_video (id)
    video = Video.find(id) rescue nil
    if !video
      flash[:error] = "We're sorry we couldn't find that video"
    end
    video
  end
end
