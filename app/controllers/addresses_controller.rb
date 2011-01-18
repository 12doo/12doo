class AddressesController < ApplicationController
  # 身份验证
  before_filter :authorize_user!
  
  def index
  end

  def show
    @address = Address.find(params[:id])
    unless @address.user_id == current_user.id
      redirect_to :action => "index"
    end
  end

  def new
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
    unless @address.user_id == current_user.id
      redirect_to :action => "index"
    end
  end

  def create
    @address = Address.new(params[:address])
    @address.user_id = current_user.id
    
    respond_to do |format|
      if @address.save
        if params[:default] == "true"
          @address.set_as_default
        else
          @address.default = false
          @address.save
        end
        format.html { redirect_to :action => "index" }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.user_id == current_user.id
      respond_to do |format|
        if @address.update_attributes(params[:address])
          if params[:default] == "true"
            @address.set_as_default
          else
            @address.default = false
            @address.save
          end
          format.html { redirect_to :action => "index" }
        else
          format.html { render :action => "edit" }
        end
      end
    else
      redirect_to :action => "index"
    end
  end

  def destroy
    @address = Address.find(params[:id])
    if @address.user_id == current_user.id
      @address.destroy
    end
    redirect_to :action => "index"
  end
end
