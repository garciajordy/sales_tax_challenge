class PagesController < ApplicationController
  include BasketConcern

  def index; end

  def create
    if params[:file]

      @basket = get_document(params[:file])
    else
      flash.now[:error] = 'Please upload a text file!'
    end
    render :index
  end
end
