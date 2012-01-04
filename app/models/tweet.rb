# -*- coding: utf-8 -*-
class Tweet < ActiveRecord::Base
  require 'yahoo_api'
  include YahooApi

  belongs_to :twitter
  before_create :analyze_emotion
  after_create :create_av_tweet

  def analyze_emotion
    self.emotion = 0.0
    result = [ ]
    result << YahooApi::MorphologicalAnalysis.new.get(self.tw_str)
    result.flatten!.each do |hash|
      if hash[:pos] == '形容詞' or hash[:pos] == '副詞' or hash[:pos] == '名詞' or hash[:pos] == '動詞'
        e_word = EmotionalWord.find_by_word(hash[:word])
        self.emotion = self.emotion + e_word.semantic_orientation unless e_word.nil?
      end
    end
  end

  def create_av_tweet
    av_twitter = self.twitter.account.avatar.avatar_twitter
    unless av_twitter.nil?
      av_tw = AvatarTweet.new
      av_tw.avatar_twitter = av_twitter
      av_tw.tw_av_str = self.tw_str
      av_tw.tw_av_image_url = self.tw_image_url
      av_tw.save
    end
  end
end
