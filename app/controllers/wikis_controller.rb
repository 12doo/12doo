# -*- encoding : utf-8 -*-
class WikisController < ApplicationController
  
  # 身份验证
  before_filter :authorize_admin!, :except => [:show]
  
  def index
    @wikis = Wiki.order("id desc").page(params[:page])
  end

  def show
    @wiki = Wiki.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @wiki }
    end
  end

  def new
    @wiki = Wiki.new
    @wiki.category = params[:category]
    @wiki.title = params[:title]
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end
  
  def edit_item
    wiki = Wiki.where(:category => params[:category], :title => params[:title]).first
    respond_to do |format|
      if wiki
        format.html { redirect_to :action=> "edit", :id => wiki.id }
      else
        format.html { redirect_to :action=> "new", :category => params[:category], :title => params[:title] }
      end
    end
  end

  def create
    @wiki = Wiki.new(params[:wiki])

    respond_to do |format|
      if @wiki.save
        format.html { redirect_to(@wiki, :notice => 'Wiki was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @wiki = Wiki.find(params[:id])

    respond_to do |format|
      if @wiki.update_attributes(params[:wiki])
        format.html { redirect_to(@wiki, :notice => 'Wiki was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wiki.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    @wiki.destroy

    respond_to do |format|
      format.html { redirect_to(wikis_url) }
      format.xml  { head :ok }
    end
  end
end
