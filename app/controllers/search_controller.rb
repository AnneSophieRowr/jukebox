class SearchController < ApplicationController

  def search
    q = "%#{params[:q].downcase}%"

    unless q.empty?
      objects = []
      %w{Song Playlist Album Artist}.each do |model|
        objects << model.constantize.search(q)
      end

      results = objects.flatten.collect {|o| {label: o.name.capitalize , details: o.details, url: o.respond_to?(:show_path) ? o.show_path : polymorphic_url(o), img: o.image.url(:thumb)}}
    
      render json: results
    end
  end

end
