class DispatchesController < ApplicationController
  
  before_filter :authorize_admin!
  
  layout "application", :except => [:print]
  
  def print
    @dispatch = Dispatch.find(params[:id])
  end
  
  # GET /dispatches
  # GET /dispatches.xml
  def index
    @dispatches = Dispatch.order("id desc").page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @dispatches }
    end
  end

  # GET /dispatches/1
  # GET /dispatches/1.xml
  def show
    @dispatch = Dispatch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @dispatch }
    end
  end

  # GET /dispatches/new
  # GET /dispatches/new.xml
  def new
    @dispatch = Dispatch.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @dispatch }
    end
  end

  # GET /dispatches/1/edit
  def edit
    @dispatch = Dispatch.find(params[:id])
  end

  # POST /dispatches
  # POST /dispatches.xml
  def create
    @dispatch = Dispatch.new(params[:dispatch])

    respond_to do |format|
      if @dispatch.save
        format.html { redirect_to(@dispatch, :notice => 'Dispatch was successfully created.') }
        format.xml  { render :xml => @dispatch, :status => :created, :location => @dispatch }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @dispatch.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /dispatches/1
  # PUT /dispatches/1.xml
  def update
    @dispatch = Dispatch.find(params[:id])

    respond_to do |format|
      if @dispatch.update_attributes(params[:dispatch])
        format.html { redirect_to(@dispatch, :notice => 'Dispatch was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @dispatch.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /dispatches/1
  # DELETE /dispatches/1.xml
  def destroy
    @dispatch = Dispatch.find(params[:id])
    @dispatch.destroy

    respond_to do |format|
      format.html { redirect_to(dispatches_url) }
      format.xml  { head :ok }
    end
  end
end
