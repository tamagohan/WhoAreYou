class AvatarTwittersController < ApplicationController
  # GET /avatar_twitters
  # GET /avatar_twitters.xml
  def index
    @avatar_twitters = AvatarTwitter.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @avatar_twitters }
    end
  end

  # GET /avatar_twitters/1
  # GET /avatar_twitters/1.xml
  def show
    @avatar_twitter = AvatarTwitter.find(params[:id])
    @avatar = @avatar_twitter.avatar
    @tweets = @avatar_twitter.avatar_tweets.sort_by{|tw| -tw.id}

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @avatar_twitter }
    end
  end

  # GET /avatar_twitters/new
  # GET /avatar_twitters/new.xml
  def new
    @avatar_twitter = AvatarTwitter.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @avatar_twitter }
    end
  end

  # GET /avatar_twitters/1/edit
  def edit
    @avatar_twitter = AvatarTwitter.find(params[:id])
  end

  # POST /avatar_twitters
  # POST /avatar_twitters.xml
  def create
    @avatar_twitter = AvatarTwitter.new(params[:avatar_twitter])

    respond_to do |format|
      if @avatar_twitter.save
        format.html { redirect_to(@avatar_twitter, :notice => 'Avatar twitter was successfully created.') }
        format.xml  { render :xml => @avatar_twitter, :status => :created, :location => @avatar_twitter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @avatar_twitter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /avatar_twitters/1
  # PUT /avatar_twitters/1.xml
  def update
    @avatar_twitter = AvatarTwitter.find(params[:id])

    respond_to do |format|
      if @avatar_twitter.update_attributes(params[:avatar_twitter])
        format.html { redirect_to(@avatar_twitter, :notice => 'Avatar twitter was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @avatar_twitter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /avatar_twitters/1
  # DELETE /avatar_twitters/1.xml
  def destroy
    @avatar_twitter = AvatarTwitter.find(params[:id])
    @avatar_twitter.destroy

    respond_to do |format|
      format.html { redirect_to(avatar_twitters_url) }
      format.xml  { head :ok }
    end
  end
end
