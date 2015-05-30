class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # TODO: the flash sometimes contains user editable content, so come up with a
  # better way of handling links without having to do the whole flash as html_safe
  before_action lambda {
    flash.now[:notice] = flash[:notice].html_safe if flash[:html_safe] && flash[:notice]
  }
end
