class VideoController < ApplicationController
  
  before_filter :populate_instance_variables
  
  def index
  end

	def search
    @search = Video.search do
			paginate( :page => params[:page], :per_page => Video.per_page )
			keywords( params[:search] )
		end
	end

  def all
		@videos = Video.paginate( :page => params[:page] )
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

	# XHR ONLY
	def render_video
		video = find_video(params[:id])
		return render :partial => 'slider_embed', :object => video
	end

  private
  
  def populate_instance_variables
    #@featured = Tag.find_by_name("featured").videos.limit(5)   
    @featured = Video.limit(5)
    @popular = Video.limit(3)
    @video_catagories = [ @featured, @popular ] 
    
    @important_tags = Tag.where("homepage > 0")
    
  end

  def find_video (id)
    video = Video.find(id) rescue nil
    if !video
      flash[:error] = "We're sorry we couldn't find that video"
    end
    video
  end
end
