class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  require 'pry'
  before_filter :anti_spam

  after_filter :user_activity

  private

  def user_activity
    current_user.try :touch
  end
end
