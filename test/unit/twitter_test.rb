require 'test_helper'

class TwitterTest < ActiveSupport::TestCase

  test "should create both new twitter and avatar_twitter" do
    general_user = accounts(:not_has_twitter)
    avatar = general_user.avatar
    tw = Twitter.new()
    tw.account = general_user
    assert_difference('Twitter.count') do
      assert_difference('AvatarTwitter.count') do
        tw.save
      end
    end

    assert_equal avatar, AvatarTwitter.last.avatar
    assert_equal avatar.name, AvatarTwitter.last.twitter_name
  end
end
