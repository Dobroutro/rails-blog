class ItemsTag < ActiveRecord::Base
  has_many :tags
  has_many :items
end
