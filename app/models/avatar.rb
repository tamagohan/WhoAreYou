class Avatar < ActiveRecord::Base
  belongs_to :account
  has_one    :avatar_twitter
  has_one    :growth_log
#  has_and_belongs_to_many :items
  has_many :avatar_items, class_name: 'Relation::AvatarItem', dependent: :destroy

  MALE   = 0
  FEMALE = 1

  def items
    self.avatar_items.nonzero.includes(:item)
  end
  
  def store_item(item, by=1)
    stack = self.avatar_items.where(item_id: item.id).first_or_create!
    stack.increment!(:quantity, by)
  end
end
