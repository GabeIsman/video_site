class TagController < ApplicationController
  def index
    @tags = Tag.all
  end

  def view
    tag_name = params[:id] || ""
    @tag = Tag.find_by_name(tag_name.titleize.downcase)
    if !@tag
      flash[:error] = "Tag not found."
      return redirect_to :controller => :tag, :action => :index
    end
    render '/tag/view'
  end

  def update_homepage
    tag_value_pairs = params.select{ |k,v| v.to_i != 0 }
  
    Tag.all.each{ |t| t.update_attributes(:homepage => 0) }
    
    tag_value_pairs.each do |k,v|
      t = Tag.find(k.to_i) rescue nil
      break unless t
      t.homepage = v.to_i
      t.save!
    end
    redirect_to :controller => :video, :action => :index
  end

  def edit_homepage_tags
    @tags = Tag.all.select{ |t| t.videos.count > 5 }
  end
    
end
