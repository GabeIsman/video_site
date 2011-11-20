class ApplicationController < ActionController::Base
  protect_from_forgery
	
  before_filter :populate_instance_variables

	private

	def login_required
		current_user
		redirect_to log_in_path, :notice => "Please log in to access this page" unless @current_user
	end

	def current_user
		@current_user ||= User.find( session[:user_id] ) if session[:user_id]
	end

  def populate_instance_variables
    @featured = Tag.find_by_name("featured").videos.limit(5)   
    #@featured = Video.limit(5)
    @popular = Video.limit(5)
    @recent = Video.limit(5)
    @something = Video.limit(5)
    @video_catagories = [ @featured, @popular, @recent, @something ] 
    
    @important_tags = Tag.where("homepage > 0")
    #@popular_tags = Tag.where()
    
  end
end
