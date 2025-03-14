class WebsitesController < ApplicationController
  def index
    @categories = Website.distinct.pluck(:category)
    @selected_category = params[:category]
    @websites = Website.all
    @websites = @websites.where(category: @selected_category) if @selected_category.present?
    @websites = @websites.order(:category, :name)
  end

  def new
    @website = Website.new
  end

  def create
    @website = Website.new(website_params)
    if @website.save
      redirect_to websites_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def website_params
    params.require(:website).permit(:name, :url, :category, :description)
  end
end
