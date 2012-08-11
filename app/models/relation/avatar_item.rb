class Relation::AvatarItem < ActiveRecord::Base
  belongs_to :avatar
  belongs_to :item

  scope :nonzero, where("#{self.table_name}.quantity > 0")

  delegate :name, to: :item
end
