# -*- coding: utf-8 -*-
class AccountsController < ApplicationController
  before_filter :require_no_account, :only => [:new, :create]
  before_filter :require_account, :only => [:destroy, :show, :edit, :update]
  before_filter :require_admin, :only => [:index]

  # GET /accounts
  # GET /accounts.xml
  def index
    @accounts = Account.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @accounts }
    end
  end

  # GET /accounts/1
  # GET /accounts/1.xml
  def show
    @account = Account.find(params[:id])

     respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @account }
    end

  end

  # GET /accounts/new
  # GET /accounts/new.xml
  def new
    @account = Account.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @account }
    end
  end

  # GET /accounts/1/edit
  def edit
    @account = Account.find(params[:id])

  end

  # POST /accounts
  # POST /accounts.xml
  def create
    @account = Account.new(params[:account])
    @account.role = 1


    respond_to do |format|
      if @account.save
        format.html { redirect_to(new_account_session_path, :notice => 'アカウントの作成に成功しました。下記フォームからログインして下さい。') }
        format.xml  { render :xml => @account, :status => :created, :location => @account }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /accounts/1
  # PUT /accounts/1.xml
  def update
    @account = Account.find(params[:id])
    params[:account].delete(:role)

    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to(@account, :notice => 'Account was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.xml
  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to(accounts_url) }
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
    elsif !current_account.is_administrator and Account.find(params[:id]) != current_account

      redirect_to current_account
      return false
    end
  end

end
