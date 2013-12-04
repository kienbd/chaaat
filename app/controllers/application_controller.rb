class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  require 'pry'
  before_filter :anti_spam

  private


end
