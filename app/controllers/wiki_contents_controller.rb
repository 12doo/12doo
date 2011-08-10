# -*- encoding : utf-8 -*-
class WikiContentsController < ApplicationController
  
  # 身份验证
  before_filter :authorize_admin!
  
  # GET /wiki_contents
  # GET /wiki_contents.xml
  def index
    @wiki_contents = WikiContent.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @wiki_contents }
    end
  end

  # GET /wiki_contents/1
  # GET /wiki_contents/1.xml
  def show
    @wiki_content = WikiContent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @wiki_content }
    end
  end

  # GET /wiki_contents/new
  # GET /wiki_contents/new.xml
  def new
    @wiki_content = WikiContent.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @wiki_content }
    end
  end

  # GET /wiki_contents/1/edit
  def edit
    @wiki_content = WikiContent.find(params[:id])
  end

  # POST /wiki_contents
  # POST /wiki_contents.xml
  def create
    @wiki_content = WikiContent.new(params[:wiki_content])

    respond_to do |format|
      if @wiki_content.save
        format.html { redirect_to(@wiki_content, :notice => 'Wiki content was successfully created.') }
        format.xml  { render :xml => @wiki_content, :status => :created, :location => @wiki_content }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @wiki_content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /wiki_contents/1
  # PUT /wiki_contents/1.xml
  def update
    @wiki_content = WikiContent.find(params[:id])

    respond_to do |format|
      if @wiki_content.update_attributes(params[:wiki_content])
        format.html { redirect_to(@wiki_content, :notice => 'Wiki content was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wiki_content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /wiki_contents/1
  # DELETE /wiki_contents/1.xml
  def destroy
    @wiki_content = WikiContent.find(params[:id])
    @wiki_content.destroy

    respond_to do |format|
      format.html { redirect_to(wiki_contents_url) }
      format.xml  { head :ok }
    end
  end
end
