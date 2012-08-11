class AvatarItemsController < ApplicationController
  # GET /avatar_items
  # GET /avatar_items.json
  def index
    @avatar_items = AvatarItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @avatar_items }
    end
  end

  # GET /avatar_items/1
  # GET /avatar_items/1.json
  def show
    @avatar_item = AvatarItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @avatar_item }
    end
  end

  # GET /avatar_items/new
  # GET /avatar_items/new.json
  def new
    @avatar_item = AvatarItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @avatar_item }
    end
  end

  # GET /avatar_items/1/edit
  def edit
    @avatar_item = AvatarItem.find(params[:id])
  end

  # POST /avatar_items
  # POST /avatar_items.json
  def create
    @avatar_item = AvatarItem.new(params[:avatar_item])

    respond_to do |format|
      if @avatar_item.save
        format.html { redirect_to @avatar_item, notice: 'Avatar item was successfully created.' }
        format.json { render json: @avatar_item, status: :created, location: @avatar_item }
      else
        format.html { render action: "new" }
        format.json { render json: @avatar_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /avatar_items/1
  # PUT /avatar_items/1.json
  def update
    @avatar_item = AvatarItem.find(params[:id])

    respond_to do |format|
      if @avatar_item.update_attributes(params[:avatar_item])
        format.html { redirect_to @avatar_item, notice: 'Avatar item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @avatar_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /avatar_items/1
  # DELETE /avatar_items/1.json
  def destroy
    @avatar_item = AvatarItem.find(params[:id])
    @avatar_item.destroy

    respond_to do |format|
      format.html { redirect_to avatar_items_url }
      format.json { head :no_content }
    end
  end
end
