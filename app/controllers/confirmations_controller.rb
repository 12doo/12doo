class ConfirmationsController < ApplicationController
  # prepend_before_filter :require_no_authentication, :only => [ :new, :create ]
  # prepend_before_filter :authenticate_scope!, :only => [:edit, :update, :destroy]
  include Devise::Controllers::InternalHelpers

  # GET /resource/confirmation/new
  def new
    build_resource({})
    @email = flash[:info]
    render_with_scope :new
  end

  # POST /resource/confirmation
  def create
    self.resource = resource_class.send_confirmation_instructions(params[resource_name])

    if successful_and_sane?(resource)
      set_flash_message(:notice, :send_instructions) if is_navigational_format?
      flash[:info] = resource.email
      respond_with({}, :location => after_resending_confirmation_instructions_path_for(resource_name))
    else
      respond_with_navigational(resource){ render_with_scope :new }
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with_navigational(resource){ redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      respond_with_navigational(resource.errors, :status => :unprocessable_entity){ render_with_scope :new }
    end
  end

  protected

    # The path used after resending confirmation instructions.
    def after_resending_confirmation_instructions_path_for(resource_name)
      #new_session_path(resource_name)
      '/users/confirmation/new'
    end

    # The path used after confirmation.
    def after_confirmation_path_for(resource_name, resource)
      '/users/welcome'
      #redirect_location(resource_name, resource)
    end

end