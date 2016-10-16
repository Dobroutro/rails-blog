class TagsController < ApplicationController

  http_basic_authenticate_with name: "admin", password: "test", except: []  

  def create
    respond_to do |format|   
      @item = Item.find(params[:item_id])
      @checktag = Tag.where(name: params[:tag][:name]).first()

      if(@checktag)    
        @itemtag_check = ItemsTag.where("item_id = ? AND tag_id = ?", @item.id, @checktag.id).first()      
        unless(@itemtag_check)
          @itemtag = ItemsTag.new(item_id: @item.id, tag_id: @checktag.id)
          if (@itemtag.save())                    
            format.json { render json: @itemtag, status: :created}
          end
          format.json { render json: @itemtag.errors, status: :unprocessable_entity }
        end

        format.json { render json: {}, status: :unprocessable_entity }
      end 

      unless(@checktag)         
        if (@itemtag = @item.tags.create(tag_params))
          format.json { render json: {'tag_id':@itemtag.id, 'item_id':@item.id }, status: :created}
        end

        format.json { render json: @item.tags.errors, status: :unprocessable_entity }
      end

    end
  end
 
  def destroy 
    respond_to do |format|   
      @item = Item.find(params[:item_id])
      @itemtag = ItemsTag.where("item_id = ? AND tag_id = ?", params[:item_id], params[:id]).first()    

      if(@itemtag.destroy)
        @itemtag_check = ItemsTag.where(tag_id: params[:id]).first()      
        unless(@itemtag_check) 
          @tag = Tag.find(params[:id])
          @tag.destroy      
        end                

        format.json { render json: @itemtag, status: :ok}
      end
      
      format.json { render json: @item.errors, status: :unprocessable_entity }
    end
  end
 
  private
    def tag_params
      params.require(:tag).permit(:name)
    end 
end
