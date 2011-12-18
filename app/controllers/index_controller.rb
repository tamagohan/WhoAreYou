# -*- coding: utf-8 -*-
class IndexController < ApplicationController
  def index
    #認証されている場合、自分のタイムラインを持ってくる
    if session[:oauth]
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
      current_av_twitter = current_account.avatar.avatar_twitter
      @friends_timelines.sort_by!{|tweet| tweet.id}
      @friends_timelines.each do |tweet|
        if tweet.id.to_i > current_twitter.last_tw_id
          twt = Tweet.new
          twt.twitter_id = current_twitter.id
          twt.tw_id =  tweet.id.to_i
          twt.tw_str =  tweet.text
          twt.tw_image_url = image_url
          twt.tw_created_at = tweet.created_at.to_time.utc
          twt.save
          current_twitter.last_tw_id = tweet.id.to_i
          current_twitter.save
#           unless current_account.avatar.avatar_twitter.nil?
#             tweet.id.to_i > current_av_twitter.last_cp_tw_id
#             av_twt = AvatarTweet.new
#             av_twt.avatar_twitter = current_account.avatar.avatar_twitter
#             av_twt.tw_av_str = tweet.text
#             av_twt.tw_av_image_url = image_url
#             av_twt.save
#             current_av_twitter.last_cp_tw_id = tweet.id.to_i
#           end
        end
      end
#      current_av_twitter.save
    end
  end

  def oauth
     #Twitterから未認可のrequest tokenを発行してもらう
     request_token = self.consumer.get_request_token(
      #コールバックURLの指定
       :oauth_callback => "http://#{request.host_with_port}/index/callback"
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
    access_token = request_token.get_access_token(
      {},
      :oauth_token => params[:oauth_token],
      :oauth_verifier => params[:oauth_verifier]
    )
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
        redirect_to :action => :index
      end
    else
      RAILS_DEFAULT_LOGGER.error "Failed to get user info via OAuth"
      flash[:notice] = "Authentication failed"
      redirect_to :action => :index
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
    end
    redirect_to :action => :index
  end

end
