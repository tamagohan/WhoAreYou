class AvatarTwitter < ActiveRecord::Base
  belongs_to :avatar
  has_many   :avatar_tweets
end
