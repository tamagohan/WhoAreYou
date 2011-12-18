# -*- coding: utf-8 -*-
class AvatarsController < ApplicationController
  before_filter :require_account, :only => [:show, :edit, :update, :destroy]
  before_filter :require_admin, :only => [:index]

  # GET /avatars
  # GET /avatars.xml
  def index
    @avatars = Avatar.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @avatars }
    end
  end

  # GET /avatars/1
  # GET /avatars/1.xml
  def show
    @avatar = Avatar.find(params[:id])
    @age = (Time.now.utc - @avatar.birthday).divmod(24*60*60)[0]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @avatar }
    end
  end

  # GET /avatars/new
  # GET /avatars/new.xml
  def new
    @avatar = Avatar.new
    @accounts = Account.all.delete_if{|account| !account.avatar.nil?}.map{|account| [account.login, account.id]}
    @sex_list = { '♂' => Avatar::MALE, '♀' => Avatar::FEMALE }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @avatar }
    end
  end

  # GET /avatars/1/edit
  def edit
    @avatar = Avatar.find(params[:id])
    @accounts = [[@avatar.account.login, @avatar.account.id]]
    @sex_list = { '♂' => Avatar::MALE, '♀' => Avatar::FEMALE }
  end

  # POST /avatars
  # POST /avatars.xml
  def create
    unless current_account.is_administrator
      params[:avatar][:account_id] = current_account.id
    end
    @avatar = Avatar.new(params[:avatar])
    @avatar.birthday = Time.now.utc
    @avatar.image_url = "/images/pityu.jpg"

    respond_to do |format|
      if @avatar.save
        format.html { redirect_to(@avatar, :notice => 'アバターが誕生しました！') }
        format.xml  { render :xml => @avatar, :status => :created, :location => @avatar }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @avatar.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /avatars/1
  # PUT /avatars/1.xml
  def update
    @avatar = Avatar.find(params[:id])
    params[:avatar].delete(:account_id)

    respond_to do |format|
      if @avatar.update_attributes(params[:avatar])
        format.html { redirect_to(@avatar, :notice => 'Avatar was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @avatar.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /avatars/1
  # DELETE /avatars/1.xml
  def destroy
    @avatar = Avatar.find(params[:id])
    @avatar.destroy

    respond_to do |format|
      format.html { redirect_to(avatars_url) }
      format.xml  { head :ok }
    end
  end

  private

  def require_account
    if current_account.nil?
      store_location
      flash[:notice] = 'ログインしてください。'
      redirect_to new_account_session_url
      return false
    elsif !current_account.is_administrator and Avatar.find(params[:id]).account != current_account
      redirect_to current_account
      return false
    end
  end
end
