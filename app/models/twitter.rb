class Twitter < ActiveRecord::Base
  belongs_to :account
  has_many   :tweets

end
