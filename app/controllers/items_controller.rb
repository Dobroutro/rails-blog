class ItemsController < ApplicationController  

  http_basic_authenticate_with name: "admin", password: "test", except: []  

  def index
    @items = Item.includes(:tags).all.order(id: :desc).order("tags.name desc")
  end
    
  def new
    @item = Item.new
  end 

  def show
    redirect_to root_url
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = 'Created!'
      redirect_to items_path
    else
      render 'new' 
    end   
  end    

  def update
    @item = Item.find(params[:id])   
    if @item.update(item_params)
      flash[:notice] = 'Updated!'
      redirect_to items_path
    else
      render 'edit'
    end
  end

  def destroy
    respond_to do |format|  
      @item = Item.find(params[:id]) 
      if @item.destroy
        @tags = Tag.all
        @tags.each do |tag|
          unless(tag.items.present?)
            tag.destroy
          end
        end 
        format.json { render json: @item, status: :ok }
      end 
      
      format.json { render json: @item.errors, status: :unprocessable_entity }
    end
  end  

  private
    def item_params
      params.require(:item).permit(:heading, :body, :image, :remove_image)
    end    
end
