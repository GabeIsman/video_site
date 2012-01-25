class ApplicationController < ActionController::Base
  protect_from_forgery
	
  before_filter :populate_instance_variables
	before_filter :current_user

	private

	def login_required
		current_user
		redirect_to log_in_path, :notice => "Please log in to access this page" unless @current_user
	end

	def current_user
		@current_user ||= User.find( session[:user_id] ) if session[:user_id]
	end

  def populate_instance_variables
		featured = Tag.find_by_name("featured") 
    @featured = featured.nil? ? Video.limit(5) : featured.videos.limit(5)   
    @popular = Video.order("views DESC").limit(5)
    @recent = Video.order(:created_at).limit(5)
    @video_categories = [@featured, @popular, @recent]
    @important_tags = Tag.where("homepage > 0")
  end
  
end
