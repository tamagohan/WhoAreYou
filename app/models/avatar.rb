class Avatar < ActiveRecord::Base
  belongs_to :account
  has_one    :avatar_twitter
  has_one    :growth_log
  has_and_belongs_to_many :items

  MALE   = 0
  FEMALE = 1
end
