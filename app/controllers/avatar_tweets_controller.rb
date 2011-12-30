# -*- coding: utf-8 -*-
class AvatarTweetsController < ApplicationController
  before_filter :require_admin

  require 'yahoo_api'
  include YahooApi

  # GET /avatar_tweets
  # GET /avatar_tweets.xml
  def index
    @avatar_tweets = AvatarTweet.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @avatar_tweets }
    end
  end

  # GET /avatar_tweets/1
  # GET /avatar_tweets/1.xml
  def show
    @avatar_tweet = AvatarTweet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @avatar_tweet }
    end
  end

  # GET /avatar_tweets/new
  # GET /avatar_tweets/new.xml
  def new
    @avatar_tweet = AvatarTweet.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @avatar_tweet }
    end
  end

  # GET /avatar_tweets/1/edit
  def edit
    @avatar_tweet = AvatarTweet.find(params[:id])
  end

  # POST /avatar_tweets
  # POST /avatar_tweets.xml
  def create
    @avatar_tweet = AvatarTweet.new(params[:avatar_tweet])

    respond_to do |format|
      if @avatar_tweet.save
        format.html { redirect_to(@avatar_tweet, :notice => 'Avatar tweet was successfully created.') }
        format.xml  { render :xml => @avatar_tweet, :status => :created, :location => @avatar_tweet }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @avatar_tweet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /avatar_tweets/1
  # PUT /avatar_tweets/1.xml
  def update
    @avatar_tweet = AvatarTweet.find(params[:id])

    respond_to do |format|
      if @avatar_tweet.update_attributes(params[:avatar_tweet])
        format.html { redirect_to(@avatar_tweet, :notice => 'Avatar tweet was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @avatar_tweet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /avatar_tweets/1
  # DELETE /avatar_tweets/1.xml
  def destroy
    @avatar_tweet = AvatarTweet.find(params[:id])
    @avatar_tweet.destroy

    respond_to do |format|
      format.html { redirect_to(avatar_tweets_url) }
      format.xml  { head :ok }
    end
  end

end
