class Tag < ActiveRecord::Base
  has_and_belongs_to_many :items
  has_many :items_tags

  validates :name, presence: true, length: { minimum: 3, maximum: 255 }    
end
