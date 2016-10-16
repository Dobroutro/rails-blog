class BlogController < ApplicationController
  def index
    @items = Item.all.order(id: :desc)
    @tags = Tag.all.order(id: :desc)

  end
  def post
    @item = Item.find(params[:id])
    @tags = Tag.joins(:items)
              .merge(Item.where(:id => params[:id]))
              .all.order(id: :desc)

  end    
  def tag
    @items = Item.joins(:tags)
              .merge(Tag.where(:id => params[:id]))
              .paginate(:page => params[:page], :per_page => 10)
    @tags = Tag.all.order(id: :desc)
  end  
end
