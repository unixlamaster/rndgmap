class Mapobj < ActiveRecord::Base
  belongs_to :type_obj, :class_name => 'TypeObj', :foreign_key => 'type_id'
  belongs_to :area, :class_name => 'Area', :foreign_key => 'area_id'
  geocoded_by :address
  after_validation :geocode          # auto-fetch coordinates
end
