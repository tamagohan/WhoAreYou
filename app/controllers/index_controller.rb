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
#      @friends_timelines = rubytter.friends_timeline()
      @friends_timelines = rubytter.user_timeline('tamagohan_high')
    end
  end

  def oauth
     #Twitterから未認可のrequest tokenを発行してもらう
     request_token = self.consumer.get_request_token(
      #コールバックURLの指定
       :oauth_callback => "http://#{request.host_with_port}/callback"
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
    session[:request_token] = nil
    session[:request_token_secret] = nil
    session[:oauth] = true
    session[:oauth_token] = access_token.token
    session[:oauth_verifier] = access_token.secret
    redirect_to :action => :index
  end

end
