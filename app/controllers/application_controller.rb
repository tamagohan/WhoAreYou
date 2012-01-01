# -*- coding: utf-8 -*-
require 'oauth'
require 'rubytter'

class ApplicationController < ActionController::Base
 helper_method :current_account_session, :current_account

  private
  def current_account_session
    return @current_account_session if defined?(@current_account_session)
    @current_account_session = AccountSession.find
  end

  def current_account
    return @current_account if defined?(@current_account)
    @current_account = current_account_session && current_account_session.account
  end
  helper :all
  protect_from_forgery

  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end



  def require_admin
    if current_account.nil?
      store_location
      flash[:notice] = 'ログインしてください。'
      redirect_to new_account_session_url
      return false
    elsif !current_account.is_administrator
      redirect_to current_account
      return false
    end
  end

  def require_no_account
    if current_account
      store_location
      flash[:notice] = 'ログアウトしてください。'
      redirect_to account_url(current_account)
      return false
    end
  end

  protected
  def consumer
    OAuth::Consumer.new(
      AppConfig[:twitter_consumer_key],
      AppConfig[:twitter_consumer_secret],
      { :site => "http://api.twitter.com" }
    )
  end
end
