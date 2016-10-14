class TagsController < ApplicationController

  http_basic_authenticate_with name: "admin", password: "test", except: []  

  def create
    @item = Item.find(params[:item_id])
    @checktag = Tag.where(name: params[:tag][:name]).first()

    if(@checktag)    
      @itemtag_check = Items_tag.where("item_id = ? AND tag_id = ?", @item.id, @checktag.id).first()      
      unless(@itemtag_check)
        @itemtag = Items_tag.new(item_id: @item.id, tag_id: @checktag.id)
        @itemtag.save()        
      end      
    else 
      @tag = @item.tags.create(tag_params)   
    end

    redirect_to @item 
  end
 
  def destroy
    
    @item = Item.find(params[:item_id])
    @itemtag = Items_tag.where("item_id = ? AND tag_id = ?", params[:item_id], params[:id]).first()
    @itemtag.destroy

    @itemtag_check = Items_tag.where(tag_id: params[:id]).first()
    unless(@itemtag_check) 
      @tag = Tag.find(params[:id])
      @tag.destroy      
    end

    redirect_to @item
  end
 
  private
    def tag_params
      params.require(:tag).permit(:name)
    end 
end
