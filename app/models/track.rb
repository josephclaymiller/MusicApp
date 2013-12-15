class Track < ActiveRecord::Base
  attr_accessible :title, :album_id, :lyrics, :type
  
  belongs_to(
    :album,
    :primary_key => :id,
    :foreign_key => :album_id,
    :class_name => "Album"
  )
end
