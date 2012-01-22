class Account < ActiveRecord::Base
  has_one :avatar
  has_one :twitter
  has_many :answers

  ADMIN_ROLE = 0
  acts_as_authentic do |c|
    c.maintain_sessions = false
  end

  def is_administrator
    return self.role == ADMIN_ROLE
  end
end
