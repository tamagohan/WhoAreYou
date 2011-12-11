class Avatar < ActiveRecord::Base
  belongs_to :account
  has_one    :avatar_twitter

  MALE   = 0
  FEMALE = 1
end
