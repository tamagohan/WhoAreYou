class Tweet < ActiveRecord::Base
  belongs_to :twitter
  after_create :create_av_tweet

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
