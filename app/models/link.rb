class Link < ActiveRecord::Base
  belongs_to :exhibition
  belongs_to :exhibition_including_deleted, :class_name => 'Exhibition', :foreign_key => 'exhibition_id', :with_deleted => true

  belongs_to :artist
  belongs_to :artist_including_deleted, :class_name => 'Artist', :foreign_key => 'artist_id', :with_deleted => true

  # API
  JSON_ATTRS = ['uuid', 'created_at', 'updated_at', 'deleted_at', 'title', 'url'].freeze

  # Soft delete
  acts_as_paranoid

  # UUID
  before_create :set_uuid

  # Validations
  validates :exhibition_id, :presence => true
  validates :artist_id, :presence => true
  validates :title, :presence => true
  validates :url, :presence => true

  def as_json(options=nil)
    attributes.slice(*JSON_ATTRS).merge({
      :exhibition_uuid => exhibition_including_deleted.uuid,
      :artist_uuid => artist_including_deleted.uuid
    })
  end

  private
    def set_uuid
      self.uuid = UUIDTools::UUID.timestamp_create().to_s
    end
end