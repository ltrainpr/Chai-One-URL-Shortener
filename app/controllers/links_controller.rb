class LinksController < ApplicationController
  def index
    @links = Link.all

    respond_to do |format|
      format.json {render json: @links}
      format.xml {render xml: @links}
    end
  end

  def new
    @link = Link.new
  end

  def create
    normalized_url = Link.normalize_url(link_params)
    @link = Link.where(url: normalized_url).first_or_initialize(short_url: Link.random_number(normalized_url))


    if @link.save
      redirect_to "/links/#{@link.id}"
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end

  def show
    @link = Link.find(params[:id])
  end

  private

    def link_params
       params.required(:link).permit(:url, :short_url)
    end
end