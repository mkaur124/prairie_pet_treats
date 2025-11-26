class PagesController < ApplicationController
  def show
    @page = Page.find_by(slug: params[:slug])
    if @page
      render :show
    else
      render plain: "Page not found", status: :not_found
    end
  end
end
