module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_filter :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    extra_fields = [:name]
    devise_parameter_sanitizer.for(:sign_up) << extra_fields
    devise_parameter_sanitizer.for(:account_update) << extra_fields
  end
end

DeviseController.send :include, DevisePermittedParameters
