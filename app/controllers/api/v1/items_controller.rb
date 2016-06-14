class API::V1::ItemsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  # def index
  #   # Initialise instance vairable (@var)
  #   @items = Item.all
  #   # Configure JBuilder format
  #   respond_to do |format|
  #     format.json { render :json => { items: @items } }
  #   end
  # end

  # def fetch_item
  #   @item = Item.find_by_id(params[:id])
  # end

  def index
    # Initialise instance vairable (@var)
    @items = Item.all
    respond_to do |format|
      # Configure JBuilder format
      format.json { render json: @items }
      format.xml { render xml: @items }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @item }
      format.xml { render xml: @item }
    end
  end

  def create
    @item = Item.new(item_params)
    #@item.temp_password = Devise.friendly_token
    @item.id = nil
    respond_to do |format|
      if @item.save
        format.json { render json: @item, status: :created }
        format.xml { render xml: @item, status: :created }
      else
        format.json { render json: @item.errors, status: :unprocessable_entity }
        format.xml { render xml: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @item = Item.find_by_id(params[:id])
    respond_to do |format|
      if @item.update_attributes(item_params) #
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
      else
        format.json { render json: @item.errors, status: :unprocessable_entity }
        format.xml { render xml: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item = Item.find_by_id(params[:id])
    respond_to do |format|
      if @item.destroy
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
      else
        format.json { render json: @item.errors, status: :unprocessable_entity }
        format.xml { render xml: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def item_params
    params.require(:item).permit(:id, :item_name, :created_at, :updated_at)
  end

end
