# -*- encoding : utf-8 -*-
class RegistrationsController < ApplicationController
  prepend_before_filter :require_no_authentication, :only => [ :new, :create ]
  prepend_before_filter :authenticate_scope!, :only => [:edit, :update, :destroy]
  include Devise::Controllers::InternalHelpers

  # GET /resource/sign_up
  def new
    build_resource({})
    render_with_scope :new
  end

  # POST /resource/sign_up
  def create
    build_resource

    if resource.save
      set_flash_message :notice, :signed_up
      coupon = Coupon.new_for_register(resource)
      flash[:info] = resource.email
      #sign_in_and_redirect(resource_name, resource)
      #sign_in(resource_name, resource)
      redirect_to after_inactive_sign_up_path_for(resource)
    else
      clean_up_passwords(resource)
      render_with_scope :new
    end
  end

  # GET /resource/edit
  def edit
    render_with_scope :edit
  end

  # PUT /resource
  def update
    # czhang changed code on 2011-1-24 to allow user edit their profile info without providing password
    # by following https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-edit-their-account-without-providing-a-password
    # instructions "an alternate strategy".  When necessary, can change the code "if resource.update_attributes"  
    # back to "if resource.update_with_password(params[resource_name])" to enable password protection again.  
    if resource.update_attributes(params[resource_name])
      set_flash_message :notice, :updated
      redirect_to after_update_path_for(resource)
    else
      clean_up_passwords(resource)
      render_with_scope :edit
    end
  end

  # DELETE /resource
  def destroy
    resource.destroy
    set_flash_message :notice, :destroyed
    sign_out_and_redirect(self.resource)
  end

  protected

    # Authenticates the current scope and gets a copy of the current resource.
    # We need to use a copy because we don't want actions like update changing
    # the current user in place.
    def authenticate_scope!
      send(:"authenticate_#{resource_name}!")
      self.resource = resource_class.find(send(:"current_#{resource_name}").id)
    end
        
    def after_update_path_for(resource)
      '/my/account' # You can put whatever path you want here
    end
    
    def after_sign_up_path_for(resource)
      '/users/welcome'
    end
      
    def after_inactive_sign_up_path_for(resource)
      '/users/confirmation/new'
    end
end
