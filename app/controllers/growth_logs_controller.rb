class GrowthLogsController < ApplicationController
  before_filter :require_admin

  # GET /growth_logs
  # GET /growth_logs.xml
  def index
    @growth_logs = GrowthLog.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @growth_logs }
    end
  end

  # GET /growth_logs/1
  # GET /growth_logs/1.xml
  def show
    @growth_log = GrowthLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @growth_log }
    end
  end

  # GET /growth_logs/new
  # GET /growth_logs/new.xml
  def new
    @growth_log = GrowthLog.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @growth_log }
    end
  end

  # GET /growth_logs/1/edit
  def edit
    @growth_log = GrowthLog.find(params[:id])
  end

  # POST /growth_logs
  # POST /growth_logs.xml
  def create
    @growth_log = GrowthLog.new(params[:growth_log])

    respond_to do |format|
      if @growth_log.save
        format.html { redirect_to(@growth_log, :notice => 'Growth log was successfully created.') }
        format.xml  { render :xml => @growth_log, :status => :created, :location => @growth_log }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @growth_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /growth_logs/1
  # PUT /growth_logs/1.xml
  def update
    @growth_log = GrowthLog.find(params[:id])

    respond_to do |format|
      if @growth_log.update_attributes(params[:growth_log])
        format.html { redirect_to(@growth_log, :notice => 'Growth log was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @growth_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /growth_logs/1
  # DELETE /growth_logs/1.xml
  def destroy
    @growth_log = GrowthLog.find(params[:id])
    @growth_log.destroy

    respond_to do |format|
      format.html { redirect_to(growth_logs_url) }
      format.xml  { head :ok }
    end
  end
end
