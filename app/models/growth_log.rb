class GrowthLog < ActiveRecord::Base
  belongs_to :avatar

  TWEETABLE = 1
end
