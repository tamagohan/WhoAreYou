class Twitter < ActiveRecord::Base
  belongs_to :account
  has_many   :tweets

  after_create :create_avatar_twitter

  def create_avatar_twitter
    avatar = self.account.avatar
    if avatar && avatar.avatar_twitter.nil?
      av_tw = AvatarTwitter.new()
      av_tw.avatar = avatar
      av_tw.twitter_name = avatar.name
      av_tw.save

      avatar.image_url = "/images/avatar2.jpg"
      twitter_primer = Item.find_by_item_type(1)
      avatar.items.push(twitter_primer)
      avatar.save
    end
  end

end
