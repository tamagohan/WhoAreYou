class AvatarTwitter < ActiveRecord::Base
  belongs_to :avatar
  has_many   :avatar_tweets

  after_create :create_growth_log

  def create_growth_log
    id = self.avatar.id
    log = GrowthLog.new(:avatar_id => id, :growth_type => GrowthLog::TWEETABLE)
    log.save
  end
end

