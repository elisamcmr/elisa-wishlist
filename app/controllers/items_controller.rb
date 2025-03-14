class ItemsController < ApplicationController
  before_action :authenticate_admin!

  def new
    @item = Item.new
    @item.bookmarks.build(list_id: params[:list_id]) if params[:list_id]
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      # Extract images if URL is provided
      ImageExtractorService.extract_and_attach(@item, @item.url) if @item.url.present?
      redirect_to list_path(@item.lists.first)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to list_path(@item.lists.first)
  end

  private

  def item_params
    params.require(:item).permit(:name, :url, :description, :price, bookmarks_attributes: [:list_id])
  end
end
