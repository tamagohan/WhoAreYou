require 'oauth'
require 'rubytter'

class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

  protected
  def consumer
    OAuth::Consumer.new(
      '0SyImxfqzhNJXCYSXFTk2Q',
      'd2y1MRqXQLSutSozHUGF9FsTNDhN6bNwWZOAb14Ku2k',
      { :site => "http://api.twitter.com" }
    )
  end
end
