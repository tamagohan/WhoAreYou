class AvatarTweet < ActiveRecord::Base
  require 'yahoo_api'
  include YahooApi

  belongs_to :avatar_twitter
  before_create :replace_webunit

  def replace_webunit
    keyphrases = YahooApi::Keyphrase.new.get(self.tw_av_str)
    keyphrases.each do |phrase|
      webunit = YahooApi::Webunit.new.get(phrase[:text]) unless phrase[:text].nil?
      unless webunit.nil?
        self.tw_av_str.sub!(phrase[:text], webunit.split(' ').last)
        break
      end
    end
  end

end
