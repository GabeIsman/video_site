class TagController < ApplicationController
  def index
    @tags = Tag.all
  end

  def list
    tag_name = params[:id] || ""
    tag = Tag.find_by_name(tag_name.titleize.downcase)
    if !tag
      flash[:error] = "Tag not found."
      return redirect_to :controller => :tag, :action => :index
    end
    @videos = tag.videos
    render '/video/all'
  end
end
