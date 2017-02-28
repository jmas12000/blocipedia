class Wiki < ActiveRecord::Base
  belongs_to :user
  accepts_nested_attributes_for :user
  
  default_scope { order('created_at DESC') }
end
