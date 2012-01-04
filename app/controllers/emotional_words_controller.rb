class EmotionalWordsController < ApplicationController
  # GET /emotional_words
  # GET /emotional_words.xml
  def index
    @emotional_words = EmotionalWord.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @emotional_words }
    end
  end

  # GET /emotional_words/1
  # GET /emotional_words/1.xml
  def show
    @emotional_word = EmotionalWord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @emotional_word }
    end
  end

  # GET /emotional_words/new
  # GET /emotional_words/new.xml
  def new
    @emotional_word = EmotionalWord.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @emotional_word }
    end
  end

  # GET /emotional_words/1/edit
  def edit
    @emotional_word = EmotionalWord.find(params[:id])
  end

  # POST /emotional_words
  # POST /emotional_words.xml
  def create
    @emotional_word = EmotionalWord.new(params[:emotional_word])

    respond_to do |format|
      if @emotional_word.save
        format.html { redirect_to(@emotional_word, :notice => 'Emotional word was successfully created.') }
        format.xml  { render :xml => @emotional_word, :status => :created, :location => @emotional_word }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @emotional_word.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /emotional_words/1
  # PUT /emotional_words/1.xml
  def update
    @emotional_word = EmotionalWord.find(params[:id])

    respond_to do |format|
      if @emotional_word.update_attributes(params[:emotional_word])
        format.html { redirect_to(@emotional_word, :notice => 'Emotional word was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @emotional_word.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /emotional_words/1
  # DELETE /emotional_words/1.xml
  def destroy
    @emotional_word = EmotionalWord.find(params[:id])
    @emotional_word.destroy

    respond_to do |format|
      format.html { redirect_to(emotional_words_url) }
      format.xml  { head :ok }
    end
  end
end
