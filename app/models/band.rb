class Band < ActiveRecord::Base
  attr_accessible :name
  
  has_many(
    :albums,
    :primary_key => :id,
    :foreign_key => :band_id,
    :class_name => "Album",
    :dependent => :destroy
  )
end
