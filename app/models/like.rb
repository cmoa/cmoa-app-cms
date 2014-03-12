class Like < ActiveRecord::Base
  belongs_to :exhibition
  belongs_to :exhibition_including_deleted, :class_name => 'Exhibition', :foreign_key => 'exhibition_id', :with_deleted => true

  belongs_to :artwork
  belongs_to :artwork_including_deleted, :class_name => 'Artwork', :foreign_key => 'artwork_id', :with_deleted => true

  validates :exhibition_id, :presence => true
  validates :artwork_id, :presence => true
  validates :device, :presence => true
  validates_uniqueness_of :artwork_id, :scope => :device
end