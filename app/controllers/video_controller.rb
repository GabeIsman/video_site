class VideoController < ApplicationController
  
	before_filter :login_required, :only => [:edit, :update]
  
  def index
  end

	def search
		@keywords = params[:search].gsub(/[^\w\d\s]/,'').split(' ') rescue nil
		if @keywords.nil? || @keywords.select{|k| !k.blank?}.empty?
			flash[:error] = "Enter a search term"
			redirect_to :root
		end
    @where_clause = @keywords.map{|k| "UPPER(title) LIKE '%#{k.upcase}%' OR UPPER(description) LIKE '%#{k.upcase}%'"}.join(' OR ')
		@videos = Video.where(@where_clause).paginate(:page => params[:page])
		render 'all'
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

	def lucky
		random_id = Video.all.map(&:id).sample
		return redirect_to :controller => :video, :action => :view, :id => random_id
	end

	# XHR ONLY
	def render_video
		video = find_video(params[:id])
		return render :partial => 'slider_embed', :object => video
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
