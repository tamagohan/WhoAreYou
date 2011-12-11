# -*- coding: utf-8 -*-
class AccountSessionsController < ApplicationController
#  layout 'account'

 def new
   if current_account_session
     current_account_session.destroy
   end
   @account_session = AccountSession.new
   respond_to do |format|
     format.html # new.html.erb
     format.xml  { render :xml => @account }
   end
 end

  # login
  def create
    reset_session
    @account_session = AccountSession.new(params[:account_session])
    if @account_session.save
      unless current_account.twitter.nil?
        tw = current_account.twitter
        session[:oauth] = true
        session[:oauth_token] = tw.oauth_token
        session[:oauth_verifier] = tw.oauth_verifier
      end
      flash[:notice] = "ログインしました。"
      redirect_back_or_default account_url(current_account)
      return
    else
      flash[:notice] = "ログインに失敗しました。"
      render :action => :new
      return
    end
  end

  # logout
  def destroy
    reset_session
    current_account_session.destroy
    flash[:notice] = "ログアウトしました。"
    redirect_to new_account_session_url
    return
  end
end
