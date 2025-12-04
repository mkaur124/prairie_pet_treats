class PagesController < ApplicationController
  def show
    @page = StaticPage.find_by(slug: params[:slug])
    if @page
      render :show
    else
      render plain: "Page not found", status: :not_found
    end
  end
end
