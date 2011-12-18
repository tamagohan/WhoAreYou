class Twitter < ActiveRecord::Base
  belongs_to :account
  has_many   :tweets

  after_destroy :tw_auth_session_destroy

  def tw_auth_session_destroy
    session[:oauth] = nil
  end
end
