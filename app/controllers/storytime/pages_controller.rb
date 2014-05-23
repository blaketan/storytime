require_dependency "storytime/application_controller"

module Storytime
  class PagesController < ApplicationController
    before_action :ensure_site, unless: ->{ params[:controller] == "storytime/dashboard/sites" }
    def show
      params[:id] = Site.selected_root_page_id if request.path == "/"
      
      @page = Page.published.friendly.find(params[:id])

      if request.path != page_path(@page)
        return redirect_to @page, :status => :moved_permanently
      end
    end
  end
end