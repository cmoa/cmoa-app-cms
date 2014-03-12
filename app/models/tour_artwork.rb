class TourArtwork < ActiveRecord::Base
  belongs_to :exhibition
  belongs_to :exhibition_including_deleted, :class_name => 'Exhibition', :foreign_key => 'exhibition_id', :with_deleted => true

  belongs_to :tour
  belongs_to :tour_including_deleted, :class_name => 'Tour', :foreign_key => 'tour_id', :with_deleted => true

  belongs_to :artwork
  belongs_to :artwork_including_deleted, :class_name => 'Artwork', :foreign_key => 'artwork_id', :with_deleted => true

  # API
  JSON_ATTRS = ['uuid', 'created_at', 'updated_at', 'deleted_at', 'position'].freeze

  # Soft delete
  acts_as_paranoid

  # UUID
  before_create :set_uuid

  def as_json(options=nil)
    attributes.slice(*JSON_ATTRS).merge({
      :exhibition_uuid => exhibition_including_deleted.uuid,
      :tour_uuid => tour_including_deleted.uuid,
      :artwork_uuid => artwork_including_deleted.uuid
    })
  end

  private
    def set_uuid
      self.uuid = UUIDTools::UUID.timestamp_create().to_s
    end
end