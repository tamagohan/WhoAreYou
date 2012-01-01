require 'test_helper'

class TweetTest < ActiveSupport::TestCase

  test "should create both new tweet and avatar_tweet" do
    general_user = accounts(:anatta_test_bot)
    avatar = general_user.avatar
    tweet = Tweet.new()
    tweet.twitter_id = general_user.twitter.id
    tweet.tw_id = 1
    tweet.tw_str = 'test'
    tweet.tw_image_url = 'test/url'

    assert_difference('Tweet.count') do
      assert_difference('AvatarTweet.count') do
        tweet.save
      end
    end

    av_tweet = AvatarTweet.last
    assert_equal avatar.avatar_twitter, av_tweet.avatar_twitter
    assert_equal tweet.tw_str, av_tweet.tw_av_str
    assert_equal tweet.tw_image_url, av_tweet.tw_av_image_url
  end
end
