# -*- coding: utf-8 -*-
class TwittersController < ApplicationController
#  before_filter :require_admin, :except => [:oauth, :callback, :get_tweets]
  # GET /twitters
  # GET /twitters.xml
  def index
    @twitters = Twitter.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @twitters }
    end
  end

  # GET /twitters/1
  # GET /twitters/1.xml
  def show
    @twitter = Twitter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @twitter }
    end
  end

  # GET /twitters/new
  # GET /twitters/new.xml
  def new
    @twitter = Twitter.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @twitter }
    end
  end

  # GET /twitters/1/edit
  def edit
    @twitter = Twitter.find(params[:id])
  end

  # POST /twitters
  # POST /twitters.xml
  def create
    @twitter = Twitter.new(params[:twitter])

    respond_to do |format|
      if @twitter.save
        format.html { redirect_to(@twitter, :notice => 'Twitter was successfully created.') }
        format.xml  { render :xml => @twitter, :status => :created, :location => @twitter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @twitter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /twitters/1
  # PUT /twitters/1.xml
  def update
    @twitter = Twitter.find(params[:id])

    respond_to do |format|
      if @twitter.update_attributes(params[:twitter])
        format.html { redirect_to(@twitter, :notice => 'Twitter was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @twitter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /twitters/1
  # DELETE /twitters/1.xml
  def destroy
    @twitter = Twitter.find(params[:id])
    @twitter.destroy

    respond_to do |format|
      format.html { redirect_to(twitters_url) }
      format.xml  { head :ok }
    end
  end

  def oauth
    #Twitterから未認可のrequest tokenを発行してもらう
    request_token = self.consumer.get_request_token(
                                                    #コールバックURLの指定
       :oauth_callback => "http://#{request.host_with_port}/twitters/callback"
                                                    )
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    #未認可のrequest tokenをURLに含め、Twitterの認証画面にリダイレクト
    redirect_to request_token.authorize_url
  end

  def callback
    consumer = self.consumer
    #許可済みのrequest tokenをaccess tokenと交換する
    request_token = OAuth::RequestToken.new(
      consumer,
      session[:request_token],
      session[:request_token_secret]
    )
    begin
      access_token = request_token.get_access_token(
        {},
        :oauth_token => params[:oauth_token],
        :oauth_verifier => params[:oauth_verifier]
      )
    rescue OAuth::Unauthorized
      redirect_to :controller => :avatars, :action => :show, :id => current_account.avatar.id
      return
    end
     #access tokenが正しいか検証
    response = consumer.request(
      :get,
      '/account/verify_credentials.json', access_token, { :scheme => :query_string }
    )
    case response
      when Net::HTTPSuccess
      @user_info = JSON.parse(response.body)
      unless @user_info['screen_name']
        flash[:notice] = "Authentication failed"
        redirect_to :controller => :avatars, :action => :show, :id => current_account.avatar.id
      end
    else
      RAILS_DEFAULT_LOGGER.error "Failed to get user info via OAuth"
      flash[:notice] = "Authentication failed"
        redirect_to :controller => :avatars, :action => :show, :id => current_account.avatar.id
      return
    end
     #正しいaccess tokenと判明したので、セッションに保存しておく
     #request tokenはもう要らないので破棄
    if current_account.twitter.nil?
      tw = Twitter.new()
      tw.account = current_account
    else
      tw = current_account.twitter
    end
    tw.oauth_token    = access_token.token
    tw.oauth_verifier = access_token.secret
    tw.save
    session[:request_token] = nil
    session[:request_token_secret] = nil
    session[:oauth] = true
    session[:oauth_token] = access_token.token
    session[:oauth_verifier] = access_token.secret
    if current_account.avatar.avatar_twitter.nil?
      av_tw = AvatarTwitter.new()
      av_tw.avatar = current_account.avatar
      av_tw.twitter_name = current_account.avatar.name
      av_tw.save
      av = current_account.avatar
      av.image_url = "/images/pikatyu.jpeg"
      twitter_primer = Item.find_by_item_type(1)
      av.items.push(twitter_primer)
      av.save
    end
    redirect_to :action => :get_tweets
  end

  def get_tweets
    if session[:oauth]

      if current_account.twitter.nil?
      end
      #一度認証された後はaccess tokenだけでアクセス出来る
      token = OAuth::AccessToken.new(
        self.consumer,
        session[:oauth_token],
        session[:oauth_verifier]
      )
      rubytter = OAuthRubytter.new(token)
      id = rubytter.verify_credentials.id_str
      image_url = rubytter.verify_credentials.profile_image_url_https
      @friends_timelines = rubytter.user_timeline(id)
      current_twitter = current_account.twitter
      @friends_timelines.sort_by!{|tweet| tweet.id}
      last_tweet = current_twitter.last_tw_id
      @friends_timelines.each do |tweet|
        if tweet.id.to_i > last_tweet
          twt = Tweet.new
          twt.twitter_id = current_twitter.id
          twt.tw_id =  tweet.id.to_i
          twt.tw_str =  tweet.text
          twt.tw_image_url = image_url
          twt.tw_created_at = tweet.created_at.to_time.utc
          twt.save
          last_tweet = tweet.id.to_i
        end
      end

      
      @msg = []
      logs = GrowthLog.find(:all, :conditions => ['avatar_id =? and is_informed=?', current_account.avatar.id, false])
      logs.each do |log|
        if log.growth_type == GrowthLog::TWEETABLE
          @msg << "アバターが成長しました。"
          @msg << "アバターがつぶやき機能を獲得しました。"
          @msg << "アイテム　\"twitter読本\"を入手しました。"
          @is_new_icon = true
          log.is_informed = true
          log.save
        end
      end
      if current_twitter.last_tw_id != last_tweet
        @msg << "アバターのつぶやきが更新されました"
        current_twitter.last_tw_id = last_tweet
        current_twitter.save
      end
      @avatar = current_account.avatar
      @age = (Time.now.utc - @avatar.birthday).divmod(24*60*60)[0]
      render :template => "avatars/show" 
    else
      redirect_to :action => :oauth
    end
  end

end
